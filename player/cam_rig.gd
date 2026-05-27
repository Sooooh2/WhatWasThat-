extends Node3D

@onready var event_manager = get_node_or_null("../../event_manager")
@onready var cam: Camera3D = $cam
@onready var ray_cast: RayCast3D = $RayCast3D
@onready var player = get_parent()
@export var shake_strength := 0.04
@export var shake_fade := 5.0
@export var cam_sense := 0.001
@export var maxZoom = 12
@export var minZoom = 0.1
@onready var click: AudioStreamPlayer3D = $"../click"


var og_pos : Vector3

func _ready() -> void:
	# jumpscare occured signal form the event manager to enable cam shake
	if event_manager:
		event_manager.jumpscare_triggered.connect(_on_jumpscare)
	og_pos = cam.position


func _input(event: InputEvent) -> void:
	
	# be able to capture and free the mouse cursor
	if event.is_action_pressed("free_mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# rotate the cam - look around logic
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y += -event.relative.x * cam_sense
			rotation.y = clamp(rotation.y, deg_to_rad(-50), deg_to_rad(60))
			rotation.x += -event.relative.y * cam_sense
			rotation.x = clamp(rotation.x, deg_to_rad(-50), deg_to_rad(60))

	# interaction with photos mechanism while under the blanket
	if Input.mouse_mode == Input.MOUSE_MODE_CONFINED:
		if Global.blanket_visited:
			if Input.is_action_just_pressed("interact"):
				if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
					click.play()
					var mouse_pos = get_viewport().get_mouse_position()
					var origin = cam.project_ray_origin(mouse_pos)
					var end = origin  + cam.project_ray_normal(mouse_pos) * 1000
					var query = PhysicsRayQueryParameters3D.create(origin,end)
					var result = get_world_3d().direct_space_state.intersect_ray(query)
				
					if result : 
						var obj = result.collider
	# zoom in and out logic  
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			cam.fov -= clamp(cam.fov - 1.0, minZoom, maxZoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			cam.fov += clamp(cam.fov + 1.0, minZoom, maxZoom)


func _process(delta: float) -> void:
	# cam shake for when there is jumpscare
	if shake_strength > 0:
		cam.position = og_pos + Vector3(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength),
		)
		shake_strength = lerpf(shake_strength,0.0, shake_fade * delta)
		cam.rotation_degrees.x += randf_range(-1, 1) * shake_strength * 2
	
	else:
		cam.position = og_pos


func _on_jumpscare(intensity):
	# =function for when signal is called from the event manager
	shake_strength = intensity
