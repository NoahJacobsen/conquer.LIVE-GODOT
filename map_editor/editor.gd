extends Node2D

const TILE_SIZE = 32
const EDITOR_TILE_SCENE = preload("res://map_editor/editor_tile.tscn")
const EDITOR_GRID_SIZE = Vector2(25,25)  # Make this changeable later

export(Resource) var map
export(bool) var edit_mode

onready var game_controller = get_tree().get_nodes_in_group("game_controller")[0]
onready var tile_map_atlas = game_controller.tile_map_atlas
onready var grid = $Grid

var selected_tile = "water"
var interface_focused = false

func _ready():
	grid.tile_size = TILE_SIZE
	grid.generate_grid()


func serialize_tile_data():
	var grid_size = EDITOR_GRID_SIZE
	var tile_data_raw = $Grid.tile_list
	var data_keys = tile_data_raw.keys()
	var data_refined = []
	for i in range(grid_size.x):
		var row = []
		for j in range(grid_size.y):
			row.append([])
		data_refined.append(row)
	for key in data_keys:
		var index = key.split(":")
		data_refined[int(index[0])][int(index[1])] = tile_data_raw[key]
	return {
		"tiles": data_refined, 
		"flags": $Grid.flagged_tiles
		}


#
# INTERFACE INTERACTION FUNCS
#

func update_handle():
	$UILayer/InterfaceHandle.texture = tile_map_atlas[selected_tile]

func _on_InterfaceHandle_mouse_entered():
	if not interface_focused:
		focus_interface()

func focus_interface():
	interface_focused = true
	$UILayer/Interface.find_and_select_type()
	$InterfaceAnimations.play("ShowInterface")
	$UIFocusTimer.start()

func hide_interface():
	interface_focused = false
	$InterfaceAnimations.play("HideInterface")

func _on_UIFocusTimer_timeout():
	if interface_focused && $UILayer/Interface.get_rect().has_point(get_viewport().get_mouse_position()):
		pass
	else:
		hide_interface()

func _on_Interface_mouse_exited():
	$UIFocusTimer.start()
	
func copy_type(type):
	selected_tile = type
	update_handle()
	$UILayer/Interface.find_and_select_type()

func _on_SaveButton_pressed():
	var map_name = "example_map" # GET FROM TEXT INPUT BOX
	var file_name = map_name + ".tres"
	if not file_name.is_valid_filename():
		print("Invalid file name. Cannot save resource.")
		return
	var file_path = game_controller.verify_map_dir() + file_name
	# Ask to overwrite if file exists
	var map_res = Map.new()
	var data = serialize_tile_data()
	map_res.tile_data = data["tiles"]
	map_res.flags = data["flags"]
	map_res.name = map_name
	map_res.default = false
	print("Saving map [", map_name, "] to [", file_path, "]...")
	var ret = ResourceSaver.save(file_path, map_res)
	print("Save complete with code: ", ret)
