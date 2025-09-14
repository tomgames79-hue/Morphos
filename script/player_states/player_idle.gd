extends Player_gravity



func on_physic_process(delta):
	player.play_animation(player.animations.idle)
	player.velocity.x = 0
	
	
	player.move_and_slide()



func on_input(event):
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.chage_to("player_walk") 
	elif Input.is_action_just_pressed("jump"):
		state_machine.chage_to("player_jump")
	elif Input.is_action_just_pressed("attack"):
		state_machine.chage_to("player_attack")
