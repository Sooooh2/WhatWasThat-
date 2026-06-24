extends StaticBody3D



@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_manager = get_node("/root/under_blanket/photo_manager")
@onready var photo1: Node3D = $".."
@onready var examine_here: Marker3D = $"../../../../examine_here"
@onready var photo_1: Sprite3D = $".."
@onready var outline: MeshInstance3D = $outline
@onready var focus_1: Area3D = $"../focuses/focus1"

@onready var photo_collider: StaticBody3D = $"."


var og_pos : Vector3
var examining := false

var inspected := false

func _ready() -> void:
	og_pos = photo1.global_position
	add_to_group("focus")


func inspect():
	player.inspect_obj(self)
	photo_manager.curr_photo = self


func _process(delta: float) -> void:
	outline.visible = Global.dragged_obj == get_parent()
	if hovering:
		print("still hovering")

func toggle_examine():
	examining = !examining

	if examining:
		photo1.global_position = examine_here.global_position
	else:
		photo1.global_position = og_pos


var hovering := false

func focus_found():
	print("Focus layer:", $"../focuses/focus1".collision_layer)
	if examining:
		print("asfuasvv yayyyyy focus workssss")
func _on_focus_1_mouse_entered():
	hovering = true
	print("entered")

func _on_focus_1_mouse_exited():
	hovering = false
	print("exited")
