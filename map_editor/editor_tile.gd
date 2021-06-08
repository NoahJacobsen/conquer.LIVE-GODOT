extends TextureButton

signal tile_pressed
signal tile_copied

var type = "water"
var id = ""
var last_button_event: InputEventMouseButton = null


func change_tile():
	print("Pressed tile [", id, "]")
	emit_signal("tile_pressed", self)

func copy_tile():
	print("Copied tile [", id, "]")
	emit_signal("tile_copied", type)

func change_texture(atlas):
	texture_normal = atlas

func move(pos):
	self.rect_position = pos


func _on_EditorTile_pressed():
	match last_button_event.button_index:
		BUTTON_LEFT:
			change_tile()
		BUTTON_RIGHT:
			copy_tile()


func _on_EditorTile_gui_input(event):
	if event is InputEventMouseButton:
		last_button_event = event
