extends Node3D


signal scare_fin

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		$man_above.visible = !$man_above.visible
		scare_fin.emit()
		#pass
