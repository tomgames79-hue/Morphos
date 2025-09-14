extends Player_gravity

func on_physics_procces(delta):
	player.play_animation(player.animations.jump)
	player.velocity.x = \
		Input.get_axis("left", "right") * player.movement_stats.movement_speed 
	if player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y = player.movement_stats.jump_speed
	if player.velocity.y > 0:
		state_machine.change_to("player_falling")
	
	player.move_and_slide()
