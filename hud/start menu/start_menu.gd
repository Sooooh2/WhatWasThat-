extends Node3D


signal game_start
@onready var start_menu_cont: Control = $CanvasLayer/start_menu_cont


func _ready() -> void:
	
	game_start.connect(_on_start_game_pressed)


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://level/level.tscn")
