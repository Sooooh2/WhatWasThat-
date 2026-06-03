extends Node3D


@onready var flashlight: SpotLight3D = $rig/flashlight
@onready var hud: Control = $"../CanvasLayer/hud"

signal battery_changed

var drain_rate := 15.0
var curr_inspected_obj
var can_move : bool
var can_look : bool


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		flashlight.visible = !flashlight.visible

func _process(delta: float) -> void:
	if flashlight.visible:
		Global.flash_battery = max(
			Global.flash_battery - drain_rate * delta,
			0.0
		)
		battery_changed.emit(Global.flash_battery)
		if Global.flash_battery == 0:
			hud._show_msg("No flashlight battery",2.0)

# inspect photos
func inspect_obj(obj):
	curr_inspected_obj = obj
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	can_move = false
	can_look = false
