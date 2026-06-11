extends Node3D


var curr_photo = null
var examining = false

func toggle_examine():
	if curr_photo == null:
		return
	
	curr_photo.toggle_examine()
