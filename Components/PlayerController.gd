extends "res://Components/Controller.gd"

func _input(event):
	if event.is_action_pressed('click'):
		var movement = _entity.get_movement()
		
		if movement:
			movement.move_to(get_global_mouse_position())