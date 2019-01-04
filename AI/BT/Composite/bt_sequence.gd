extends "res://AI/BT/bt_composite.gd"

var _currentIndex

func _init(children).("Sequence", children):
	pass
	
func _start():
	for child in _children:
		assert(child.is_inactive())
		
	_currentIndex = -1
	
	_process_children()
	
func _stop():
	_children[_currentIndex].stop()
	
func _child_stopped(child, result):
	if result:
		_process_children()
	else:
		_stopped(false)
		
func _process_children():
	_currentIndex += 1
	
	if (_currentIndex < _children.size()):
		if (is_stop_requested()):
			_stopped(false)
		else:
			_children[_currentIndex].start()
	else:
		_stopped(true)
