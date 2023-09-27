extends Node2D
class_name BaseVelocityEffector


@export var order: int
var stats: EntityStats:
	get:
		return get_node("../EntityStats")
var entity: BaseEntity:
	get:
		return get_node("../..")


func _ready():
	entity.add_velocity_effector(self)


func _exit_tree():
	entity.remove_velocity_effector(self)


func effect_velocity(velocity: Vector2) -> Vector2:
	return Vector2.ZERO


func on_entity_collision(collision: KinematicCollision2D):
	pass
