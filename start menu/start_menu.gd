extends Node3D

@onready var ui: Control = $SubViewportContainer/ui
@onready var start_menu_cont: Control = $SubViewportContainer/ui/start_menu_cont


func _ready() -> void:
	ui.game_start.connect(_on_start_game_pressed)


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://level/level.tscn")
