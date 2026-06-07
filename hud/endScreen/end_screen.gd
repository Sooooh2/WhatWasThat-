extends Node2D



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://hud/start menu/start_menu.tscn")
