extends Label

signal win

var targets = 0
var progress = 0

func _on_Target_hit():
	progress += 1
	text = "%s" % (100 * progress / targets) + "%"
	if progress == targets:
		emit_signal("win")
