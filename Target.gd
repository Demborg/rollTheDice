extends StaticBody

signal hit

export(int) var value

func hit(effector_value):
	if effector_value != $Side.value:
		return
	if visible:
		emit_signal("hit")
	hide()

func _ready():
	$Side.set_value(value - 1)
