extends Node3D


signal scare_fin

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight") or event.is_action_pressed("lamp"):
		$man_stood.visible = !$man_stood.visible
		scare_fin.emit()
