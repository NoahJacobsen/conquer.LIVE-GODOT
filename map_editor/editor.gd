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

func update_handle():
	$UILayer/InterfaceHandle.texture = tile_map_atlas[selected_tile]


func _on_InterfaceHandle_mouse_entered():
	if not interface_focused:
		focus_interface()

func focus_interface():
	interface_focused = true
	# Lerp or animate the switch here
	$InterfaceAnimations.play("ShowInterface")
	#$UILayer/Interface.rect_position = $UILayer/InterfaceFocusPos.position
	#$UILayer/InterfaceHandle.rect_position = $UILayer/HandleHidePos.position
	# Lerp above this
	$UIFocusTimer.start()

func hide_interface():
	interface_focused = false
	# Lerp this
	$InterfaceAnimations.play("HideInterface")
	#$UILayer/Interface.rect_position = $UILayer/InterfaceHidePos.position
	#$UILayer/InterfaceHandle.rect_position = $UILayer/HandleFocusPos.position
	# Lerp above

func _on_UIFocusTimer_timeout():
	print("Timeout")
	#Something wrong with checking if mouse in the rect
	if interface_focused && $UILayer/Interface.get_rect().has_point(get_viewport().get_mouse_position()):
		pass
	else:
		hide_interface()


func _on_Interface_mouse_exited():
	$UIFocusTimer.start()

