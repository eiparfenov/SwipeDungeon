extends BaseVelocityEffector
class_name DirtTrapVelocityEffector


var dirt_trap_multiplier: float = 1


func effect_velocity(velocity: Vector2) -> Vector2:
	return velocity * dirt_trap_multiplier
