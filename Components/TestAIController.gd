extends "res://Objects/AIController.gd"

var _bt

func init(entity, environment):
	.init(entity, environment)
	
	_bt = createBT(
		sequence([
			move_to(Vector2(64, 64)),
			move_to(Vector2(224, 64))]))
			
	add_child(_bt)

func _physics_process(delta):
	if not _bt.is_active():
		_bt.start()
	
func _exit_tree():
	_bt.stop()
	remove_child(_bt)