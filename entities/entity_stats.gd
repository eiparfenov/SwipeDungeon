extends Node2D
class_name EntityStats

@export var _speed: float # initial, don't change in game
var speed: float # current, can be changed by effects


func _ready():
	speed = _speed
