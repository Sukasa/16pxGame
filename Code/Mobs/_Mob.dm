/mob
	var
		YVelocity = 0
		XVelocity = 0
		Grounded = FALSE
		StickyPlatform = FALSE

		const
			Gravity = 0.6
			MaximumVelocity = 32 // Maximum sprite velocity in any axis

		list/Riders = list( )

	proc
		GetGravityModifier()
			return 1

		Damage(atom/movable/DamageSource)
			return

		Spawn()
			return

		Bumped (atom/movable/AM)
			return

	New()
		. = ..()
		Spawn()

	Bump(atom/movable/AM)
		. = ..()
		AM:Bumped(src)
		if (YVelocity < 0 && ismob(AM))
			AM:Riders += src

	Tick()
		. = ..()


		if (XVelocity < -MaximumVelocity)
			XVelocity = -MaximumVelocity
		if (XVelocity > MaximumVelocity)
			XVelocity = MaximumVelocity
		if (YVelocity > MaximumVelocity)
			YVelocity = MaximumVelocity


		YVelocity -= (Gravity * GetGravityModifier())
		if (YVelocity < -MaximumVelocity)
			YVelocity = -MaximumVelocity

		for(var/atom/movable/AM in Riders)
			AM.SubStepX = SubStepX
			AM.SubStepY = SubStepY
			AM.MoveBy(XVelocity, 0)
			if (YVelocity > 0 || (StickyPlatform && YVelocity != 0))
				AM.MoveBy(0, YVelocity)

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