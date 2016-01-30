/mob/Player
	icon = 'NeoPlayer.dmi'
	icon_state = "Stand"
	dir = EAST

	bound_x = 12
	bound_y = 0
	bound_width = 10
	bound_height = 20

	var
		atom/SpawnLocation
		Emeralds = 0
		Health = 2

		tmp
			Stun = FALSE
			MoveStun = FALSE
			Invincibility = 0
			LastValidDir = EAST
			LastWasRiding = 0

		const
			MaxAccel = 1.2
			MaxDecel = 1.3
			JumpSpeed = 9.4
			MaxSpeed = 6
			MaxHealth = 2
			MercyInvincibilityPeriod = 1.25

			// Bitflags for selecting animation state.
			AnimHintStand = 1
			AnimHintRise  = 2
			AnimHintFall  = 4
			AnimHintWalk  = 8
			AnimHintSwim  = 16


	New()
		..()
		spawn
			SpawnLocation = locate(/obj/PlayerStart)
			Spawn()

	GetGravityModifier()
		if (MoveStun)
			return 0
		return 1

	proc/SetAnimGroup(bits)
		// Select an animation group based on bitflags.
		if(      0 != (bits & AnimHintSwim) )
			icon_state = "Swim"

		else if( 0 != (bits & AnimHintRise) )
			icon_state = "Rise"

		else if( 0 != (bits & AnimHintFall) )
			icon_state = "Fall"

		else if( 0 != (bits & AnimHintWalk) )
			icon_state = "Walk"

		else
			icon_state = "Stand"


	Tick()
		// Accumulator for animation-state relevant flags.
		var/AnimBits = 0

		if (!client) // If the client disconnected, twiddle thumbs
			return;

		if( client.ButtonDown("East") )
			AnimBits |= AnimHintWalk

			if (!Stun) // Go right
				XVelocity = min(XVelocity + MaxAccel, MaxSpeed)
				if (XVelocity < 0)
					XVelocity += MaxDecel
					if (XVelocity > 0)
						XVelocity = 0

		else if( client.ButtonDown("West") )
			AnimBits |= AnimHintWalk

			if (!Stun) // Go left
				XVelocity = max(XVelocity - MaxAccel, -MaxSpeed)
				if (XVelocity > 0)
					XVelocity -= MaxDecel
					if (XVelocity < 0)
						XVelocity = 0

		else // Come to a halt
			AnimBits |= AnimHintStand

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
			AnimBits |= AnimHintSwim

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

		if( YVelocity > 0 )
			// Can't be riding and rising at the same time... if ever we
			// have reversed gravity this will need a not-riding check as well.
			AnimBits |= AnimHintRise

		else if( YVelocity < 0 && ! Riding.len && ! LastWasRiding )
			// Fall if descending, not riding, and wasn't riding last Tick() either.
			AnimBits |= AnimHintFall

		LastWasRiding = Riding.len

		if( XVelocity == 0 )
			dir = LastValidDir

		else
			if( XVelocity < 0 )
				dir = WEST
			else if( XVelocity > 0 )
				dir = EAST
			LastValidDir = dir

		SetAnimGroup(AnimBits)

	Jump(var/Force = 0)
		if (Grounded || Force || Underwater)
			YVelocity = max(YVelocity, 0)
			YVelocity += JumpSpeed * max(Grounded, Force, Underwater)
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
			return TRUE
		return FALSE

	Die()
		..()
		Spawn()

	Spawn()
		density = 1
		transform = matrix()
		pixel_y = 0
		Alive = TRUE
		Move(get_turf(SpawnLocation), 0, 0)
		XVelocity = 0
		YVelocity = 0
		SubStepX = 0
		SubStepY = 0
		Invincibility = 1 // 1 frame of invincibility, so that if we get hit by a double-bump (aka landed on 2 spike blocks at once) it doesn't kill us, make us respawn, and -then- damage us again
		Health = MaxHealth
