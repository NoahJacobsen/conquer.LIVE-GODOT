extends MarginContainer


func reveal():
	self.show()

func obscure():
	self.hide()

func _on_BackButton_pressed():
	self.get_parent().change_menu("MainMenu")
