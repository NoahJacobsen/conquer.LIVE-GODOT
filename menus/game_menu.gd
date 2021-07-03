extends MarginContainer

onready var gc = get_tree().get_nodes_in_group("game_controller")[0]
onready var map_btns = $VBoxContainer/Menus/HostSettings/ScrollContainer/MapButtons
onready var map_name = $VBoxContainer/Menus/HostSettings/HostControls/MapName
onready var menu_main = $VBoxContainer/Menus/GameChoice
onready var menu_host = $VBoxContainer/Menus/HostSettings
onready var menu_join = $VBoxContainer/Menus/JoinSettings

var cur_menu = "main"

func reveal():
	refresh_map_list()
	self.show()

func obscure():
	self.hide()
	
func show_menu(menu):
	match menu:
		"host":
			if cur_menu != "host":
				menu_main.hide()
				menu_join.hide()
				menu_host.show()
				cur_menu = "host"
		"join":
			if cur_menu != "join":
				menu_main.hide()
				menu_join.show()
				menu_host.hide()
				cur_menu = "join"
		"main":
			if cur_menu != "main":
				menu_main.show()
				menu_join.hide()
				menu_host.hide()
				cur_menu = "main"

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
	if cur_menu == "main":
		self.get_parent().change_menu("MainMenu")
	else:
		show_menu("main")

func _on_Host_pressed():
	show_menu("host")


func _on_Join_pressed():
	show_menu("join")
