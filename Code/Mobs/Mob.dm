/mob
	var
		YVelocity = 0
		XVelocity = 0
		Grounded = FALSE

		const
			Gravity = 0.6

	Tick()
		MoveBy(XVelocity, 0)

		YVelocity -= Gravity

		if (YVelocity < 0)
			Grounded = !MoveBy(0, YVelocity)
		else
			Grounded = FALSE
			if (!MoveBy(0, YVelocity))
				YVelocity = 0

		if (Grounded && YVelocity < 0)
			YVelocity = 0