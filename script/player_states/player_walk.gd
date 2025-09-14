extends Player_gravity


func on_physic_process(delta):
	controlled_node.play_animation(controlled_node.animtion.walk)
	controlled_node.velocity.x = \
		Input.get_axis("left","right") * controlled_node.movement_speed
	


func on_input(event):
	if Input.is_action_just_pressed("jump"):
		state_machine.chage_to("player_jump")
	elif Input.is_action_just_pressed("attack"):
		state_machine.chage_to("player_attack")
	elif not Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.chage_to("player_idle")
