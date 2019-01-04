extends "res://AI/BT/bt_node.gd"

var _succeeds_on_explict_stop

func _init(succeeds_on_explict_stop=false).("TestNode"):
	_succeeds_on_explict_stop = succeeds_on_explict_stop
	
func finish(result):
	_stopped(result)
	
func _stop():
	_stopped(_succeeds_on_explict_stop)
