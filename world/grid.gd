extends YSort

export(Resource) var map

const TILE_SIZE = 32
const TILE_SCENES = {
	"water": preload("res://objects/tiles/water_tile.tscn")
}


func _ready():
	for y in range(map.get_height()):
		for x in range(map.get_width()):
			var tile_type = map.get_tile(x,y)
			var tile = TILE_SCENES[tile_type].instance()
			var alternate = false if x%2 == 0 else true
			$WaterTiles.add_child(tile)
			if alternate:
				tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE + TILE_SIZE/2)
			else:
				tile.position = Vector2(3*x*TILE_SIZE/4, y*TILE_SIZE)
			
