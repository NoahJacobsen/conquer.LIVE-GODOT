extends NinePatchRect

export(Texture) var tile_map

onready var editor = get_parent()

func _ready():
	for button in $MarginContainer/Buttons.get_children():
		var ret = button.connect("pressed", self, "handle_press", [button.name.to_lower()])

func handle_press(name):
	get_tree().set_input_as_handled()
	change_selected(name)

func change_selected(new_tile):
	# Feature idea: Show the currently selected tile
	if new_tile == editor.selected_tile:
		return
	editor.selected_tile = new_tile
	print("Selected: " + editor.selected_tile)
	
