extends YSort


const CAMERA_BOUNDS_MARGIN = 64


export(Dictionary) var tile_list = {}

onready var editor = get_parent()

var grid_size = Vector2(0,0)
var tile_size = 0

func generate_grid():
	if editor.edit_mode:
		grid_size = editor.EDITOR_GRID_SIZE
		_create_editor_grid()
	else:
		pass
#		grid_size = editor.map.get_size()
#		for y in range(grid_size.y):
#			for x in range(grid_size.x):
#				var tile_type = editor.map.get_tile(x,y)
#				var tile = editor.TILE_SCENES[tile_type].instance()
#				_add_tile(x, y, tile)

func _create_editor_grid():
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var tile = editor.EDITOR_TILE_SCENE.instance()
			var _ret = tile.connect("tile_pressed", self, "update_tile")
			_ret = tile.connect("tile_copied", editor, "copy_type")
			_add_tile(x, y, tile)

func _add_tile(x, y, tile):
	var alternate = false if x%2 == 0 else true
	var id = String(x) + ":" + String(y)
	$Tiles.add_child(tile)
	tile.id = id
	tile_list[id] = tile.type
	if alternate:
		tile.move(Vector2(3*x*tile_size/4, y*tile_size + tile_size/2))
	else:
		tile.move(Vector2(3*x*tile_size/4, y*tile_size))

func get_selected_type():
	if editor.edit_mode:
		return self.get_parent().selected_tile

func update_tile(tile):
	var new_type = get_selected_type()
	if tile.type != new_type:
		tile.type = new_type
		tile.change_texture(editor.tile_map_atlas[new_type])
		tile_list[tile.id] = new_type

