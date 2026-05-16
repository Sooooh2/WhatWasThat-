extends Node3D


@onready var cam: Camera3D = $cam
@onready var ray_cast: RayCast3D = $RayCast3D
@onready var player = get_parent()
var cam_sense := 0.001

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("free_mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y += -event.relative.x * cam_sense
			rotation.y = clamp(rotation.y, deg_to_rad(-50), deg_to_rad(60))
			rotation.x += -event.relative.y * cam_sense
			rotation.x = clamp(rotation.x, deg_to_rad(-50), deg_to_rad(60))
			
	if Input.is_action_just_pressed("interact"):
		if ray_cast.is_colliding():
			var obj = ray_cast.get_collider()
			if obj.has_method("inspect"):
				obj.player = player
				obj.inspect()
