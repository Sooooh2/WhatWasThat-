extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_sprite: Sprite3D = $"../photo2"
@onready var photo2: Node3D = $".."
@onready var outline_2: MeshInstance3D = $"../outline2"
@onready var examine_here: Marker3D = $"../../../examine_here"
@onready var photo_manager = get_node("/root/under_blanket/photo_manager")
var og_pos : Vector3
var examining := false

var inspected := false

func _ready() -> void:
	og_pos = photo2.global_position



func inspect():
	player.inspect_obj(self)
	photo_manager.curr_photo = self


func _process(delta: float) -> void:
	outline_2.visible = Global.dragged_obj == get_parent()

func toggle_examine():
	examining = !examining

	if examining:
		photo2.global_position = examine_here.global_position
	else:
		photo2.global_position = og_pos
