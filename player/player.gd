extends Node3D

@onready var hud = get_node("../ui")
@onready var flashlight: SpotLight3D = $rig/flashlight
@export var flash_battery := 100.0


var drain_rate := 5.0
var flashlight_on := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		flashlight.visible = !flashlight.visible
		print("flashlight battery: ", flash_battery)


func _process(delta: float) -> void:
	if flashlight.visible == true:
		flash_battery -= drain_rate * delta
		if flash_battery <= 0.0:
			flash_battery = 0
			flashlight.visible = false
			hud._show_msg("flashlight battery died",2.0)
