extends Spatial

var value = 0

func set_value(new_value):
	value = new_value
	for i in range($sides.get_child_count()):
		if i == value:
			$sides.get_child(i).show()
		else:
			$sides.get_child(i).hide()
