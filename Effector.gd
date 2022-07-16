extends Area

func set_value(value):
	$Side.set_value(value)

func _physics_process(delta):
	for body in get_overlapping_bodies():
			body.hit($Side.value)
