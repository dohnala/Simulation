extends "res://addons/gut/test.gd"

var Root = preload("res://tests/Utils/_test_root.gd")
var Node = preload("res://tests/Utils/_test_node.gd")

var _bt
var _node

func before_each():
	_node = Node.new()
	_bt = Root.new(_node)
	
	add_child(_bt)
	
func test_root_name():
	assert_eq(_bt.get_name(), "Root")

func test_root_path():
	assert_eq(_bt.get_path(), "Root")

func test_root_initial_state():
	assert_true(_bt.is_inactive())
	assert_true(_node.is_inactive())
	
func test_root_parent():
	assert_false(_bt.get_parent())

func test_root_root():
	assert_eq(_bt.get_root(), _bt)
	
func test_root_start():
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_node.is_active())
	
func test_root_fails_when_main_node_failed():
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_node.is_active())
	
	_node.finish(false)
	
	assert_true(_bt.is_active())
	assert_true(_node.is_inactive())
	
	assert_true(_bt._finished)
	assert_false(_bt._result)

func test_root_succeeds_when_main_node_succeeded():
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_node.is_active())
	
	_node.finish(true)
	
	assert_true(_bt.is_active())
	assert_true(_node.is_inactive())
	
	assert_true(_bt._finished)
	assert_true(_bt._result)	
	
func test_root_stop():
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_node.is_active())
	
	_bt.stop()
	
	assert_true(_bt.is_inactive())
	assert_true(_node.is_inactive())
	
	assert_true(_bt._finished)
	assert_false(_bt._result)	