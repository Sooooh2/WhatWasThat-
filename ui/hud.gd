extends Control


signal menu_pressed
signal game_start

@onready var message: Label = $message

func _on_menu_pressed() -> void:
	menu_pressed.emit()


func _on_start_game_pressed() -> void:
	game_start.emit()

func _show_msg(txt: String, duration := 2.0):
	message.text = txt
	message.visible = true
	
	await get_tree().create_timer(duration).timeout
	message.visible = false
