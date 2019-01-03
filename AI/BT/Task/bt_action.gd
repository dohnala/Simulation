extends "res://AI/BT/Task/bt_task.gd"

var _action

func _init(action).("Action"):
	_action = action
	
func _start():
	if _action:
		_action.call_func()
		_stopped(true)
