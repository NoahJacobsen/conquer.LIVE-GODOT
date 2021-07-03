extends Node


const MAP_SAVE_PATH = "user://maps/"
const MAP_DEFAULTS_PATH = "res://world/maps/defaults/"
const WORLD_SCENE_PATH  = "res://world/world.tscn"
const EDITOR_SCENE_PATH = "res://map_editor/editor.tscn"
const MENUS = [
	"MainMenu",
	"GameMenu",
	"OptionsMenu"
]
const HIDE_MENU = "HIDE"

export(Rect2) var camera_bounds = Rect2(0,0,0,0)

onready var tile_map_atlas = {
	"water": 		load("res://new_tilemap/atlas/water_atlas.tres"),
	"beach": 		load("res://new_tilemap/atlas/beach_atlas.tres"),
	"forest": 		load("res://new_tilemap/atlas/forest_atlas.tres"),
	"dense_forest": load("res://new_tilemap/atlas/dense_forest_atlas.tres"),
	"hill": 		load("res://new_tilemap/atlas/hill_atlas.tres"),
	"mountain": 	load("res://new_tilemap/atlas/mountain_atlas.tres"),
	"desert": 		load("res://new_tilemap/atlas/desert_atlas.tres"),
	"oasis": 		load("res://new_tilemap/atlas/oasis_atlas.tres"),
	"flag":			load("res://new_tilemap/atlas/flag_atlas.tres")
}

var current_menu = "MainMenu"

func _ready():
	_add_game_space()

#
# CORE FUNCTIONS
#

# Helper function for deleting current games and editors
func _add_game_space():
	var GameSpace = Node2D.new()
	GameSpace.visible = false
	GameSpace.name = "GameSpace"
	self.add_child(GameSpace)

# Resets game state, to be used when returning to menu from game or editor
func reset_state():
	camera_bounds = Rect2(0,0,0,0)
	change_menu("MainMenu")
	$GameSpace.queue_free()
	_add_game_space()

# Quits game
func quit_game():
	get_tree().quit()



#
# MENU FUNCTIONS
#

# Hides the current menu and reveals the target menu. Can also hide menus when
#   constant HIDE_MENU is passed
func change_menu(menu):
	if current_menu in MENUS:
		get_node(current_menu).obscure()
	if menu != HIDE_MENU:
		get_node(menu).reveal()
	current_menu = menu

func open_editor():
	change_menu(HIDE_MENU)
	print("Opening editor...")
	var editor = preload(EDITOR_SCENE_PATH)
	var editor_instance = editor.instance()
	$GameSpace.add_child(editor_instance)
	$GameSpace.visible = true

func open_game():
	var game = preload(WORLD_SCENE_PATH)
	$GameSpace.add_child(game)
	$GameSpace.visible = true



func set_camera_bounds(bounds):
	camera_bounds = bounds
	print("Camera bounds set to: ", camera_bounds)



#
# SAVE FUNCTIONS
#
func verify_map_dir():
	var dir = Directory.new()
	if not dir.dir_exists(MAP_SAVE_PATH):
		print(MAP_SAVE_PATH, " does not exist, creating...")
		dir.make_dir_recursive(MAP_SAVE_PATH)
		# As map dir hasn't existed yet, install default maps
		print("Installing default maps...")
		dir.change_dir(MAP_DEFAULTS_PATH)
		var ret = dir.list_dir_begin(true)
		while true:
			var default = dir.get_next()
			if not default:
				break  # The stream has been closed
			print("Adding map: ", default)
			dir.copy(MAP_DEFAULTS_PATH + default, MAP_SAVE_PATH + default)
	return MAP_SAVE_PATH

func load_map(map):
	var path = MAP_SAVE_PATH + map + ".tres"
	print("Using path: ", path)
	return ResourceLoader.load(path, "Map")
