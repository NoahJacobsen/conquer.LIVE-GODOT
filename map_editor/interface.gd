extends NinePatchRect

export(Texture) var tile_map

const BUTTON_POS_OFFSET = 0  # Not sure why it's offset, but this is how far off it is

onready var editor = get_parent().get_parent()

func _ready():
	for button in $MarginContainer/Buttons.get_children():
		move_selected(button.rect_position)
		var ret = button.connect("pressed", self, "handle_press", [button])

func handle_press(button):
	get_tree().set_input_as_handled()
	change_selected(button.name.to_lower())
	move_selected(button.rect_position)

func change_selected(new_tile):
	# Feature idea: Show the currently selected tile
	if new_tile == editor.selected_tile:
		return
	editor.selected_tile = new_tile
	print("Selected: " + editor.selected_tile)
	editor.update_handle()

func move_selected(new_pos):
	$MarginContainer/SelectedTexture.rect_position.y = new_pos.y + BUTTON_POS_OFFSET

func find_and_select_type():
	for button in $MarginContainer/Buttons.get_children():
		if button.name.to_lower() == editor.selected_tile:
			move_selected(button.rect_position)
