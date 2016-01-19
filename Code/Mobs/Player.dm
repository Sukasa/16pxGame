/mob/Player
	icon = 'Player.dmi'
	icon_state = "Player"

	bound_x = 4
	bound_y = 0
	bound_width = 24
	bound_height = 24

	var
		atom/SpawnLocation
		Emeralds = 0
		Health = 2

		tmp
			Stun = FALSE
			MoveStun = FALSE
			Invincibility = 0

		const
			MaxAccel = 1.2
			MaxDecel = 1.3
			JumpSpeed = 8.9
			MaxSpeed = 6
			MercyInvincibilityPeriod = 1.25

	New()
		..()
		spawn
			SpawnLocation = locate(/obj/PlayerStart)
			Spawn()

	GetGravityModifier()
		if (MoveStun)
			return 0
		return 1

	Tick()
		if (!client) // If the client disconnected, twiddle thumbs
			return;

		if (!Stun && client.ButtonDown("East")) // Go right
			XVelocity = min(XVelocity + MaxAccel, MaxSpeed)
			if (XVelocity < 0)
				XVelocity += MaxDecel
				if (XVelocity > 0)
					XVelocity = 0

		else if (!Stun && client.ButtonDown("West")) // Go left
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
		if (!Stun && client.ButtonPressed("Space"))
			Jump()
		else if (Stun || !client.ButtonDown("Space"))
			if (YVelocity > 4.5)
				YVelocity = 4.5

		client.KeyTick() // Do client keyboard stuff

		if (Invincibility)
			Invincibility--
			if (invisibility)
				invisibility = 0
			else
				invisibility = 100
		else
			invisibility = 0

		if (Stun)
			XVelocity = 0
			YVelocity = 0

		if (MoveStun > 0)
			MoveStun--

		if (Stun > 0)
			Stun--

		..()


	Jump(var/Force = 0) //
		if (Grounded || Force)
			YVelocity = max(YVelocity, 0)
			YVelocity += JumpSpeed
			return TRUE
		return FALSE

	Damage(var/atom/movable/AM)
		if (Invincibility)
			return
		Health -= AM.DamageValue
		Health = round(Health)
		if (Health <= 0)
			Die()
		else
			Invincibility = world.fps * MercyInvincibilityPeriod

	Die()
		..()
		Spawn()

	Spawn()
		loc = SpawnLocation
		loc = get_turf(SpawnLocation)
		XVelocity = 0
		YVelocity = 0
		SubStepX = 0
		SubStepY = 0