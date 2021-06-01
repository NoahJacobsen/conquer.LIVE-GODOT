extends NinePatchRect

export(Texture) var tile_map

export(String) var selected_tile = "editor_empty"



func change_selected(new_tile):
	# Feature idea: Show the currently selected tile
	if new_tile == selected_tile:
		return
	selected_tile = new_tile
	print("Selected: " + selected_tile)
	
