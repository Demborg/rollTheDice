extends Label

var moves = 0

func _on_Player_moved():
	moves += 1
	text = "Moves: %s" % moves
