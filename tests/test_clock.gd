extends "res://addons/gut/test.gd"

var Clock = preload("res://AI/BT/clock.gd")

var _clock
var _counter

func before_each():
	_clock = Clock.new()
	_counter = 0
	
func test_initial_time():
	assert_eq(_clock._time, 0)
	
func test_time_after_update():
	_clock.update(10)
	assert_eq(_clock._time, 10)
	
func test_initial_timers():
	assert_true(_clock._timers.empty())
	
func test_add_timer():
	_clock.add_timer(0, funcref(self, "_increment_counter"))
	
	assert_eq(_counter, 0)
	assert_eq(_clock._timers.size(), 1)
	
func test_update_timer():
	_clock.add_timer(0, funcref(self, "_increment_counter"))
	
	_clock.update(1)
	assert_eq(_counter, 1)

func test_update_timer_twice():
	_clock.add_timer(10, funcref(self, "_increment_counter"))
	
	_clock.update(5)
	assert_eq(_counter, 0)

	_clock.update(5)
	assert_eq(_counter, 1)
	
func test_remove_timer():
	var callback = funcref(self, "_increment_counter")
	
	_clock.add_timer(0, callback)
	_clock.remove_timer(callback)
	
	_clock.update(5)
	assert_eq(_counter, 0)
	
func _increment_counter():
	_counter += 1