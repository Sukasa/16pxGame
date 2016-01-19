/mob/Eagle
	name = "Eagle"
	density = 0

	icon = 'Eagle.dmi'
	icon_state = "Eagle"

	bound_x = 4
	bound_width = 24
	bound_height = 24

	var
		Period = 4
		SwoopPeriod = 1.5
		Speed = 4
		AttackRangeY = 200
		AttackRangeX = 64
		tmp
			State = 0
			ActivePeriod = 0
			list/Crossing = list( )
			OriginalY = 0
			SwoopStart = 0
			Cooldown = 0
			SwoopSpeed = 0
			mob/Player/Target
			mob/Player/Grabbed

	GetGravityModifier()
		return 0

	New()
		ActivePeriod = Period * world.fps

	Crossed(atom/movable/AM)
		if (AM == Target && State == 1 && !Grabbed)
			Grabbed = AM
			SwoopStart = Age
			SwoopStart -= SwoopPeriod * world.fps
			SwoopPeriod *= 2
			SwoopSpeed /= 2

	CrossedBy(atom/movable/AM)
		Crossed(AM)

	Tick()
		ActivePeriod--
		if (ActivePeriod <= 0)
			ActivePeriod = Period * world.fps
			Speed = 0 - Speed
			var/matrix/M = transform || matrix() // Flip the sprite
			transform = M.Scale(-1, 1)

		XVelocity = Speed

		if (State == 0) // Idle
			if (Cooldown <= 0)
				for(var/mob/P in world)
					if (CanAttack(P))
						State = 1
						OriginalY = GetFineY()
						SwoopStart = Age
						SwoopSpeed = (-(GetFineY() - (P.GetFineY() - 24)) / (world.fps * SwoopPeriod * 0.5)) * sqrt(2)
						Target = P
			else
				Cooldown--

			YVelocity = 0

		else if (State == 1) // Swoop
			if ((Age - SwoopStart + (world.fps / 2.6)) > (SwoopPeriod * world.fps))
				State = 2
				if (Grabbed)
					SwoopPeriod /= 2
				Grabbed = null
				Target = null
				Grabbed.XVelocity = XVelocity
				Grabbed.YVelocity = YVelocity

			YVelocity = sin(360 * (Age - SwoopStart) / (SwoopPeriod * world.fps)) * SwoopSpeed

		else // Return to original Y
			YVelocity = OriginalY - GetFineY()

			if (YVelocity < -4.6)
				YVelocity = -4.6
			if (YVelocity > 4.6)
				YVelocity = 4.6

			if (round(GetFineY(), 1) == round(OriginalY, 1))
				YVelocity = 0
				State = 0
				Cooldown = SwoopPeriod * world.fps * 2

		. = ..()

		if (Grabbed)
			Grabbed.MoveStun = 2
			Grabbed.Stun = 2
			Grabbed.MoveBy(XVelocity, 0)
			Grabbed.MoveBy(0, YVelocity)
			Grabbed.XVelocity = XVelocity
			Grabbed.YVelocity = YVelocity

	proc
		CanAttack(mob/Test)
			var/Y = Test.GetFineY()
			var/X = Test.GetFineX()
			var/MyY = GetFineY()
			var/MyX = GetFineX()

			. = Y < MyY && Y >= MyY - AttackRangeY
			. &= abs(X - MyX) < (AttackRangeX)
			. &= ((Speed > 0) && (X > MyX)) || ((Speed < 0) && (X < MyX))