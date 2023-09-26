class_name MazeGenerator


static func generate_maze(data: Dictionary):
	var room_descriptions = _get_room_descriptions(data)
	var cells = _create_cells(room_descriptions.size())
	var result = {}
	
	var fill_cell = func(cell, room):
		result[cell["position"]] = {
			walls = room["walls"],
			background = room["background"],
			doors = room["doors"],
			content = room["content"],
			gates = cell["gates"]
		}
	var cell_comparer = func(a, b):
		var a_corner = a["gates"] in [1, 2, 4, 8] and a["distance"] != 0
		var b_corner = b["gates"] in [1, 2, 4, 8] and b["distance"] != 0
		if a_corner == b_corner:
			return a["distance"] < b["distance"]
		return b_corner
	room_descriptions.sort_custom(func (a, b): return a["distance"]< b["distance"])
	cells.sort_custom(cell_comparer)
	
	for i in room_descriptions.size():
		fill_cell.call(cells[i], room_descriptions[i])

	return result


static func _get_room_descriptions(data: Dictionary) -> Array:
	var default_theme = data["default_theme"]
	var rooms_to_create = []
	
	var rooms = data["rooms"]
	var themes = data["themes"]
	
	var generation_rules: Array = data["maze_generating_rules"]
	for gen_rule in generation_rules:
		gen_rule["rooms_count"] = gen_rule["avarage_rooms_count"] + randi_range(-gen_rule["max_delta"], gen_rule["max_delta"])
		gen_rule.erase("avarage_rooms_count")
		gen_rule.erase("max_delta")
		
		gen_rule["rooms_of_weight"] = []
		for room_with_weight in gen_rule["rooms_set"]:
			for weight in room_with_weight["random_spawn_weight"]:
				gen_rule["rooms_of_weight"].append(room_with_weight["room_name"])
		gen_rule.erase("rooms_set")
		
		gen_rule["rooms_to_create"] = []
		for i in gen_rule["rooms_count"]:
			gen_rule["rooms_to_create"].append(gen_rule["rooms_of_weight"].pick_random())
		gen_rule.erase("rooms_of_weight")
		gen_rule.erase("rooms_count")
		
		if not gen_rule.has("global_theme"):
			gen_rule["global_theme"] = default_theme
			
		for room_to_create in gen_rule["rooms_to_create"]:
			var room = rooms[room_to_create]
			rooms_to_create.append({
				content = room["content"],
				theme = room.get("theme", gen_rule["global_theme"]),
				distance = gen_rule.get("distance", 5)
			})
	
	for room_to_create in rooms_to_create:
		var theme = themes[room_to_create["theme"]]
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
	
	return rooms_to_create


static func _create_cells(count: int) -> Array:
	var created_cells = [
		{
			gates = 0,
			position=Vector2i.ZERO,
			distance = 0
		}
	]
	var possible_cells = []
	
	var add_to_possible_cells = func (cell: Dictionary):
		for direction in Utils.get_default_directions():
			var new_pos = cell["position"] + Utils.dir_to_vec(Utils.oposite_direction(direction))
			var check1 = possible_cells.all(func(x): return x["position"] != new_pos)
			var check2 = created_cells.all(func(x): return x["position"] != new_pos)
			var check = check1 and check2
			if check:
				possible_cells.append({
					position = cell["position"] + Utils.dir_to_vec(Utils.oposite_direction(direction)),
					prev_cell = cell,
					direction = direction
				})
	var possible_to_created = func() -> Dictionary:
		var cell_idx = randi_range(0, possible_cells.size() - 1)
		var possible_cell = possible_cells[cell_idx]
		var created_cell = {
			position = possible_cell["position"],
			gates = possible_cell["direction"],
			distance = possible_cell["prev_cell"]["distance"] + 1
		}
		possible_cell["prev_cell"]["gates"] = possible_cell["prev_cell"]["gates"] | Utils.oposite_direction(possible_cell["direction"]) 
		created_cells.append(created_cell)
		possible_cells.remove_at(cell_idx)
		return created_cell
	
	add_to_possible_cells.call(created_cells[0])
	for i in count - 1:
		add_to_possible_cells.call(possible_to_created.call())
		
	return created_cells
