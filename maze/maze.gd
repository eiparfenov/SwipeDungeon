extends Node2D
class_name Maze


@export_file("*.txt") var level: String
var room_scene = preload("res://maze/room/room.tscn")
var room_offset = Vector2(Utils.UNIT * 10, Utils.UNIT * 16)

func _ready():
	_create_maze()
	
	
func _create_maze():
	var file = FileAccess.open(level, FileAccess.READ)
	var data = str_to_var(file.get_as_text())
	var generated_maze = MazeGenerator.generate_maze(data)
	var sprites_set = SpritesSet.new(data["sprites"])
	var content_set = ContentSet.new(data["contents"])
	
	for room_data in generated_maze:
		var room: Room = room_scene.instantiate()
		add_child(room)
		
		sprites_set.color_room(room, generated_maze[room_data])
		content_set.fill_room(room, generated_maze[room_data]["content"])
		room.global_position = Vector2(room_offset.x * room_data.x, room_offset.y * room_data.y)
	

