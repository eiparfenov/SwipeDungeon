extends BaseVelocityEffector

var direction: Vector2


const POSSIBLE_DIRECTIONS = [
	Vector2(1, 1),
	Vector2(1, -1),
	Vector2(-1, 1),
	Vector2(-1, -1),
]


func _ready():
	direction = POSSIBLE_DIRECTIONS.pick_random()


func effect_velocity(velocity: Vector2) -> Vector2:
	return direction.normalized()


func on_entity_collision(collision: KinematicCollision2D):
	pass
