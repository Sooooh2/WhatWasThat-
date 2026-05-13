extends Node3D


signal scare_fin

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight") or event.is_action_pressed("switch"):
		$"man_sat".visible = !$"man_sat".visible
		scare_fin.emit()
