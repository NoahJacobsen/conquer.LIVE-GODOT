extends TextureButton

const RESOURCE_REF = {
	"water": ""
}

export(String) var tile_id
export(String) var tile_type
export(Array, String) var drophash_raw
export(int) var occupancy
export(String) var effect_name


func _handle_select(event):
	print("Click tile: " + tile_id)
	var grid = self.get_parent().get_parent()
	
	# If in the editor, check the grid for the selected tile type, and replace tile
	if grid.editor.edit_mode:
		var selected = grid.get_selected_type()
		if tile_type != selected:
			print("Tile changing to: " + selected)
			grid.update_tile_type(tile_id, selected)
			queue_free()
