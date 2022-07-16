extends KinematicBody

signal dead
signal moved

var DURATION = 0.5

var direction = Vector3.ZERO
var progress = 0

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
