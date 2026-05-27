extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_2: Sprite3D = $"../photo2"
@onready var outline: MeshInstance3D = $"../outline"


func inspect():
	print("photo inspected2") 
	player.inspect_obj(self)
	outline.visible = !outline.visible
