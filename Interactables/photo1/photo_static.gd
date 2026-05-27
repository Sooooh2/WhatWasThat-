extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_sprite: Sprite3D = $"../photo1"
@onready var outline: MeshInstance3D = $"../outline"
@onready var photo1: Node3D = $".."

var inspected := false

func inspect():
	print("photo inspected1") 
	player.inspect_obj(self)
	inspected = true

func _process(delta: float) -> void:
	outline.visible = Global.dragged_obj == get_parent()
