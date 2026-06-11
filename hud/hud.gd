extends Control

signal menu_pressed
signal continue_pressed

@onready var message: Label = $message
@onready var flash_battery: TextureProgressBar = $flashlight/flash_battery
@onready var flash_battery_2: TextureProgressBar = $flashlight/flash_battery2
@onready var flash_battery_3: TextureProgressBar = $flashlight/flash_battery3
@onready var flash_battery_4: TextureProgressBar = $flashlight/flash_battery4
@onready var flash_battery_5: TextureProgressBar = $flashlight/flash_battery5



# connect signals from differnt scripts
func _ready() -> void:
	var player = get_node_or_null("../../player")
	var event_manager = get_node_or_null("../../event_manager")

	if player:
		player.battery_changed.connect(_on_battery_changed)

	if event_manager:
		event_manager.fear.connect(_on_fear_changed)
		event_manager.relax.connect(_on_relax_changed)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		menu_pressed.emit()
	if event.is_action_pressed("continue"):
		continue_pressed.emit()




# show messages on the screen 
func _show_msg(txt: String, duration := 2.0):
	message.text = txt
	message.visible = true
	await get_tree().create_timer(duration).timeout
	message.visible = false


# flashlight battery ui update func 
func _on_battery_changed(value):
	flash_battery.value = value
	flash_battery_2.value = value
	flash_battery_3.value = value
	flash_battery_4.value = value
	flash_battery_5.value = value


func _on_fear_changed(value):
	$VBoxContainer/fearbar.value = value


func _on_relax_changed(value):
	$VBoxContainer/relaxbar.value = value

# open pause menu 
func _on_menu_pressed() -> void:
	menu_pressed.emit()


func _on_continue_pressed() -> void:
	continue_pressed.emit()
