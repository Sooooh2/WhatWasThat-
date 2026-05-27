extends Node3D




signal jumpscare_triggered(intensity)

enum scares {
	#on_chair,
	#behind_door,
	above_cupboard
}

var scare_scenes = {
	#scares.on_chair: preload("res://jumpscares/on_chair.tscn"),
	#scares.behind_door: preload("res://jumpscares/behind_door.tscn"),
	scares.above_cupboard: preload("res://jumpscares/above_cupboard.tscn")
}

@onready var scare_points = {
	#scares.on_chair: $"../scarePoints/chairPoint",
	#scares.behind_door: $"../scarePoints/cornerPoint",
	scares.above_cupboard: $"../scarePoints/cupboardPoint"
}

var curr_scare = null
var prev_scare = null

@onready var player_gasp: AudioStreamPlayer3D = $"../player_gasp"
@export var max_fear := 100
@export var fear_gps := 10.0
@export var scare_limit := 10
@export var min_wait_time := 5.0
@export var max_wait_time := 15.0


func _ready():
	$"../bedroom_noise".play()
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
	player_gasp.play()
	curr_scare.global_transform = marker.global_transform
	
	jumpscare_triggered.emit(0.03)
	
	print("scare started:", curr_scare)
	await curr_scare.scare_fin
	print("finished this:", curr_scare)
	
	prev_scare = chosen_scare
	curr_scare.queue_free()
	curr_scare = null
