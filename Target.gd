extends Spatial

export(int) var value

func _ready():
	$Side.set_value(value - 1)
