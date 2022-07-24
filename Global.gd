extends Node

var level = 0
var _rng = RandomNumberGenerator.new()
var global_seed: int
var color: Color
var moves: int
var target_level = null
var target_moves = null

func encoded_state(current_moves):
	return Marshalls.utf8_to_base64("mov=%s,lev=%s" % [(moves + current_moves), level])
	
func decode_target_state():
	var state_string = Marshalls.base64_to_utf8(_load_value("state"))
	if state_string:
		var regex = RegEx.new()
		regex.compile("mov=(\\d+),lev=(\\d+)")
		var result = regex.search(state_string)
		if result:
			target_moves = int(result.get_string(1))
			target_level = int(result.get_string(2))

func _load_value(value: String):
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				var url_string = window.location.href;
				var url = new URL(url_string);
				url.searchParams.get('%s');
			""" % value)
	return null

func _ready():
	var loaded_seed = _load_value("seed")
	if loaded_seed:
		_rng.seed = int(loaded_seed)
		decode_target_state()
	else:
		_rng.randomize()
	global_seed = _rng.seed
	color = Color.from_hsv(_rng.randf(), 1, 1)
