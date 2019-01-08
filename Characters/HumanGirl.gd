extends Node2D

export (float) var movement_speed = 1.0

onready var grid = get_parent()
		
func _ready():
	# Init components
	$Components/Movement.init(self, grid, movement_speed)
	$Components/Controller.init(self, grid)
		
	# Connect event handlers
	$Components/Movement.connect("moving_started", self, "_on_moving_started")
	$Components/Movement.connect("moving_finished", self, "_on_moving_finished")	
	
func get_animation():
	return $Components/Animation
	
func get_controller():
	return $Components/Controller
	
func get_movement():
	return $Components/Movement
	
func _on_moving_started():	
	get_animation().play("walk")
	
func _on_moving_finished():
	get_animation().play("idle")