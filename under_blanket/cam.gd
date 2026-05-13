extends Camera3D


@onready var cam: Camera3D = $"."
@export var maxZoom = 12
@export var minZoom = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			cam.size -= 1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			cam.size += 1
		cam.size = clamp(cam.size, minZoom, maxZoom)
