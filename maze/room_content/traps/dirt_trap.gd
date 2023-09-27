extends Area2D
class_name DirtTrap

var slow_k: float



func _on_body_entered(body):
	if not body.has_node("VelocityEffectors/DirtTrapVe"):
		return
	
	body.get_node("VelocityEffectors/DirtTrapVe").dirt_trap_multiplier *= slow_k


func _on_body_exited(body):
	if not body.has_node("VelocityEffectors/DirtTrapVe"):
		return
	
	body.get_node("VelocityEffectors/DirtTrapVe").dirt_trap_multiplier /= slow_k
