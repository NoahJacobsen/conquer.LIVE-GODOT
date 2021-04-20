extends YSort

export(Resource) var map
export(bool) var edit_mode

const TILE_SIZE = 32
const TILE_SCENES = {
	"water": preload("res://objects/tiles/water_tile.tscn"),
	"beach": preload("res://objects/tiles/beach_tile.tscn"),
	"forest": preload("res://objects/tiles/forest_tile.tscn"),
	"dense_forest": preload("res://objects/tiles/dense_forest_tile.tscn"),
	"hill": preload("res://objects/tiles/hill_tile.tscn"),
	"mountain": preload("res://objects/tiles/mountain_tile.tscn"),
	"desert": preload("res://objects/tiles/desert_tile.tscn"),
	"oasis": preload("res://objects/tiles/oasis_tile.tscn"),
	"editor_empty": preload("res://objects/tiles/editor_empty_tile.tscn")
}
const EDITOR_GRID_SIZE = Vector2(25,25)
const CAMERA_BOUNDS_MARGIN = 64

export(Dictionary) var tile_list = {}

var grid_size = Vector2(0,0)

func _ready():
	if edit_mode:
		grid_size = EDITOR_GRID_SIZE
		_create_editor_grid()
	else:
		grid_size = map.get_size()
		for y in range(grid_size.y):
			for x in range(grid_size.x):
				var tile_type = map.get_tile(x,y)
				var tile = TILE_SCENES[tile_type].instance()
				_add_tile(x, y, tile)

func _create_editor_grid():
		for y in range(grid_size.y):
			for x in range(grid_size.x):
				var tile = TILE_SCENES["water"].instance()
				_add_tile(x, y, tile)

func _add_tile(x, y, tile):
	var alternate = false if x%2 == 0 else true
	var id = String(x) + ":" + String(y)
	$Tiles.add_child(tile)
	tile.tile_id = id
	tile_list[id] = tile.tile_type
	if alternate:
		tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE + TILE_SIZE/2)
	else:
		tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE)

func get_selected_type():
	if edit_mode:
		return self.get_parent().selected_tile

func update_tile_type(id, new_type):
	var tile = TILE_SCENES[new_type].instance()
	var id_array = id.split(":")
	_add_tile(int(id_array[0]), int(id_array[1]), tile)
	
func calculate_camera_bounds():
	return Rect2(Vector2(-CAMERA_BOUNDS_MARGIN, -CAMERA_BOUNDS_MARGIN), grid_size + Vector2(CAMERA_BOUNDS_MARGIN, CAMERA_BOUNDS_MARGIN)*2)
