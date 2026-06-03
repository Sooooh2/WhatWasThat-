extends Control

signal menu_pressed

@onready var message: Label = $message
@onready var flash_battery: TextureProgressBar = $flash_battery
@onready var player: Node3D = $"../../player"

# connect signals from differnt scripts
func _ready() -> void:
	player.battery_changed.connect(_on_battery_changed)

# open pause menu 
func _on_menu_pressed() -> void:
	menu_pressed.emit()


# show messages on the screen 
func _show_msg(txt: String, duration := 2.0):
	message.text = txt
	message.visible = true
	await get_tree().create_timer(duration).timeout
	message.visible = false


# flashlight battery ui update func 
func _on_battery_changed(value):
	$flash_battery.value = value
