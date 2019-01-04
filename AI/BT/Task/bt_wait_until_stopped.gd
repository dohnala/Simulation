extends "res://AI/BT/Task/bt_task.gd"

var _result

func _init(result = false).("WaitUntilStopped"):
	_result = result
	
func _stop():
	_stopped(_result)

