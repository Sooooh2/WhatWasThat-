extends Node3D


signal jumpscare_triggered(intensity)
signal fear(fear_value)
signal relax(relax_value)
enum scares {
	on_chair,
	behind_door,
	above_cupboard,
	behind_bed,
	scare_teddy,
	in_corner
}

var scare_scenes = {
	scares.on_chair: preload("res://jumpscares/on_chair.tscn"),
	scares.behind_door: preload("res://jumpscares/behind_door.tscn"),
	scares.above_cupboard: preload("res://jumpscares/above_cupboard.tscn"),
	scares.behind_bed: preload("res://jumpscares/behind_bed.tscn"),
	scares.scare_teddy: preload("res://jumpscares/scary_teddy.tscn"),
	scares.in_corner: preload("res://jumpscares/in_corner.tscn")
}

@onready var scare_points = {
	scares.on_chair: $"../scarePoints/chairPoint",
	scares.behind_door: $"../scarePoints/cornerPoint",
	scares.above_cupboard: $"../scarePoints/cupboardPoint",
	scares.behind_bed: $"../scarePoints/bedPoint",
	scares.scare_teddy: $"../scarePoints/teddyPoint",
	scares.in_corner: $"../scarePoints/cornerPoint"
}

var curr_scare = null
var prev_scare = null
var scare_present := false
var drain_rate := 1.0
var anxious_drain := 5.0
var first_scare := false

@onready var player_gasp: AudioStreamPlayer3D = $"../player_gasp"
@onready var hud: Control = $"../CanvasLayer/hud"
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
	if !first_scare:
		hud._show_msg("Turn flashlgiht on or look away or go inside blanket",4.0)
	await get_tree().create_timer(4.0).timeout
	# cam shake
	first_scare = true
	scare_present = true
	print("scare started:", curr_scare)
	await curr_scare.scare_fin
	print("finished this:", curr_scare)
	scare_present = false
	prev_scare = chosen_scare
	curr_scare.queue_free()
	curr_scare = null

func _process(delta):

	if scare_present:
		Global.fear_meter = min(
			Global.fear_meter + drain_rate * delta,
			100.0
		)

		Global.relax_meter = max(
			Global.relax_meter - drain_rate * delta,
			0.0
		)

		if Global.relax_meter <= 20:
			Global.fear_meter = min(
				Global.fear_meter + anxious_drain * delta,
				100.0
			)

	else:
		if Global.relax_meter > 50.0:
			Global.relax_meter = min(
				Global.relax_meter + drain_rate * delta,
				100.0
			)

		if Global.relax_meter >= 10:
			Global.fear_meter = max(
				Global.fear_meter - anxious_drain * delta,
				0.0
			)

	relax.emit(Global.relax_meter)
	fear.emit(Global.fear_meter)

	if Global.fear_meter >= 100.0:
		level_fail()


func level_fail():
	hud._show_msg("sooo scarredd !!!! ahhh",3.0)
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://endScreen/end_screen.tscn")
	
