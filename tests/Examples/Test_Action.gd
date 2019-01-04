extends Node2D

var Root = preload("res://AI/BT/bt_root.gd")
var Sequence = preload("res://AI/BT/Composite/bt_sequence.gd")
var Action = preload("res://AI/BT/Task/bt_action.gd")
var WaitUntilStopped = preload("res://AI/BT/Task/bt_wait_until_stopped.gd")

onready var _bt = Root.new(
	Sequence.new([
		Action.new(funcref(self, "_action")),
		WaitUntilStopped.new()]))

func _ready():
	add_child(_bt)
	_bt.start()
	
func _exit_tree():
	_bt.stop()
	
func _action():
	print("Action called")
