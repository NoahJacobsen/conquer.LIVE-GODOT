extends MarginContainer


func _on_GameButton_pressed():
	self.get_parent().change_menu("GameMenu")


func _on_EditorButton_pressed():
	# TODO: Create an editor menu to change to that lets player select level
	self.get_parent().open_editor()


func _on_OptionsButton_pressed():
	self.get_parent().change_menu("OptionsMenu")


func _on_ExitButton_pressed():
	self.get_parent().quit_game()
