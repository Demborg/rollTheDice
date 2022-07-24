extends Node

var level = 0
var _rng = RandomNumberGenerator.new()
var global_seed: int
var color: Color

func _load_state():
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				var url_string = window.location.href;
				var url = new URL(url_string);
				url.searchParams.get('seed');
			""")
	return null

func _ready():
	var loaded_seed = _load_state()
	if loaded_seed:
		_rng.seed = int(loaded_seed)
	else:
		_rng.randomize()
	global_seed = _rng.seed
	color = Color.from_hsv(_rng.randf(), 1, 1)
