extends Area2D

const UI_CLICK = "ui_click"
const SELECT_COLOR = Color.khaki

export(String) var tile_type
export(Texture) var sprite_map
export(Rect2) var region_rect


func _ready():
	$Sprite.texture = sprite_map
	$Sprite.region_rect = region_rect

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if $Sprite.get_rect().has_point(to_local(event.position)):
			get_tree().set_input_as_handled()
			$Sprite.modulate = SELECT_COLOR
			_handle_select(event)
	else:
		$Sprite.modulate = Color.white

func _handle_select(event):
	print("Click: " + tile_type)
	self.get_parent().get_parent().change_selected(tile_type)
