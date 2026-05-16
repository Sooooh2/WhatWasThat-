extends Node3D


# variables
@onready var menu_cont: Control = $CanvasLayer/hud/menu_cont
@onready var menu: TextureButton = $CanvasLayer/hud/menu
@onready var hud: Control = $CanvasLayer/hud



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hud.get_node("menu").show()
	hud.menu_pressed.connect(_on_menu_pressed)
	$env/lamp.omni_range = 1.2
	hud._show_msg("look around",5.0)
	hud._show_msg("press space to show cursor",2.0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("lamp"):
		$env/lamp.visible = !$env/lamp.visible
	if event.is_action_pressed("switch"):
		$env/ceil_lamp.visible = !$env/ceil_lamp.visible


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_blanket"):
		print("right clicked")
		get_tree().change_scene_to_file("res://under_blanket/under_blanket.tscn")


func _on_menu_pressed() -> void:
	menu_cont.visible = !menu_cont.visible
	menu.visible = !menu.visible
