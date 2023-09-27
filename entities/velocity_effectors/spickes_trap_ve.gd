extends BaseVelocityEffector
class_name SpikesTrapVelocityEffector

var is_in_trap: bool = false


func effect_velocity(velocity: Vector2) -> Vector2:
	return Vector2.ZERO if is_in_trap else velocity
