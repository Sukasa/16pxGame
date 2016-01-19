/mob/FlierVertical
	name = "Vertical Flier"

	icon = 'Flier.dmi'
	icon_state = "Flier"
	dir = NORTH

	bound_height = 8
	DoesRide = FALSE

	var
		Speed = 2.4
		Mult = 6
		Period = 6 // Seconds


	New()
		. = ..()
		if (dir == SOUTH)
			Mult *= -1

	Tick()

		YVelocity = sin(Age * 360 / (Period * world.fps)) * Mult

		if (YVelocity > Speed)
			YVelocity = Speed
		if (YVelocity < -Speed)
			YVelocity = -Speed

		. = ..()

	GetGravityModifier()
		return 0