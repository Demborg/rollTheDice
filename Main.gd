extends Node

func _ready():
	$UserInterface/Retry.hide()

func _on_Player_dead():
	$UserInterface/Retry.show()
	
func _unhandled_input(event):
	if event.is_action("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
