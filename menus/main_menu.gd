extends Node2D

const BUTTON_DATA = {
	"editor": {
		"name": "EditorButton",
		"pos": Vector2(100,100),
		"size": Vector2(256,64),
		"text": "Open Editor",
		"func": "editor_pushed"
	},
	"game": {
		"name": "GameButton",
		"pos": Vector2(100,200),
		"size": Vector2(256,64),
		"text": "Open Game",
		"func": "game_pushed"
	},
	"options": {
		"name": "OptionsButton",
		"pos": Vector2(100,300),
		"size": Vector2(256,64),
		"text": "Options",
		"func": "options_pushed"
	}
}


func _ready():
	_add_button("editor")
	_add_button("game")
	_add_button("options")

# Reads BUTTON_DATA and creates a button, connecting signal to a function "func"
func _add_button(button):
	var btn = Button.new()
	btn.name = BUTTON_DATA[button]["name"]
	btn.text = BUTTON_DATA[button]["text"]
	btn.set_position(BUTTON_DATA[button]["pos"])
	btn.set_size(BUTTON_DATA[button]["size"])
	btn.connect("button_down", self, BUTTON_DATA[button]["func"])
	self.add_child(btn)

func editor_pushed():
	self.get_parent().open_editor()

func game_pushed():
	self.get_parent().change_menu("GameMenu")

func options_pushed():
	self.get_parent().change_menu("OptionsMenu")
