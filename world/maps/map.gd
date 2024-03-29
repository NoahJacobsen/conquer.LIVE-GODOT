extends Resource
class_name Map


export(String) var name
export(Array, Array, int) var tile_data
export(Dictionary) var flags
export(bool) var default

const TILE_TYPES = [
	"water",
	"beach",
	"forest",
	"dense_forest",
	"hill",
	"mountain",
	"desert",
	"oasis"
]

	
func get_size():
	return Vector2(tile_data.size(), tile_data[0].size())

func get_tile(x, y):
	var tile = int(tile_data[x][y])  # Returns as a String for some reason
	return TILE_TYPES[tile]
