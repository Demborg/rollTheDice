extends Node

export (PackedScene) var target_scene

var rng = RandomNumberGenerator.new()

func _reset():
	get_tree().reload_current_scene()

func _make_and_connect_target(position: Vector3, value: int):
	var target = target_scene.instance()
	target.value = value
	target.transform.origin = position
	target.connect("hit", $UserInterface/Progress, "_on_Target_hit")
	$UserInterface/Progress.targets += 1
	$Ground.add_child(target)
	
func _make_and_connect_random_target():
	_make_and_connect_target(
		Vector3(
			2 * rng.randi_range(-2, 2),
			1,
			2 * rng.randi_range(-2, 2)
		),
		rng.randi_range(1, 6)
	)

func _ready():
	print(Global.color, Global.global_seed)
	$DirectionalLight.light_color = Global.color
	rng.seed = Global.level + Global.global_seed
	$UserInterface/Retry.hide()
	$UserInterface/Win.hide()
	
	if Global.level == 0:
		_make_and_connect_target(Vector3(0, 1, 0), 3)
		_make_and_connect_target(Vector3(0, 1, 4), 1)
	else:
		for _i in range(Global.level):
			_make_and_connect_random_target()
			
func _on_Player_dead():
	if not $UserInterface/Win.visible:
		$UserInterface/Retry.show()
	
func _input(event):
	if event.is_action("reset"):
		_reset()
	if event.is_action("ui_accept") or event is InputEventMouseButton:
		if $UserInterface/Retry.visible or $UserInterface/Win.visible:
			_reset()

func _on_Progress_win():
	$UserInterface/Win.show()
	Global.level += 1

func _on_ResetButton_pressed():
	_reset()
