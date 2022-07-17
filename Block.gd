extends Area

var lives = 2
var active = false

func _ready():
	$MeshInstance.material_override = SpatialMaterial.new()

func _process(delta):
	if get_overlapping_bodies():
		if not active:
			active = true
			lives -= 1
	else:
		active = false
		if lives == 1:
			$MeshInstance.material_override.albedo_color = Color(0.5, 0.5, 0.5)
		elif lives == 0:
			transform.origin += 10 * Vector3.DOWN * delta
