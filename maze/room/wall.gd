extends StaticBody2D
class_name Wall

@export var direction: Utils.Direction

var is_door: bool:
	get: return is_door
	set(value):
		is_door = value
		$"DoorBottom".visible = is_door
		$"DoorTop".visible = is_door
		$"DoorDoor".visible = is_door

