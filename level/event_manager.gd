extends Node3D

enum scares {
	on_chair,
	behind_door,
	above_cupboard
}

var scare_scenes = {
	scares.on_chair: preload("res://jumpscares/on_chair.tscn"),
	scares.behind_door: preload("res://jumpscares/behind_door.tscn"),
	scares.above_cupboard: preload("res://jumpscares/above_cupboard.tscn")
}

@onready var scare_points = {
	scares.on_chair: $"../scarePoints/chairPoint",
	scares.behind_door: $"../scarePoints/doorPoint",
	scares.above_cupboard: $"../scarePoints/cupboardPoint"
}
var curr_scare = null
var prev_scare = null

@export var scare_limit := 10
@export var min_wait_time := 5.0
@export var max_wait_time := 15.0


func _ready():
	print("EVENT MANAGER READY")
	print(self)
	print(get_path())
	event_loop()


func event_loop():
	while true:
		
		await get_tree().create_timer(
			randf_range(min_wait_time, max_wait_time)
		).timeout
		await start_scare()


func start_scare():

	if curr_scare != null:
		return

	var available_scares = scares.values().duplicate()

	if prev_scare != null:
		available_scares.erase(prev_scare)
	
	var chosen_scare = available_scares.pick_random()

	var scare_scene = scare_scenes[chosen_scare]
	
	var marker = scare_points[chosen_scare]
	curr_scare = scare_scene.instantiate()

	add_child(curr_scare)
	curr_scare.global_transform = marker.global_transform

	print("scare started:", curr_scare)

	await curr_scare.scare_fin

	print("finished this:", curr_scare)
	
	prev_scare = chosen_scare
	curr_scare.queue_free()

	curr_scare = null
