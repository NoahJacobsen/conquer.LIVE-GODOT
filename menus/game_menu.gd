extends MarginContainer

onready var gc = get_tree().get_nodes_in_group("game_controller")[0]
onready var map_btns = $VBoxContainer/GameSettings/ScrollContainer/MapButtons
onready var map_name = $VBoxContainer/GameSettings/GameButtons/MapName

func reveal():
	refresh_map_list()
	self.show()

func obscure():
	self.hide()

func refresh_map_list():
	for btn in map_btns.get_children():
		btn.queue_free()
	var dir = Directory.new()
	var map_dir = gc.verify_map_dir()
	dir.open(map_dir)  # Must open before changing dir
	dir.change_dir(map_dir)
	var _ret = dir.list_dir_begin(true, true)
	while true:
		var map = dir.get_next()
		if not map:
			break  # Break when stream closes
		var btn = Button.new()
		var _res = btn.connect("pressed", self, "_handle_map_button_click", [btn])
		btn.text = map.replace(".tres", "")
		btn.rect_min_size = Vector2(175,0)
		map_btns.add_child(btn)

func _handle_map_button_click(btn):
	map_name.text = "Map: " + btn.text

func _on_BackButton_pressed():
	self.get_parent().change_menu("MainMenu")


