extends Spatial

var _value = 0

func set_value(value):
	_value = value
	for i in range(get_child_count()):
		if i == _value:
			get_child(i).show()
		else:
			get_child(i).hide()
