extends "res://AI/BT/bt_container.gd"

var _children

func _init(name, children).(name):
	assert(children.size() > 0)
	_children = children
	
	for child in _children:
		child.set_parent(self)
		
func _set_root(root):
	._set_root(root)
	
	for child in _children:
		child._set_root(root)
