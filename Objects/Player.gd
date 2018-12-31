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
	# Update direction
	rotation = direction.angle()
	
func _on_moving_finished(direction):
	pass
	
