extends Node

export (float) var speed = 1

signal moving_started(direction)
signal moving_finished(direction)

var _entity
var _environment

var _is_moving = false
var _move_path

func init(entity, environment):
	_entity = entity
	_environment = environment

func _process(delta):
	if not _is_moving && _move_path:
		_move_to(_move_path[0])

func handle_move_to(target_position):
	if _is_moving:
		_move_path = _environment.get_path(_move_path[0], target_position)
	else:
		_move_path = _environment.get_path(_entity.position, target_position)
		_move_path.remove(0)

	_draw_move_path()

func _move_to(target_position):
	var direction = target_position - _entity.position

	_is_moving = true
	emit_signal("moving_started", direction)

	$Tween.interpolate_property(_entity, "position", _entity.position, target_position, speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN)

	$Tween.start()

	yield($Tween, "tween_completed")

	_move_path.remove(0)
	_is_moving = false
	emit_signal("moving_finished", direction)

	_draw_move_path()

func _draw_move_path():
	var path = _move_path.duplicate()
	path.insert(0, _entity.position)
	_environment.draw_path(path)


