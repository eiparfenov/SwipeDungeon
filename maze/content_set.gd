class_name ContentSet

var _content_scenes: Dictionary = {}


func _init(content_data: Dictionary):
	for content_name in content_data:
		_content_scenes[content_name] = load(content_data[content_name])


func fill_room(room: Room, contents_data: Array):
	var content_parent = room.get_node("Content")
	for content_data in contents_data:
		var content: Node2D = _content_scenes[content_data["name"]].instantiate()
		for content_var in content_data.keys().filter(func(x): return not x in ["name", "position"] and x in content):
			content.set(content_var, content_data[content_var])
		content_parent.add_child(content)
		content.position = content_data["position"] * Utils.UNIT
