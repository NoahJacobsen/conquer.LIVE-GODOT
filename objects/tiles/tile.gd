extends Area2D

const SELECT_COLOR = Color.khaki

export(Array, String) var drophash_raw
export(int) var occupancy
export(String) var effect_name

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if $Sprite.get_rect().has_point(to_local(event.position)):
			$Sprite.modulate = SELECT_COLOR
			_handle_select(event)
	else:
		$Sprite.modulate = Color.white

func _handle_select(event):
	print("Click tile: " + String(self.position))
