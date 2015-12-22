/mob
	var
		YVelocity = 0
		XVelocity = 0
		Grounded = FALSE
		StickyPlatform = FALSE
		MaximumVelocity = 16

		const
			Gravity = 0.6

		list/Riders = list( )

	proc
		GetGravityModifier()
			return 1

		Damage(atom/movable/DamageSource)
			return

		Spawn()
			return

	Tick()

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
			if (XVelocity != 0)
				AM.MoveBy(XVelocity, 0)
			if (YVelocity > 0 || (StickyPlatform && YVelocity != 0))
				AM.MoveBy(0, YVelocity)

		Riders = list( )

		if (!MoveBy(XVelocity, 0))
			XVelocity = 0

		if (YVelocity < 0)
			Grounded = !MoveBy(0, YVelocity)
		else
			Grounded = FALSE

			// Try to move upwards, and 0 velocity if we hit a wall
			if (!MoveBy(0, YVelocity))
				YVelocity = 0

		if (Grounded && YVelocity < 0)
			YVelocity = 0