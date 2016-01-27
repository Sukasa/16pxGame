/mob/Ghost
	icon = 'Ghost.dmi'
	icon_state = "Ghost"
	dir = EAST

	bound_x = 3
	bound_y = 3
	bound_height = 16
	bound_width = 26

	density = 0
	NoBreathe = TRUE

	var
		const
			Speed = 1

	GetGravityModifier()
		return 0

	Crossed(var/atom/movable/AM)
		. = ..(AM)
		if (isplayer(AM))
			AM:Damage(src)

	Tick()
		var/TargetPlayer = null
		var/TargetDistance = Infinity

		for(var/mob/Player/P in world)
			var/Dist = GetDistanceTo(P)
			if (Dist < TargetDistance)
				TargetPlayer = P
				TargetDistance = Dist

		if (TargetPlayer)
			var/Angle = GetAngleTo(TargetPlayer)
			var/X = sin(Angle)
			var/Y = cos(Angle)

			if (sign(XVelocity) != sign(X) && X != 0)
				var/NewDir = ((sign(X) == -1) ? WEST : EAST)
				if (dir != NewDir)
					var/matrix/M = transform || matrix() // Flip the sprite
					transform = M.Scale(-1, 1)
					dir = NewDir

			XVelocity = X * Speed
			YVelocity = Y * Speed
		else
			XVelocity = 0
			YVelocity = 0

		..()