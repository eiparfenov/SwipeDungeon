extends Node2D
class_name Damageable

var health: int
signal health_changed(health: int)
signal died
signal damaged(damage: int)

func apply_damage(damage: float):
	if randf() < (damage - floori(damage)):
		damage += 1
	
	health -= floori(damage)
	
	health_changed.emit(health)
	if health <= 0:
		died.emit()
	
	damaged.emit(damage)
	
