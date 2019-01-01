extends Node2D

onready var grid = get_parent()
		
func _ready():
	$Behaviors/Movable.init(self, grid)
	
	# Connect action handlers
	$Controller.connect("action_move_to", $Behaviors/Movable, "handle_move_to")
	
	# Connect event handlers
	$Behaviors/Movable.connect("moving_started", self, "_on_moving_started")
	$Behaviors/Movable.connect("moving_finished", self, "_on_moving_finished")	
	
func _on_moving_started(direction):
	$AnimationPlayer.play(_get_walking_animation(direction))
	
func _on_moving_finished(direction):
	$AnimationPlayer.stop()
	
func _get_walking_animation(direction):
	if (direction.x > 0 && direction.y < 0):
		return "walking_north_east"
		
	if (direction.x < 0 && direction.y < 0):
		return "walking_north_west"	
		
	if (direction.x > 0 && direction.y > 0):
		return "walking_south_east"
		
	if (direction.x < 0 && direction.y > 0):
		return "walking_south_west"
		
	if (direction.y < 0):
		return "walking_north"
		
	if (direction.y > 0):
		return "walking_south"
		
	if (direction.x > 0):
		return "walking_east"
		
	if (direction.x < 0):
		return "walking_west"