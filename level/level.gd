extends Node3D

@onready var ui: Control = $ui
@onready var menu_cont: Control = $ui/menu_cont


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("lamp"):
		$env/lamp.visible = !$env/lamp.visible
	if event.is_action_pressed("switch"):
		$env/ceil_lamp.visible = !$env/ceil_lamp.visible


func _ready() -> void:
	ui.get_node("start_menu_cont").hide()
	ui.get_node("menu").show()
	ui.menu_pressed.connect(_on_menu_pressed)
	$env/lamp.omni_range = 1.2

func _on_menu_pressed() -> void:
	menu_cont.visible = !menu_cont.visible
