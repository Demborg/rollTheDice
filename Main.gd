extends Node

export (PackedScene) var target_scene

var rng = RandomNumberGenerator.new()
var targets: Dictionary

func _reset():
	get_tree().reload_current_scene()

func _make_and_connect_target(position: Vector2, value: int):
	var target = target_scene.instance()
	targets[position] = value
	target.value = value
	target.transform.origin = Vector3(position.x, 1, position.y)
	target.connect("hit", $UserInterface/Progress, "_on_Target_hit")
	$UserInterface/Progress.targets += 1
	$Ground.add_child(target)
	
func _make_and_connect_random_target():
	var val = rng.randi_range(1, 6)
	var pos = 2 * Vector2(rng.randi_range(-2, 2), rng.randi_range(-2, 2))
	while pos in targets.keys():
		pos = 2 * Vector2(rng._randi_range(-2, 2), rng.randi_range(-2, 2))
	_make_and_connect_target(pos, val)

func _ready():
	$DirectionalLight.light_color = Global.color
	rng.seed = Global.level + Global.global_seed
	targets = {}
	$UserInterface/Retry.hide()
	$UserInterface/Win.hide()
	
	if Global.level == 0:
		_make_and_connect_target(Vector2(0, 0), 3)
		_make_and_connect_target(Vector2(0, 4), 1)
	else:
		for _i in range(Global.level):
			_make_and_connect_random_target()
			
func _on_Player_dead():
	if not $UserInterface/Win.visible:
		$UserInterface/Retry.show()
	
func _unhandled_input(event):
	if event.is_action("reset"):
		_reset()
	if event.is_action("ui_accept") or event is InputEventMouseButton:
		if $UserInterface/Win.visible:
			_on_Proceed()
		elif $UserInterface/Retry.visible:
			_reset()

func _on_Progress_win():
	$UserInterface/Win.show()

func _on_Proceed():
	Global.level += 1
	_reset()

func _on_ResetButton_pressed():
	_reset()
