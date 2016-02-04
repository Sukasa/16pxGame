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
		. = ..()
		if (ismob(AM) && AM:NoGooBounce)
			return 0

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

			var/obj/GooBlock/Other = locate(/obj/GooBlock) in M.loc
			if (Other && Other != src)
				continue

			if (GetFootPosY(M) < GetSolidPosY(M))
				M.MoveBy(0, GetSolidPosY(M) - GetFootPosY(M))
				M.YVelocity = 0

			if (GetFootPosY(M) < GetSolidPosY(M) + 3)
				M.XVelocity = 0

			M.InGoo = TRUE
			M.YVelocity *= 0.2
			M.YVelocity += 0.5
			M.XVelocity *= 0.5

			if (M.GetFineY() > GetFineY())
				M.Grounded = TRUE

	proc

		GetSolidPosY(mob/M)
			return GetFineY() + 16

		GetFootPosY(var/mob/M)
			return M.GetFineY() + M.bound_y