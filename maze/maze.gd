@tool

extends Node2D
class_name Maze


@export_file("*.txt") var level: String


func _ready():
	_create_maze()
	
	
func _create_maze():
	var file = FileAccess.open(level, FileAccess.READ)
	var data = str_to_var(file.get_as_text())
	
	print(data) 
