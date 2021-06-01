extends MarginContainer


func _on_BackButton_pressed():
	self.get_parent().change_menu("MainMenu")
