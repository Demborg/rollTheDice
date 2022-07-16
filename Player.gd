extends KinematicBody

signal dead
signal moved

var DURATION = 0.5

var direction = Vector3.ZERO
var progress = 0

var click = Vector2.ZERO

func _ready():
	for i in range($Pivot/MeshInstance.get_child_count()):
		$Pivot/MeshInstance.get_child(i).set_value(i)
		
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			click = event.position
		else:
			var diff = click - event.position
			if diff.length() > 100:
				if abs(diff.x) > 2 * abs(diff.y):
					direction = Vector3.LEFT * sign(diff.x) * 2
				elif abs(diff.y) > 2 * abs(diff.x):
					direction = Vector3.FORWARD * sign(diff.y) * 2
			click = Vector2.ZERO

func _physics_process(delta):
	move_and_collide((direction + 1 * Vector3.DOWN) * delta / DURATION)
	
	if transform.origin.y < 0:
		die()
		return
		
	if direction != Vector3.ZERO:
		rotate(direction.normalized().cross(Vector3.DOWN), 0.5 * PI*delta / DURATION)
		
		progress += delta
		if progress >= DURATION:
			progress = 0
			direction = Vector3.ZERO
		return
	
	if Input.is_action_just_pressed("move_forward"):
		direction = 2 * Vector3.FORWARD
		emit_signal("moved")
	elif Input.is_action_just_pressed("move_back"):
		direction = 2 * Vector3.BACK
		emit_signal("moved")
	elif Input.is_action_just_pressed("move_left"):
		direction = 2 * Vector3.LEFT
		emit_signal("moved")
	elif Input.is_action_just_pressed("move_right"):
		direction = 2 * Vector3.RIGHT
		emit_signal("moved")
	
func die():
	emit_signal("dead")
