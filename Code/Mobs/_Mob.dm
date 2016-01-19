/mob
	var
		YVelocity = 0
		XVelocity = 0
		Grounded = FALSE
		StickyPlatform = FALSE
		DoesRide = TRUE

		const
			Gravity = 0.6
			MaximumVelocity = 32 // Maximum sprite velocity in any axis

		list/Riders = list( )
		list/Riding = list( )

	proc
		GetGravityModifier()
			if (Riding && Riding.len > 0)
				var/mob/M = Riding[1]
				return M.GetGravityModifier()
			return 1

		Damage(atom/movable/DamageSource)
			return

		Spawn()
			return

		Die()
			loc = null
			Riders = list( )
			for(var/mob/M in Riding)
				M.Riders -= src
			Riding = list( )
			return

		Jump(var/force = 0)
			return FALSE

		CrossedBy(var/mob/M)
			return FALSE

	Crossed(var/atom/A)
		if (ismob(A))
			A:CrossedBy(src)
		..(A)

	New()
		. = ..()
		Spawn()

	Bump(atom/movable/AM)
		. = ..()
		AM.Bumped(src)
		if (YVelocity < 0 && ismob(AM) && Above(AM) && DoesRide)
			AM:Riders += src
			Riding += AM
	Tick()
		. = ..()

		// Limit X velocity to within maximum the physics engine can handle
		if (XVelocity < -MaximumVelocity)
			XVelocity = -MaximumVelocity
		if (XVelocity > MaximumVelocity)
			XVelocity = MaximumVelocity

		// Apply gravity and then limit Y velocity to maximum velocity the physics engine can handle
		YVelocity -= (Gravity * GetGravityModifier())
		if (YVelocity < -MaximumVelocity)
			YVelocity = -MaximumVelocity
		if (YVelocity > MaximumVelocity)
			YVelocity = MaximumVelocity

		for(var/mob/M in Riders)
			M.SubStepX = SubStepX
			M.SubStepY = SubStepY
			M.MoveBy(XVelocity, 0)
			if (YVelocity > 0 || (StickyPlatform && YVelocity != 0))
				M.MoveBy(0, YVelocity)

			if (M.YVelocity < YVelocity && YVelocity < 0 && !StickyPlatform)
				M.YVelocity = YVelocity

			M.Riding -= src

		Riders = list( )

		if (!MoveBy(XVelocity, 0))
			XVelocity = 0 // 0 Velocity if we hit a wall going sideways

		if (YVelocity < 0)
			Grounded = !MoveBy(0, YVelocity) // Try to move downwards, and flag Grounded if we cant (i.e. riding a mob, solid floor, etc)
			if (Grounded)
				YVelocity = 0
		else
			Grounded = FALSE

			// Try to move upwards, and 0 velocity if we hit a ceiling
			if (!MoveBy(0, YVelocity))
				YVelocity = 0

