extends "res://AI/BT/bt_root.gd"

var _finished
var _result

func _init(main_node).(main_node):
	pass
	
func _start():
	_finished = false
	._start()
	
func _child_stopped(child, result):
	_finished = true
	_result = result
	._child_stopped(child, result)
