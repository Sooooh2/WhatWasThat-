extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_1: Sprite3D = $"../photo1"
@onready var outline: MeshInstance3D = $"../outline"


func inspect():
	print("photo inspected1") 
	player.inspect_obj(self)
	outline.visible = !outline.visible
