extends "res://addons/gut/test.gd"

var Root = preload("res://tests/Utils/_test_root.gd")
var Sequence = preload("res://AI/BT/Composite/bt_sequence.gd")
var Node = preload("res://tests/Utils/_test_node.gd")

var _bt
var _sequence
var _node
var _node_a
var _node_b

func _create_sequence_with_single_child(node_result_on_explicit_stop=false):
	_node = Node.new(node_result_on_explicit_stop)
	_sequence = Sequence.new([_node])
	_bt = Root.new(_sequence)
	
	add_child(_bt)

func _create_sequence_with_two_children():
	_node_a = Node.new()
	_node_b = Node.new()
	_sequence = Sequence.new([_node_a, _node_b])
	_bt = Root.new(_sequence)
	
	add_child(_bt)
	
func test_sequence_name():
	_create_sequence_with_single_child()
	
	assert_eq(_sequence.get_name(), "Sequence")

func test_sequence_path():
	_create_sequence_with_single_child()
	
	assert_eq(_sequence.get_path(), "Root/Sequence")

func test_sequence_initial_state():
	_create_sequence_with_single_child()
	
	assert_true(_bt.is_inactive())
	assert_true(_sequence.is_inactive())
	assert_true(_node.is_inactive())
	
func test_sequence_parent():
	_create_sequence_with_single_child()
	
	assert_eq(_sequence.get_parent(), _bt)
	assert_eq(_node.get_parent(), _sequence)
	
func test_sequence_root():
	_create_sequence_with_single_child()
	
	assert_eq(_sequence.get_root(), _bt)
	assert_eq(_node.get_root(), _bt)
	
func test_sequence_fail_when_single_child_fails():
	_create_sequence_with_single_child()
	
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node.is_active())
	
	_node.finish(false)
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_inactive())
	assert_true(_node.is_inactive())
	
	assert_true(_bt._finished)
	assert_false(_bt._result)
	
func test_sequence_success_when_single_child_succeeds():
	_create_sequence_with_single_child()
	
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node.is_active())
	
	_node.finish(true)
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_inactive())
	assert_true(_node.is_inactive())
	
	assert_true(_bt._finished)
	assert_true(_bt._result)
	
func test_sequence_fail_when_stopped_explicitelly():
	_create_sequence_with_single_child(false)
	
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node.is_active())
	
	_sequence.stop()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_inactive())
	assert_true(_node.is_inactive())
	
	assert_true(_bt._finished)
	assert_false(_bt._result)
	
func test_sequence_success_when_stopped_explicitelly_but_child_succeeded():
	_create_sequence_with_single_child(true)
	
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node.is_active())
	
	_sequence.stop()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_inactive())
	assert_true(_node.is_inactive())
	
	assert_true(_bt._finished)
	assert_true(_bt._result)
	
func test_sequence_fail_when_first_child_fails():
	_create_sequence_with_two_children()
	
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node_a.is_active())
	assert_true(_node_b.is_inactive())	
	
	_node_a.finish(false)
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_inactive())
	assert_true(_node_a.is_inactive())
	assert_true(_node_b.is_inactive())	
	
	assert_true(_bt._finished)
	assert_false(_bt._result)
	
func test_sequence_proceed_when_first_child_succeeded():
	_create_sequence_with_two_children()
	
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node_a.is_active())
	assert_true(_node_b.is_inactive())	
	
	_node_a.finish(true)
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node_a.is_inactive())
	assert_true(_node_b.is_active())	
	
	assert_false(_bt._finished)
	
func test_sequence_success_when_all_children_succeeded():
	_create_sequence_with_two_children()
	
	_bt.start()
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node_a.is_active())
	assert_true(_node_b.is_inactive())	
	
	_node_a.finish(true)
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_active())
	assert_true(_node_a.is_inactive())
	assert_true(_node_b.is_active())	
	
	_node_b.finish(true)
	
	assert_true(_bt.is_active())
	assert_true(_sequence.is_inactive())
	assert_true(_node_a.is_inactive())
	assert_true(_node_b.is_inactive())	
	
	assert_true(_bt._finished)
	assert_true(_bt._result)