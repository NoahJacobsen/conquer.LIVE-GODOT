extends Control

export(Texture) var tile_map

const TILE_SIZE = 32
const SPRITE_DATA = {  # These region V2s are calculated based on order of appeance in tile_map
	"editor_empty"	: Vector2(TILE_SIZE, 0),
	"water"			: Vector2(0,0),
	"beach"			: Vector2(0,TILE_SIZE),
	"forest"			: Vector2(0,TILE_SIZE*2),
	"dense_forest"	: Vector2(0,TILE_SIZE*3),
	"hill"			: Vector2(0,TILE_SIZE*4),
	"mountain"		: Vector2(0,TILE_SIZE*5),
	"desert"			: Vector2(0,TILE_SIZE*6),
	"oasis"			: Vector2(0,TILE_SIZE*7)
}
const BUTTON_SCENE = preload("res://map_editor/tile_button/tile_button.tscn")

func _ready():
	_vertical_generate_buttons()

func _vertical_generate_buttons():
	var button_position = Vector2(24,24)
	for data in SPRITE_DATA.keys():
		# Create and configure new buttons
		var new_button = BUTTON_SCENE.instance()
		var region_rect = Rect2(SPRITE_DATA[data], Vector2(TILE_SIZE, TILE_SIZE))
		new_button.tile_type = data
		new_button.region_rect = region_rect
		new_button.sprite_map = tile_map
		new_button.position = button_position
		$Buttons.add_child(new_button)
		# Move the next button below the current one
		button_position = button_position + Vector2(0,TILE_SIZE)


