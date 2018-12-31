extends Node

signal action_move_to(target_position)

func _input(event):
	if event.is_action_pressed('click'):
		emit_signal("action_move_to", get_global_mouse_position())
