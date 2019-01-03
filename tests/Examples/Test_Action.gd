extends Node2D

var Root = preload("res://AI/BT/bt_root.gd")
var Action = preload("res://AI/BT/Task/bt_action.gd")

onready var _bt = Root.new(
	Action.new(funcref(self, "_action")))

func _ready():
	add_child(_bt)
	_bt.start()
	
func _action():
	print("Action called")
