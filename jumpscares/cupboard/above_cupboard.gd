extends Node3D



signal scare_fin

var flashlight_on := false

func _unhandled_input(event):
	if event.is_action_pressed("flashlight"):
		flashlight_on = !flashlight_on


@export var required_dot := 0.9

func _process(delta):

	if !flashlight_on:
		return

	var cam = get_viewport().get_camera_3d()

	var to_scare = (
		$"man_above".global_position
		- cam.global_position
	).normalized()

	var cam_forward = -cam.global_transform.basis.z

	var dot = cam_forward.dot(to_scare)

	if dot > required_dot or Input.is_action_just_pressed("toggle_blanket"):
		$"man_above".visible = false
		scare_fin.emit()
