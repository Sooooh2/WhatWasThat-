extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_sprite: Sprite3D = $"../photo1"
@onready var outline: MeshInstance3D = $"../outline"
@onready var photo1: Node3D = $".."
var og_pos : Vector3
var inspected := false
var examining := false

@onready var examine_here: Marker3D = $"../../../examine_here"
@onready var photo_manager = get_node("/root/under_blanket/photo_manager")

func _ready() -> void:
	og_pos = photo1.global_position


func inspect():
	player.inspect_obj(self)
	photo_manager.curr_photo = self

func _process(delta: float) -> void:
	outline.visible = Global.dragged_obj == get_parent()

func toggle_examine():
	examining = !examining

	if examining:
		photo1.global_position = examine_here.global_position
	else:
		photo1.global_position = og_pos
