extends "res://AI/BT/bt_container.gd"

var _decoratee

func _init(name, decoratee).(name):
	_decoratee = decoratee
	_decoratee.set_parent(self)
	
func _set_root(root):
	._set_root(root)
	_decoratee._set_root(root)
	
