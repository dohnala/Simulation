extends "res://Objects/Controller.gd"

var _Root = preload("res://AI/BT/bt_root.gd") 

# Composites
var _Sequence = preload("res://AI/BT/Composite/bt_sequence.gd") 

# Tasks
var _Action = preload("res://AI/BT/Task/bt_action.gd") 
var _WaitUntilStopped = preload("res://AI/BT/Task/bt_wait_until_stopped.gd") 
var _MoveTo = preload("res://AI/BT/Task/move_to.gd") 

func createBT(node):
	return _Root.new(node)
	
func sequence(nodes):
	return _Sequence.new(nodes)

func action(action):
	return _Action.new(action)
	
func wait_until_stopped():
	return _WaitUntilStopped.new()
	
func move_to(target_position):
	return _MoveTo.new(_entity, target_position)