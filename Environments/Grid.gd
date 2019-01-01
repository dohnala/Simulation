extends TileMap

export(Vector2) var grid_size = Vector2(20, 20)
export(bool) var show_grid = false

var _obstacle_ids = [3, 4, 5, 6, 7, 8]

onready var _astar_node = AStar.new()
onready var _obstacles = _get_obstacles()
onready var _half_cell_size = cell_size / 2

var _path_to_draw

func _ready():
	var walkable_points = _add_walkable_cells(_obstacles)
	_connect_walkable_cells(walkable_points)

func _draw():
	if show_grid:
		_draw_grid()
	
	if _path_to_draw:
		_draw_path(_path_to_draw)

func get_path(world_from, world_to):	
	var from_point = world_to_map(world_from)
	var from_index = _calculate_point_index(from_point)
	var to_point = world_to_map(world_to)
	var to_index = _calculate_point_index(to_point)
	
	if not _astar_node.has_point(to_index):
		to_index = _astar_node.get_closest_point(Vector3(to_point.x, to_point.y, 0.0))
	
	var point_path = _astar_node.get_point_path(from_index, to_index)
	var world_path = []
	
	for point in point_path:
		var world_point = map_to_world(Vector2(point.x, point.y)) + _half_cell_size
		world_path.append(world_point)
	
	return world_path
	
func draw_path(path):
	_path_to_draw = path
	update()
	
func _get_obstacles():
	var obstacles = []
	
	for position in get_used_cells():
		if _obstacle_ids.has(get_cell(position.x, position.y)):
			obstacles.append(position)
	
	return obstacles
	
func _add_walkable_cells(__astar_node = []):
	var points_array = []
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var point = Vector2(x, y)
			if point in __astar_node:
				continue
				
			var point_index = _calculate_point_index(point)	
			
			points_array.append(point)
			_astar_node.add_point(point_index, Vector3(point.x, point.y, 0.0))
	return points_array
	
func _connect_walkable_cells(points_array):
	for point in points_array:
		var point_index = _calculate_point_index(point)
		
		for y in [-1, 0, 1]:
			for x in [-1, 0, 1]:
				var point_relative = Vector2(point.x + x, point.y + y)
				
				if _should_be_connected(point, point_relative):
					var point_relative_index = _calculate_point_index(point_relative)
					_astar_node.connect_points(point_index, point_relative_index, true)
			
func _should_be_connected(from, to):
	var from_index = _calculate_point_index(from)
	var to_index = _calculate_point_index(to)
	
	if from == to:
		return false
	
	if _is_outside_map_bounds(from) || _is_outside_map_bounds(to):
		return false
		
	if not (_astar_node.has_point(from_index) && _astar_node.has_point(to_index)):
		return false
		
	if not _astar_node.has_point(_calculate_point_index(Vector2(from.x, to.y))):
		return false
	
	if not _astar_node.has_point(_calculate_point_index(Vector2(to.x, from.y))):
		return false
		
	return true	
	
			
func _calculate_point_index(point):
	return point.x + grid_size.x * point.y
	
func _is_outside_map_bounds(point):
	return point.x < 0 or point.y < 0 or point.x >= grid_size.x or point.y >= grid_size.y
	
func _draw_grid():	
	for x in grid_size.x:
		var start = Vector2(x * cell_size.x, 0)
		var end = Vector2(x * cell_size.x, grid_size.y * cell_size.y)
		
		draw_line(start, end, Color('#fff'), 1.0, true)
		
	for y in grid_size.y:
		var start = Vector2(0, y * cell_size.y)
		var end = Vector2(grid_size.x * cell_size.x, y * cell_size.y)
		
		draw_line(start, end, Color('#fff'), 1.0, true)
	
func _draw_path(path):
	var last = path[0]
	
	for i in range(1, len(path)):
		var current = path[i]
		
		draw_line(last, current, Color('#fff'), 3.0, true)
		
		last = current