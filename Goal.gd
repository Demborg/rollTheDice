extends Label

func _ready():
	if (Global.target_level != null) and (Global.target_moves != null):
		text = "level %s in %s moves" % [Global.target_level, Global.target_moves]
	else:
		text = ""
