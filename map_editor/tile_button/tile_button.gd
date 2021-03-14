extends Area2D

const UI_CLICK = "ui_click"

export(String) var tile_type
export(Texture) var sprite_map
export(Rect2) var region_rect


func _ready():
	$Sprite.texture = sprite_map
	$Sprite.region_rect = region_rect

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if $Sprite.get_rect().has_point(to_local(event.position)):
			print("Click: " + tile_type)
