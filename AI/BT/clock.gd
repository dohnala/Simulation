class Timer:
	var _time
	
var _time = 0
var _timers = {}

func add_timer(interval, callback):
	var timer = Timer.new()
	timer._time = _time + interval
	
	_timers[callback] = timer
	
func remove_timer(callback):
	_timers.erase(callback)
	
func update(time_ellapsed):
	_time += time_ellapsed
	
	for callback in _timers:
		var timer = _timers[callback]
		
		if _time >= timer._time:
			remove_timer(callback)
			callback.call_func()
	