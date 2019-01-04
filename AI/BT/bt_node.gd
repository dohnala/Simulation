extends Node

enum State {
	ACTIVE,
	STOP_REQUESTED,
	INACTIVE
}

var _name setget ,get_name
var _currentState = INACTIVE
var _root setget _set_root, get_root
var _parent setget set_parent, get_parent

func _init(name):
	_name = name

func get_name():
	return _name
	
func set_parent(parent):
	_parent = parent
	
func get_root():
	return _root
	
func get_parent():
	return _parent
	
func is_active():
	return _currentState == ACTIVE
	
func is_stop_requested():
	return _currentState == STOP_REQUESTED
	
func is_inactive():
	return _currentState == INACTIVE
	
func start():
	assert(is_inactive())
	
	_currentState = ACTIVE
	_start()
	
func stop():
	assert(is_active())
	
	_currentState = STOP_REQUESTED
	_stop()
	
func get_path():
	if _parent:
		return _parent.get_path() + "/" + get_name()
		
	return get_name()
	
func _set_root(root):
	_root = root
	
func _start():
	pass
	
func _stop():
	pass
	
func _stopped(result):
	assert(not is_inactive())
	
	_currentState = INACTIVE
	
	if _parent:
		_parent._child_stopped(self, result)
		
func _add_timer(interval, callback):
	if _root:
		_root._add_timer(interval, callback)
		
func _remove_timer(callback):
	if _root:
		_root._remove_timer(callback)