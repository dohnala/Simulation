extends "res://AI/BT/Task/bt_task.gd"
	
var _entity
var _target_position
	
func _init(entity, target_position).("MoveTo"):
	_entity = entity
	_target_position = target_position
		
func _start():
	var movement = _entity.get_movement()
		
	if movement:
		if movement.move_to(_target_position, funcref(self, "_on_move_complete")):
			print("Start moving to %s" % _target_position)
		else:
			print("Moving to %s refused" % _target_position)
			_stopped(false)
	else:
		print("Entity has no movement component")
		_stopped(false)
	
func _stop():
	var movement = _entity.get_movement()
		
	if movement:
		movement.stop()
	else:
		print("Moving to %s stopped" % _target_position)
		_stopped(false)
			
func _on_move_complete():
	if is_stop_requested():
		print("Moving to %s stopped" % _target_position)
		_stopped(false)
	else:
		print("Moving to %s completed" % _target_position)
		_stopped(true)