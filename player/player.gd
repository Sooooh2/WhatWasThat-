extends Node3D

@onready var flashlight: SpotLight3D = $rig/flashlight
@onready var hud: Control = $"../CanvasLayer/hud"


var drain_rate := 15.0
var flashlight_on := false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		flashlight.visible = !flashlight.visible
		print("flashlight battery: ", Global.flash_battery)


func _process(delta: float) -> void:
	if flashlight.visible == true:
		Global.flash_battery -= drain_rate * delta
		if Global.flash_battery <= 0.0:
			Global.flash_battery = 0
			flashlight.visible = false
			hud._show_msg("flashlight battery died",2.0)
