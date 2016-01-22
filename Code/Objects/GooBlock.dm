/obj/GooBlock
	name = "Bouncy Goo Block"

	icon = 'GooBlock.dmi'
	icon_state = "GooBlock"

	var
		list/Affecting = list()

		const
			Force = 1
			Slowdown = 6

	Cross(var/atom/movable/AM)
		if (ismob(AM) && AM:NoGooBounce)
			return 0

		. = ..()

	Crossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting += AM
			AM:Gooped++

	Uncrossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting -= AM
			AM:Gooped--

	Tick()
		for(var/x = Affecting.len; x >= 1; x--)
			var/mob/M = Affecting[x]

			if ((locate(/obj/GooBlock) in M.loc) != src)
				continue

			if (GetFootPosY(M) < GetSolidPosY())
				M.MoveBy(0, GetSolidPosY() - GetFootPosY(M))
				M.YVelocity = 0

			M.YVelocity *= 0.2
			M.YVelocity += 0.5
			M.XVelocity *= 0.2

			if (M.GetFineY() > GetFineY())
				M.Grounded = TRUE

	proc

		GetSolidPosY()
			return GetFineY() + 16

		GetFootPosY(var/mob/M)
			return M.GetFineY() + M.bound_y