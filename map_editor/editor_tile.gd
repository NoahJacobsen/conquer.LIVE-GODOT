extends TextureButton

signal tile_pressed
signal tile_copied
signal toggled_flag

var type = "water"
var id = ""
var last_button_event: InputEventMouseButton = null
var flagged = false

func change_tile():
	print("Pressed tile [", id, "]")
	emit_signal("tile_pressed", self)

func copy_tile():
	print("Copied tile [", id, "]")
	emit_signal("tile_copied", type)

func change_texture(atlas):
	if flagged:
		toggle_flag()
	texture_normal = atlas

func move(pos):
	self.rect_position = pos

func toggle_flag():
	if flagged:
		$Flag.hide()
		flagged = false
	else:
		$Flag.show()
		flagged = true
	emit_signal("toggled_flag", id, flagged)

func _on_EditorTile_pressed():
	match last_button_event.button_index:
		BUTTON_LEFT:
			change_tile()
		BUTTON_RIGHT:
			copy_tile()


func _on_EditorTile_gui_input(event):
	if event is InputEventMouseButton:
		last_button_event = event
