extends "res://AI/BT/bt_node.gd"

func _init(name).(name):
	pass
	
func child_stopped(child, result):
	assert(not is_inactive())
	
	_child_stopped(child, result)
	
func _child_stopped(child, result):
	pass
