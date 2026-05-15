extends Node3D


@onready var cam: Camera3D = $cam

var cam_sense := 0.001


func _input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return 
	if event.is_action_pressed("free_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	if event is InputEventMouseMotion:
		rotation.y += -event.relative.x * cam_sense
		rotation.y = clamp(rotation.y, deg_to_rad(-50), deg_to_rad(60))
		rotation.x += -event.relative.y * cam_sense
		rotation.x = clamp(rotation.x, deg_to_rad(-50), deg_to_rad(60))
