/obj/Ramp
	density = 0
	icon = 'Brick.dmi'
	icon_state = "Ramp1L"

	var/list/Affecting = list()

	Cross(var/atom/movable/AM)
		. = ..()
		if (ismob(AM) && AM:NoGooBounce)
			return 0

	Crossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting += AM

	Uncrossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting -= AM

	Tick()
		for(var/x = Affecting.len; x >= 1; x--)
			var/mob/M = Affecting[x]

			if (!M.density)
				continue

			var/xL = M.GetFineX() + M.bound_x
			var/xR = xL + M.bound_width

			var/overlap = max(GetSolidPosY(xL), GetSolidPosY(xR)) - GetFootPosY(M)

			if ( overlap > 0 )
				M.MoveBy(0, overlap)
				M.YVelocity = 0
				M.SubStepY = 0
				M.Grounded = TRUE
				M.SuppressFallAnimation = TRUE

	proc
		GetSolidPosY(var/X)
			return 0

		GetFootPosY(var/mob/M)
			return M.GetFineY() + M.bound_y


	// 1x1, Left Up
	Ramp1L
		icon_state = "Ramp1L"

		GetSolidPosY(var/X)
			return GetFineY() + bound_height - X + GetFineX()

	// 1x1, Right Up
	Ramp1R
		icon_state = "Ramp1R"

		GetSolidPosY(var/X)
			return GetFineY() + X - GetFineX()
