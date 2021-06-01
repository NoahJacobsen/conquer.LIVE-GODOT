extends Node2D

const BUTTON_DATA = {
	"back": {
		"name": "BackButton",
		"pos": Vector2(24,24),
		"size": Vector2(128,32),
		"text": "Back",
		"func": "back_pushed"
	}
}


func _ready():
	_add_button("back")

# Reads BUTTON_DATA and creates a button, connecting signal to a function "func"
func _add_button(button):
	var btn = Button.new()
	btn.name = BUTTON_DATA[button]["name"]
	btn.text = BUTTON_DATA[button]["text"]
	btn.set_position(BUTTON_DATA[button]["pos"])
	btn.set_size(BUTTON_DATA[button]["size"])
	btn.connect("button_down", self, BUTTON_DATA[button]["func"])
	self.add_child(btn)

func back_pushed():
	self.get_parent().change_menu("MainMenu")
