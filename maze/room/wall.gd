extends Node2D
class_name Wall

@export var direction: Utils.Direction
var is_door: bool:
	get:
		return randf() < .5
