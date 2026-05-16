extends StaticBody3D

@export var player: Node3D 
@export var interactable_root : Node


func inspect():
	print("photo inspected")
	
	player.inspect_obj(self)
