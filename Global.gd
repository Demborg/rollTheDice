extends Node

var level = 0
var _rng = RandomNumberGenerator.new()
var global_seed: int
var color: Color

func _ready():
	_rng.randomize()
	global_seed = _rng.randi()
	color = Color.from_hsv(_rng.randf(), 1, 1)
