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
const FIRST_BUTTON_POS = Vector2(32,32)
const BACKGROUND_MARGIN = 4

export(String) var selected_tile = "editor_empty"


func _ready():
	_vertical_generate_buttons()

func _vertical_generate_buttons():
	var button_position = FIRST_BUTTON_POS
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
	# These next two lines create the "window" look for the tile buttons
	$TileBackground.set_position(Vector2(FIRST_BUTTON_POS.x - TILE_SIZE/2 - BACKGROUND_MARGIN, FIRST_BUTTON_POS.y - TILE_SIZE/2 - BACKGROUND_MARGIN))
	$TileBackground.rect_size = Vector2(TILE_SIZE + (BACKGROUND_MARGIN*2), int(button_position.y) - TILE_SIZE + BACKGROUND_MARGIN*2)

func change_selected(new_tile):
	# Feature idea: Show the currently selected tile
	if new_tile == selected_tile:
		return
	selected_tile = new_tile
	print("Selected: " + selected_tile)
	
func serialize_tile_data(map_name, path):
	var grid_size = $Grid.EDITOR_GRID_SIZE
	var tile_data_raw = $Grid.tile_list
	var data_keys = tile_data_raw.keys()
	var data_refined = []
	for i in range(grid_size):
		data_refined.append([])
	for key in data_keys:
		var index = key.split(":")
		data_refined[int(index[0])][int(index[1])] = tile_data_raw[key]
	return data_refined
