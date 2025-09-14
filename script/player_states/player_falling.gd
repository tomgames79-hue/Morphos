extends Player_gravity


func on_physics_process(delta):
	player.velocity.x = \
		Input.get_axis("left", "right") * player.movement_stats.movement_speed
	if player.velocity.y >= 0 and player.is_on_floor():
		state_machine.chage_to("player_idle")
	
