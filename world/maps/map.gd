extends Resource
class_name Map


export(String) var map_name
export(Array, Array, int) var tile_data


const TILE_TYPES = ["water", "beach", "forest", "dense_forest", "hills", "mountains", "desert", "oasis"]

func get_width():
	return tile_data.size()

func get_height():
	return tile_data[0].size()

func get_tile(x, y):
	var tile = int(tile_data[x][y])  # Returns as a String for some reason
	return TILE_TYPES[tile]
