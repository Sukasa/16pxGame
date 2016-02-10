/mob
	layer = MobLayer
	var
		YVelocity = 0
		XVelocity = 0
		Grounded = FALSE
		StickyPlatform = FALSE
		DoesRide = TRUE
		NoGooBounce = FALSE
		NoBreathe = FALSE
		Alive = TRUE
		SuppressFallAnimation = FALSE
		ActivationRange = 1

		tmp
			BubbleCooldown = 60
			MoveY = FALSE
			Gooped = FALSE

		const
			BubblePeriodMin = 1
			BubblePeriodVar = 5
			MaximumVelocity = 32 // Maximum sprite velocity in any axis

	proc
		GetGravityModifier()
			return 1

		Damage(atom/movable/DamageSource)
			return FALSE

		Spawn()
			return

		Die()
			density = 0
			Alive = FALSE

			var/matrix/Mx = transform || matrix()
			transform = Mx.Scale(1, -1)
			pixel_y -= (bound_y + bound_height)

			RidersActive.len = 0
			RidersArchived.len = 0
			for(var/mob/M in Riding)
				M.RidersActive -= src
				M.RidersArchived -= src
			Riding = list( )

		Jump(var/force = 0)
			return FALSE

	BlastDamage(atom/movable/Source)
		Damage(Source)

	New()
		. = ..()
		Spawn()
		spawn
			if (locate(/obj/Water) in loc)
				Underwater = TRUE

	Bump(atom/movable/AM)
		. = ..()
		AM.Bumped(src)

		// If moving downwards and we hit a mob, add as a rider to that mob
		if (YVelocity < 0 && ismob(AM) && Above(AM) && DoesRide && AM.CanRide)
			AM.RidersActive += src
			Riding += AM

		// If moving upwards and we flagged for Y movement, and we bumped, 0 velocity
		if (YVelocity > 0 && MoveY)
			YVelocity = 0

	Tick()

		. = ..()

		if (!Alive && x <= 1)
			loc = null

		// If underwater, emit a bubble on occasion
		if (Underwater && !NoBreathe)
			if (BubbleCooldown > 0)
				BubbleCooldown--
			else
				BubbleCooldown = (rand() * BubblePeriodVar + BubblePeriodMin) * world.fps
				var/obj/Decor/Airbubble/AB = new(loc)
				AB.step_x = step_x + bound_x
				AB.step_y += step_y + bound_y
				if (dir == EAST)
					AB.step_x += bound_width
				if (dir == NORTH)
					AB.step_y += bound_height

				Ticker.PersistentTickAtoms += AB

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

		// Before moving, move riders in the correct direction as well
		for(var/mob/M in RidersActive)
			M.SubStepX = SubStepX
			M.SubStepY = SubStepY

			M.MoveBy(XVelocity, 0)

			// If moving up, move the rider first
			if (YVelocity > 0 || (StickyPlatform && YVelocity < 0))
				M.MoveBy(0, YVelocity)

			// 'Stick' players down against the platform
			if (M.YVelocity > YVelocity && YVelocity < 0)
				M.YVelocity = YVelocity

			// Prevent gravity windup on riders	when going down
			if (M.YVelocity < YVelocity && YVelocity < 0)
				M.YVelocity = YVelocity

			// Riders are marked grounded, and set up so they are primed to bump() this transport next tick
			M.Grounded = TRUE
			M.SubStepY = 0
			M.Riding -= src

		if (!MoveBy(XVelocity, 0))
			XVelocity = 0 // 0 Velocity if we hit a wall going sideways

		MoveY = TRUE

		if (YVelocity <= 0)
			Grounded = !MoveBy(0, YVelocity) // Try to move downwards, and flag Grounded if we can't (i.e. riding a mob, solid floor, etc)
			if (Grounded)
				YVelocity = 0
				SubStepY = 0
		else
			Grounded = FALSE

			// Try to move upwards, and 0 velocity if we hit a ceiling
			if (!MoveBy(0, YVelocity))
				YVelocity = 0

		var/list/Swap = RidersArchived
		RidersArchived = RidersActive
		Swap.len = 0
		RidersActive = Swap
		MoveY = FALSE
		SuppressFallAnimation = FALSE


