extends BaseVelocityEffector
class_name PlayerControlVelocityEffector

var direction: Vector2 = Vector2.ZERO

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
	if Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
	if Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
	if Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN
	

func effect_velocity(velocity: Vector2) -> Vector2:
	return direction


func on_entity_collision(collision: KinematicCollision2D):
	direction = -direction
