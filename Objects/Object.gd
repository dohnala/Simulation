extends Node2D

onready var sprites = $Sprites
onready var area = $Area

const highlight_material = preload("res://Materials/highlight_material.tres")

func _ready():
	for sprite in sprites.get_children():
		sprite.set_material(highlight_material.duplicate())
	
	area.connect("mouse_entered", self, "_mouse_entered")
	area.connect("mouse_exited", self, "_mouse_exited")

# Return array of collision points
func get_collision_points():
	var points = []
	
	for point in $CollisionPoints.get_children():
		points.append(position + point.position)
		
	return points

func _mouse_entered():
	print(name)
	for sprite in sprites.get_children():
		sprite.material.set_shader_param("whitening", 0.4)
	
func _mouse_exited():
	for sprite in sprites.get_children():
		sprite.material.set_shader_param("whitening", 0)