/obj/Hazard/Spikes/Acidblock
	name = "Acid Block"
	density = 1
	icon = 'Brick.dmi'
	icon_state = "AcidBlock"

	var
		Cooldown = 0

	proc
		SpawnBubble()
			Cooldown = rand() * 1.1 * world.fps

			if( IsOnScreen(32) )
				var/obj/Decor/Bubble/M = new /obj/Decor/Bubble(get_step(loc, NORTH))
				M.step_x = rand(-14,14)
				M.pixel_y = -6
				M.Life = rand(11,23)

	Tick()
		Cooldown -= 1

		if( Cooldown <= 0 )
			SpawnBubble()
