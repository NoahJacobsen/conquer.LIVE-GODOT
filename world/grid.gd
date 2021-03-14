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
const EDITOR_GRID_SIZE = 25


func _ready():
	if edit_mode:
		_create_editor_grid()
	else:
		for y in range(map.get_height()):
			for x in range(map.get_width()):
				var tile_type = map.get_tile(x,y)
				var tile = TILE_SCENES[tile_type].instance()
				var alternate = false if x%2 == 0 else true
				$Tiles.add_child(tile)
				if alternate:
					tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE + TILE_SIZE/2)
				else:
					tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE)


func _create_editor_grid():
	for y in range(EDITOR_GRID_SIZE):
			for x in range(EDITOR_GRID_SIZE):
				var tile = TILE_SCENES["editor_empty"].instance()
				var alternate = false if x%2 == 0 else true
				$Tiles.add_child(tile)
				if alternate:
					tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE + TILE_SIZE/2)
				else:
					tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE)
