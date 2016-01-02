/mob/Player
	icon = 'Player.dmi'
	icon_state = "Player"

	bound_x = 4
	bound_y = 0
	bound_width = 24
	bound_height = 24

	var
		Emeralds = 0

		const
			MaxAccel = 1.2
			MaxDecel = 1.3
			JumpSpeed = 8.9
			MaxSpeed = 6

	New()
		..()

	Tick()
		if (!client) // If the client disconnected, twiddle thumbs
			return;

		if (client.ButtonDown("East")) // Go right
			XVelocity = min(XVelocity + MaxAccel, MaxSpeed)
			if (XVelocity < 0)
				XVelocity += MaxDecel
				if (XVelocity > 0)
					XVelocity = 0

		else if (client.ButtonDown("West")) // Go left
			XVelocity = max(XVelocity - MaxAccel, -MaxSpeed)
			if (XVelocity > 0)
				XVelocity -= MaxDecel
				if (XVelocity < 0)
					XVelocity = 0

		else // Come to a halt
			if (Grounded)
				XVelocity = round(XVelocity * 0.4, 0.1)
			else
				XVelocity = round(XVelocity * 0.8, 0.1)

		// Jump w/ height control - release early for shorter jump
		if (client.ButtonPressed("Space"))
			Jump()
		else if (!client.ButtonDown("Space"))
			if (YVelocity > 4.5)
				YVelocity = 4.5

		client.KeyTick() // Do client keyboard stuff
		..()

	Jump(var/Force = 0) //
		if (Grounded || Force)
			YVelocity = JumpSpeed
			return TRUE
		return FALSE

	Damage(/atom/movable/AM)
		Die()

	Die()
		..()
		Spawn()

	Spawn()
		loc = locate(/obj/PlayerStart)
		loc = get_turf(loc)
		XVelocity = 0
		YVelocity = 0
		SubStepX = 0
		SubStepY = 0