extends Node2D


@export_file("*.txt") var level: String
@export var room_name: String
@export var gates: Utils.Direction

var room_scene = preload("res://maze/room/room.tscn")

func _ready():
	var file = FileAccess.open(level, FileAccess.READ)
	var data = str_to_var(file.get_as_text())
	
	var sprites_set = SpritesSet.new(data["sprites"])
	var content_set = ContentSet.new(data["contents"])
	var room_to_create = data["rooms"][room_name]
	var theme = data["themes"][room_to_create.get("theme", data["default_theme"])]
	
	room_to_create["background"] = theme["background"].pick_random()
	room_to_create["walls"] = {
		Utils.Direction.Top: theme["walls"].pick_random(),
		Utils.Direction.Left: theme["walls"].pick_random(),
		Utils.Direction.Bottom: theme["walls"].pick_random(),
		Utils.Direction.Right: theme["walls"].pick_random(),
		}
	room_to_create["doors"] = {
		Utils.Direction.Top: theme["doors"].pick_random(),
		Utils.Direction.Left: theme["doors"].pick_random(),
		Utils.Direction.Bottom: theme["doors"].pick_random(),
		Utils.Direction.Right: theme["doors"].pick_random(),
		}
	room_to_create.erase("theme")
	room_to_create["gates"] = gates
	
	var room = room_scene.instantiate()
	add_child(room)
	sprites_set.color_room(room, room_to_create)
	content_set.fill_room(room, room_to_create["content"])
	
	print(var_to_str(Vector2(1, 1.5)))
