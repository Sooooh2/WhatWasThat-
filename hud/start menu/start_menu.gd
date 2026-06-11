extends Control


signal game_start


func _ready() -> void:
	game_start.connect(_on_play_pressed)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://level/level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_about_me_pressed() -> void:
	$aboutmesect.visible = !$aboutmesect.visible 
	$back.visible = !$back.visible 
func _on_back_pressed() -> void:
	$aboutmesect.visible = !$aboutmesect.visible 
	$back.visible = !$back.visible 
