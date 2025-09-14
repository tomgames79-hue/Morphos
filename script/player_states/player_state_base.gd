extends StateBase
class_name Player_state_base

var player:Player:
	set (value):
		controlled_node = value
	get:
		return controlled_node
