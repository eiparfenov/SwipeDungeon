extends Area2D

var time_inside: float
var out_distance: float


func _on_body_entered(body: CollisionObject2D):
	if not body.has_node("VelocityEffectors/SpickesTrapVe"):
		return
	
	$Sprite2D.frame = 1
	var direction: Vector2 = body.current_velocity.normalized()
	var mask = range(1, 33).filter(func(x): return body.get_collision_layer_value(x))
	mask.map(func(x): body.set_collision_layer_value(x, false); return x)
	
	body.get_node("VelocityEffectors/SpickesTrapVe").is_in_trap = true
	body.global_position = global_position
	
	await get_tree().create_timer(time_inside).timeout
	
	body.get_node("VelocityEffectors/SpickesTrapVe").is_in_trap = false
	body.translate(direction * out_distance * Utils.UNIT)
	await get_tree().process_frame
	mask.map(func(x): body.set_collision_layer_value(x, true); return x)
