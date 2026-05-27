extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node
@onready var photo_1: Sprite3D = $"../photo1"


func inspect():
	print("photo inspected") 
	player.inspect_obj(self)
	photo_1.modulate = Color(10,10,10)
