/mob/Player
	icon = 'Player.dmi'
	icon_state = "Player"

	bound_x = 4
	bound_y = 0
	bound_width = 24
	bound_height = 24

	var
		const
			MaxAccel = 1.2
			JumpSpeed = 8.9
			MaxSpeed = 4

	New()
		..()
		loc = locate(/obj/PlayerStart) in world
		loc = get_turf(loc)

	Tick()
		..()


		if (!client)
			return;

		client.KeyTick()

		if (client.ButtonPressed("East"))
			XVelocity = min(XVelocity + MaxAccel, MaxSpeed)
		else if (client.ButtonPressed("West"))
			XVelocity = max(XVelocity - MaxAccel, -MaxSpeed)
		else
			XVelocity = round(XVelocity * 0.4, 0.1)
		if (client.ButtonPressed("Space") && Grounded)
			YVelocity = JumpSpeed