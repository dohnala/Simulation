extends "res://AI/BT/bt_decorator.gd"

const Clock = preload("res://AI/BT/clock.gd")

var _clock
var _main_node
var _start_callback

func _init(main_node).("Root", main_node):
	_clock = Clock.new()
	_main_node = main_node
	_start_callback = funcref(self, "_start")
	_set_root(self)
	
func _start():
	_main_node.start()
	
func _stop():
	if _main_node.is_active():
		_main_node.stop()
	else:
		_remove_timer(_start_callback)
		_stopped(false)
		
func _child_stopped(child, result):
	if is_stop_requested():
		_stopped(result)
	else:
		_add_timer(0, _start_callback)
		
func _add_timer(interval, callback):	
	assert(_clock)
	_clock.add_timer(interval, callback)
	
func _remove_timer(callback):
	assert(_clock)
	_clock.remove_timer(callback)
	
func _physics_process(delta):
	assert(_clock)
	_clock.update(delta)
	