extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_sprite: Sprite3D = $"../photo2"
@onready var photo_2: Node3D = $".."
@onready var outline_2: MeshInstance3D = $"../outline2"

var inspected := false

func inspect():
	print("photo inspected2") 
	player.inspect_obj(self)
	inspected = true

func _process(delta: float) -> void:
	outline_2.visible = Global.dragged_obj == get_parent()
