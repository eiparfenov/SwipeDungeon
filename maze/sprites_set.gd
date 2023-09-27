class_name SpritesSet

var v_door_tops: Dictionary
var v_door_doors: Dictionary
var v_door_bottoms: Dictionary
var v_walls: Dictionary

var h_door_tops: Dictionary
var h_door_doors: Dictionary
var h_door_bottoms: Dictionary
var h_walls: Dictionary

var backgrounds: Dictionary


func _init(init_data: Dictionary):
	backgrounds = {}
	for background_name in init_data["backgrounds"].keys():
		backgrounds[background_name] = load(init_data["backgrounds"][background_name])
	
	v_walls = {}
	for wall_name in init_data["horizontal_sprites"]["walls"].keys():
		v_walls[wall_name] = load(init_data["horizontal_sprites"]["walls"][wall_name])
	
	h_walls = {}
	for wall_name in init_data["vertical_sprites"]["walls"].keys():
		h_walls[wall_name] = load(init_data["vertical_sprites"]["walls"][wall_name])
	
	h_door_tops = {}
	h_door_doors = {}
	h_door_bottoms = {}
	for door_name in init_data["horizontal_sprites"]["doors"].keys():
		h_door_tops[door_name] = load(init_data["horizontal_sprites"]["doors"][door_name]["top"])
		h_door_doors[door_name] = load(init_data["horizontal_sprites"]["doors"][door_name]["door"])
		h_door_bottoms[door_name] = load(init_data["horizontal_sprites"]["doors"][door_name]["bottom"])
	
	v_door_tops = {}
	v_door_doors = {}
	v_door_bottoms = {}
	for door_name in init_data["vertical_sprites"]["doors"].keys():
		v_door_tops[door_name] = load(init_data["vertical_sprites"]["doors"][door_name]["top"])
		v_door_doors[door_name] = load(init_data["vertical_sprites"]["doors"][door_name]["door"])
		v_door_bottoms[door_name] = load(init_data["vertical_sprites"]["doors"][door_name]["bottom"])


func get_wall(name: String, direction: Utils.Direction) -> Texture2D:
	var source: Dictionary
	if Utils.Direction.Vectrical & direction:
		source = h_walls
	else:
		source = v_walls
	
	if not source.has(name):
		assert(false, "Can't find %s wall with name %s!" % [direction, name])
		return null
	
	return source[name]


func get_door(name: String, direction: Utils.Direction) -> Array:
	var sources: Array[Dictionary]
	if Utils.Direction.Horizontal & direction:
		sources = [h_door_tops, h_door_doors, h_door_bottoms]
	else:
		sources = [v_door_tops, v_door_doors, v_door_bottoms]
	
	if not sources.all(func (x): return x.has(name)):
		assert(false, "Can't find %s door with name %s!" % [direction, name])
		return [null, null, null]
	
	return sources.map(func (x): return x[name])


func get_background(name: String) -> Texture2D:
	if not backgrounds.has(name):
		assert(false, "Can't find background with name %s!" % name)
		return null
	
	return backgrounds[name]


func color_room(room: Room, room_data: Dictionary):
	room.get_node("Background").texture = backgrounds[room_data["background"]]
	for wall in room.get_node("Walls").get_children():
		wall.get_node("Wall").texture = get_wall(room_data["walls"][wall.direction], wall.direction)
		var door = get_door(room_data["doors"][wall.direction], wall.direction)
		wall.get_node("DoorTop").texture = door[0]
		wall.get_node("DoorDoor").texture = door[1]
		wall.get_node("DoorBottom").texture = door[2]
		wall.is_door = wall.direction & room_data["gates"]
