extends Node2D

# Return array of collision points
func get_collision_points():
	var points = []
	
	for point in $CollisionPoints.get_children():
		points.append(position + point.position)
		
	return points
