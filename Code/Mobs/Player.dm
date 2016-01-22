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
			MaxHealth = 2
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

		if (Underwater)
			XVelocity = min(abs(XVelocity), 7) * sign(XVelocity)
			if (YVelocity < -3)
				YVelocity = -3
			if (YVelocity > 8)
				YVelocity = 8

		client.KeyTick() // Do client keyboard stuff

		if (Invincibility > 0)
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

	Jump(var/Force = 0)
		if (Grounded || Force || Underwater)
			YVelocity = max(YVelocity, 0)
			YVelocity += JumpSpeed
			if (Gooped && YVelocity > 6)
				YVelocity = 6
			return TRUE
		return FALSE

	Damage(var/atom/movable/AM)
		if (Invincibility < 1)
			Health -= AM.DamageValue
			Health = round(Health)
			if (Health < 1)
				Die()
			else
				Invincibility = world.fps * MercyInvincibilityPeriod

	Die()
		..()
		Spawn()

	Spawn()
		Move(get_turf(SpawnLocation), 0, 0)
		XVelocity = 0
		YVelocity = 0
		SubStepX = 0
		SubStepY = 0
		Invincibility = 1 // 1 frame of invincibility, so that if we get hit by a double-bump (aka landed on 2 spike blocks at once) it doesn't kill us, make us respawn, and -then- damage us again
		Health = MaxHealth
