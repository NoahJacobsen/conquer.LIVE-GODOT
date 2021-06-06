extends TextureButton

signal tile_pressed

var type = "water"
var id = ""

func _on_EditorTile_pressed():
	print("Pressed tile [", id, "]")
	emit_signal("tile_pressed", type)

func move(pos):
	self.rect_position = pos
