/mob/LitBomb
	density = 1
	icon = 'LitBomb.dmi'
	icon_state = "Bomb"

	bound_width = 16
	bound_height = 16
	CanRide = FALSE

	var
		Fuse = 5
		BlastRadius = 12
		BlastCount = 6
		LastXV
		LastYV

	BlastDamage()
		if (Age < (Fuse - 0.5) * world.fps)
			Fuse = 0
			Explode(round(BlastCount * 1.5), round(BlastRadius * 1.5))

	Bumped(mob/AM)
		. = ..()
		if (!istype(AM))
			return

		var/sY = sign(YVelocity)
		var/sX = sign(YVelocity)

		if (!sY || sY != sign(AM.YVelocity))
			YVelocity += AM.YVelocity * 1.25
		else
			YVelocity = AM.YVelocity

		if (!sX || sX != sign(AM.XVelocity))
			XVelocity += AM.XVelocity * 1.25
			YVelocity = max(YVelocity + 1.5, 1.9)

	Jump(Force)
		if (Force)
			YVelocity += 3
		return TRUE

	Tick()
		if (Grounded)
			XVelocity *= 0.25
		else
			XVelocity *= 0.98

		if (round(YVelocity, 1))
			LastYV = YVelocity
		if (round(XVelocity, 1))
			LastXV = XVelocity

		..()

		if (LastYV != 0 && YVelocity == 0)
			LastYV = round(LastYV * -0.3, 0.1)
			YVelocity = LastYV

		if (LastXV != 0 && XVelocity == 0)
			LastXV = round(LastXV * -0.5, 0.1)
			XVelocity = LastXV

		if (Age == (Fuse - 2) * world.fps)
			icon_state = "BombWarn"
		if (Age == (Fuse - 1) * world.fps)
			icon_state = "BombFinal"
		if (Age == Fuse * world.fps)
			Explode(BlastCount, BlastRadius)
		if (Age >= Fuse * world.fps)
			loc = null

	Big
		Fuse = 8
		BlastRadius = 32
		BlastCount = 48