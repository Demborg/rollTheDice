extends Node

func _ready():
	$UserInterface/Retry.hide()
	$UserInterface/Win.hide()

func _on_Player_dead():
	$UserInterface/Retry.show()
	
func _input(event):
	if event.is_action("ui_accept") or event is InputEventMouseButton:
		if $UserInterface/Retry.visible or $UserInterface/Win.visible:
			get_tree().reload_current_scene()

func _on_Progress_win():
	$UserInterface/Win.show()
