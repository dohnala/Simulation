extends "res://addons/gut/test.gd"

var Root = preload("res://AI/BT/bt_root.gd")
var Action = preload("res://AI/BT/Task/bt_action.gd")

var _bt
var _action
var _counter

func before_each():
	_counter = 0
	_action = Action.new(funcref(self, "_increment_counter"))
	_bt = Root.new(_action)
	
	add_child(_bt)

func test_action_name():
	assert_eq(_action.get_name(), "Action")

func test_action_path():
	assert_eq(_action.get_path(), "Root/Action")

func test_action_initial_state():
	assert_true(_bt.is_inactive())
	assert_true(_action.is_inactive())
	
func test_action_parent():
	assert_eq(_action.get_parent(), _bt)
	
func test_action_root():
	assert_eq(_action.get_root(), _bt)

func test_action_is_called_on_start():
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_action.is_inactive())
	assert_eq(_counter, 1)
	
func test_action_is_called_every_frame():	
	_bt.start()
	assert_eq(_counter, 1)
	
	gut.simulate(_bt, 9, 1)
	assert_eq(_counter, 10)
	
func test_action_is_not_called_after_stop():
	_bt.start()
	assert_eq(_counter, 1)
	
	_bt.stop()
	assert_true(_action.is_inactive())
	assert_true(_bt.is_inactive())
	
	gut.simulate(_bt, 1, 1)
	assert_eq(_counter, 1)
		
func _increment_counter():
	_counter += 1
