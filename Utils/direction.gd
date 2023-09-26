class_name Utils

enum Direction {
	Top = 1,
	Left = 2,
	Bottom = 4,
	Right = 8,
	Vectrical = 5, 
	Horizontal = 10
	}

static func get_default_directions() -> Array[Direction]:
	return [Direction.Top, Direction.Left, Direction.Bottom, Direction.Right ]


static func dir_to_vec(dir: Direction) -> Vector2i:
	match dir:
		1:
			return Vector2i.UP
		2:
			return Vector2i.LEFT
		4:
			return Vector2i.DOWN
		8:
			return Vector2i.RIGHT
	return Vector2i.ZERO


static func oposite_direction(dir: Direction) -> Direction:
	dir = dir << 2 | dir >> 2
	dir = dir % 16
	return dir
