extends Node

signal moving_started
signal moving_finished

# Entity this component belongs to
var _entity

# Environment entity is inside
var _environment

# Movement speed
var _speed

# Flag whether to draw movement path
var _draw_path

# Flag whether the entity is moving
var _is_moving

# Current movement path
var _move_path

# Callback to call after moving is completed
var _on_complete

func init(entity, environment, speed=1.0, draw_path=false):
	_entity = entity
	_environment = environment
	_speed = speed
	_draw_path = draw_path

# Move current entity to given target position
# @param target_position target position
# @param on_complete callback called when moving is completed
# @eturn true if accepted
func move_to(target_position, on_complete=null):
	if _is_moving:
		_move_path = _environment.get_path(_move_path[0], target_position)
	else:
		_move_path = _environment.get_path(_entity.position, target_position)
		_move_path.remove(0)

	if _draw_path:
		_draw_move_path()
		
	_on_complete = on_complete
		
	return true
	
# Make current entity stop moving
func stop():
	if _is_moving && _move_path:
		_move_path = [_move_path[0]]
	else:
		_move_path = null
		
	if _draw_path:
		_draw_move_path()

func _process(delta):
	if _move_path:
		_move_to(_move_path[0])

func _move_to(position):
	set_process(false)

	var direction = position - _entity.position

	if direction.x > 0 && _entity.scale.x == -1:
		_entity.scale.x = 1
	elif direction.x < 0 && _entity.scale.x == 1:
		_entity.scale.x = -1

	if not _is_moving:
		_is_moving = true
		emit_signal("moving_started")

	$Tween.interpolate_property(_entity, "position", _entity.position, position, _speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN)

	$Tween.start()

	yield($Tween, "tween_completed")

	if _move_path:
		_move_path.remove(0)
	
	if not _move_path:
		_is_moving = false
		emit_signal("moving_finished")
	
		if _on_complete:
			var callback = _on_complete
			_on_complete = null		
			callback.call_func()

	if _draw_path:
		_draw_move_path()
		
	set_process(true)

func _draw_move_path():
	var path = _move_path.duplicate()
	path.insert(0, _entity.position)
	_environment.draw_path(path)


