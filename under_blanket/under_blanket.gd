extends Node3D


@onready var hud: Control = $CanvasLayer/hud


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	if !Global.blanket_visited:
		hud._show_msg("Turn the flashlight on", 4.0)
		Global.blanket_visited = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("toggle_blanket"):
		print("right clicked")
		get_tree().change_scene_to_file("res://level/level.tscn")
