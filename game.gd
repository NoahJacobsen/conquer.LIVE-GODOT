extends Node

const WORLD_SCENE_PATH  = "res://world/world.tscn"
const EDITOR_SCENE_PATH = "res://map_editor/editor.tscn"
const MENUS = [
	"MainMenu",
	"GameMenu",
	"OptionsMenu"
]
const HIDE_MENU = "HIDE"

var current_menu = "MainMenu"

func _ready():
	_add_game_space()

func _add_game_space():
	var GameSpace = Node2D.new()
	GameSpace.visible = false
	GameSpace.name = "GameSpace"
	self.add_child(GameSpace)

func reset_state():
	change_menu("MainMenu")
	$GameSpace.queue_free()
	_add_game_space()

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

func change_menu(menu):
	if current_menu in MENUS:
		get_node(current_menu).visible = false
	if menu != HIDE_MENU:
		get_node(menu).visible = true
	current_menu = menu

