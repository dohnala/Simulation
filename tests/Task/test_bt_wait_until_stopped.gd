extends "res://addons/gut/test.gd"

var Root = preload("res://AI/BT/bt_root.gd")
var WaitUntilStopped = preload("res://AI/BT/Task/bt_wait_until_stopped.gd")

var _bt
var _wait_until_stopped

func before_each():
	_wait_until_stopped = WaitUntilStopped.new()
	_bt = Root.new(_wait_until_stopped)
	
	add_child(_bt)
	
func test_wait_until_stopped_name():
	assert_eq(_wait_until_stopped.get_name(), "WaitUntilStopped")

func test_wait_until_stopped_path():
	assert_eq(_wait_until_stopped.get_path(), "Root/WaitUntilStopped")

func test_wait_until_stopped_initial_state():
	assert_true(_bt.is_inactive())
	assert_true(_wait_until_stopped.is_inactive())
	
func test_wait_until_stopped_parent():
	assert_eq(_wait_until_stopped.get_parent(), _bt)

func test_wait_until_stopped_root():
	assert_eq(_wait_until_stopped.get_root(), _bt)

func test_wait_until_stopped_is_started():
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_wait_until_stopped.is_active())

func test_wait_until_stopped_is_waiting():
	_bt.start()
	
	gut.simulate(_bt, 1, 1)
	
	assert_true(_bt.is_active())
	assert_true(_wait_until_stopped.is_active())
	
func test_waint_until_stopped_is_stopped():
	_bt.start()
	_bt.stop()
	
	assert_true(_bt.is_inactive())
	assert_true(_wait_until_stopped.is_inactive())
	