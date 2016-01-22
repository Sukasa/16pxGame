/obj/GooBlock
	name = "Bouncy Goo Block"

	icon = 'GooBlock.dmi'
	icon_state = "GooBlock"

	var
		list/Affecting = list()

		const
			Force = 1
			Slowdown = 5

	Cross(var/atom/movable/AM)
		if (ismob(AM) && AM:NoGooBounce)
			return 0

		. = ..()

	Crossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting += AM

	Uncrossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting -= AM

	Tick()
		for(var/x = Affecting.len; x >= 1; x--)
			var/mob/M = Affecting[x]
			if (!(M in loc))
				Affecting -= M
				continue

			// Figure out how strongly to repel the mob, and in what direction
			var/dX = M.GetCenterX() - GetCenterX()
			var/dY = M.GetCenterY() - GetCenterY()

			// Apply repulsion
			var/XS = sign(M.XVelocity)
			var/YS = sign(M.YVelocity)

			if (XS == sign(dX))
				M.XVelocity += ((world.icon_size / 2) - abs(dX)) / world.icon_size * Force * 2 * sign(dX)
			else
				M.XVelocity += ((world.icon_size / 2) - abs(dX)) / world.icon_size * Slowdown * 2 * sign(dX)

			if (YS == sign(dY))
				M.YVelocity += ((world.icon_size / 2) - abs(dY)) / world.icon_size * Force * 4 * sign(dY)
			else
				M.YVelocity += ((world.icon_size / 2) - abs(dY)) / world.icon_size * Slowdown * 4 * sign(dY)

			// Mark mobs as grounded if they're above the goo
			if (M.GetFineY() > GetFineY())
				M.Grounded = TRUE