extends CharacterBody2D
class_name BaseEntity


var velocity_effectors: Array[BaseVelocityEffector] = []
var stats: EntityStats:
	get:
		return $EntityStats
var current_velocity: Vector2:
	get:
		var velocity = Vector2.ZERO
		for velocity_effector in velocity_effectors:
			velocity = velocity_effector.effect_velocity(velocity)
		return velocity


func _physics_process(delta):
	var collision = move_and_collide(current_velocity * delta * stats.speed * Utils.UNIT)
	if collision != null:
		for velocity_effector in velocity_effectors:
			velocity_effector.on_entity_collision(collision)


func add_velocity_effector(velocity_effector: BaseVelocityEffector):
	velocity_effectors.append(velocity_effector)
	velocity_effectors.sort_custom(func(a, b): return a.order < b.order)


func remove_velocity_effector(velocity_effector: BaseVelocityEffector):
	velocity_effectors.erase(velocity_effector)
