/mob/FlierHorizontal
	name = "Horizontal Flier"

	icon = 'Flier.dmi'
	icon_state = "Flier"

	bound_height = 8
	DoesRide = FALSE
	dir = EAST

	var
		Speed = 2.4
		Mult = 6
		Period = 6 // Seconds

	New()
		. = ..()
		if (dir == WEST)
			Mult *= -1

	Tick()

		XVelocity = sin(Age * 360 / (Period * world.fps)) * Mult

		if (XVelocity > Speed)
			XVelocity = Speed
		if (XVelocity < -Speed)
			XVelocity = -Speed

		. = ..()

	GetGravityModifier()
		return 0