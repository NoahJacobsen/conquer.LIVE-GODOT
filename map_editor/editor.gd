extends Node2D

const TILE_SIZE = 32
const TILE_SCENE = preload("res://objects/tiles/tile.tscn")
const EDITOR_GRID_SIZE = Vector2(25,25)  # Make this changeable later

export(Resource) var map
export(bool) var edit_mode

onready var grid = $Grid

var selected_tile = "water"

func _ready():
	grid.tile_size = TILE_SIZE
	grid.generate_grid()


func serialize_tile_data(map_name, path):
	var grid_size = $Grid.EDITOR_GRID_SIZE
	var tile_data_raw = $Grid.tile_list
	var data_keys = tile_data_raw.keys()
	var data_refined = []
	for i in range(grid_size):
		data_refined.append([])
	for key in data_keys:
		var index = key.split(":")
		data_refined[int(index[0])][int(index[1])] = tile_data_raw[key]
	return data_refined
