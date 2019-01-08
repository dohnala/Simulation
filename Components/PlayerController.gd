extends "res://Components/Controller.gd"

func _input(event):
	if event.is_action_pressed('click'):
		if _entity.get_movement():
			_entity.get_movement().move_to(get_global_mouse_position())
	elif event.is_action_pressed('use'):
		if _entity.get_hand():
			_entity.get_hand().pickup()