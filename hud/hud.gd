extends Control

signal menu_pressed

@onready var message: Label = $message
@onready var flash_battery: TextureProgressBar = $flash_battery



# connect signals from differnt scripts
func _ready() -> void:
	var player = get_node_or_null("../../player")
	var event_manager = get_node_or_null("../../event_manager")

	if player:
		player.battery_changed.connect(_on_battery_changed)

	if event_manager:
		event_manager.fear.connect(_on_fear_changed)

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


func _on_fear_changed(value):
	$fear_meter.value = value
