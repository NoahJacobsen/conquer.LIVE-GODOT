extends YSort

export(Resource) var map

const TILE_SIZE = 32
const TILE_SCENES = {
	"water": preload("res://objects/tiles/water_tile.tscn")
}


func _ready():
	for x in range(map.get_width()):
		for y in range(map.get_height()):
			var tile_type = map.get_tile(x,y)
			var tile = TILE_SCENES[tile_type].instance()
			var alternate = false if y%2 == 0 else true
			$WaterTiles.add_child(tile)
			if alternate:
				tile.position = Vector2((x*TILE_SIZE-TILE_SIZE*.75) + TILE_SIZE/2*x, y*TILE_SIZE - TILE_SIZE/2)
			else:
				tile.position = Vector2(x*TILE_SIZE + TILE_SIZE/2*x, y*TILE_SIZE/2)
			
