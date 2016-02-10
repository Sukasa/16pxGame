/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0
		Underwater = FALSE
		CanRide = TRUE
		ExternalMoveFlag = FALSE

		list
			RidersActive = list( )
			RidersArchived = list( )
			Riding = list( )


	Crossed(var/atom/movable/AM)
		. = ..(AM)
		AM.CrossedOver(src)

	Tick()
		. = ..()
		Riding = list( )

	proc

		// Initialization function
		Init()
			return

		ApplyExternalMovement(DX, DY)

			// This accumulation has the odd size-effect of ordering by Y, due to how Riders are handled
			var/list/Movers = RidersActive | RidersArchived | src
			for(var/X = 1; X <= Movers.len; X++)
				var/atom/movable/AM = Movers[X]
				Movers |= AM.RidersActive
				Movers |= AM.RidersArchived

			// Now attempt to move all atoms.

			if (DY > 0)
				for(var/X = Movers.len; X; X--)
					var/atom/movable/AM = Movers[X]
					AM.MoveBy(DX, DY)
			else
				for(var/atom/movable/AM in Movers)
					AM.MoveBy(DX, DY)

		Explode(Count, Spread = 0)
			var/X = GetCenterX()
			var/Y = GetCenterY()
			var/Z = z
			var/Wait = round(max(Count / 10, 1))

			spawn
				var/Angle = 0
				var/Waiting = Wait
				var/Increment = 10
				var/MaxRandAdd = 360 / Count

				for(var/i = 0; i < Count; i++)

					Angle += Increment + rand(MaxRandAdd)

					var/Dist = min(i / Count, 1) * Spread + rand(Spread)

					var/dX = Dist * sin(Angle)
					var/dY = Dist * cos(Angle)

					var/sX = X + dX
					var/sY = Y + dY

					var/tX = round(sX / world.icon_size)
					var/tY = round(sY / world.icon_size)
					var/tZ = Z

					var/turf/T = locate(tX, tY, tZ)
					sX = sX % world.icon_size
					sY = sY % world.icon_size

					new/obj/Effect/Explosion(T, sX, sY)
					if (!--Waiting)
						sleep(world.tick_lag)
						Waiting = Wait

		HitZoneCallback(var/mob/M)
			return

		CrossedOver(atom/movable/AM)
			return

		Bumped (var/atom/movable/AM)
			return

		GetFineX()
			return (src.x * world.icon_size) + src.step_x

		GetFineY()
			return (src.y * world.icon_size) + src.step_y

		GetCenterX()
			return (src.x * world.icon_size) + src.step_x + src.bound_x + SubStepX + (src.bound_width / 2)

		GetCenterY()
			return (src.y * world.icon_size) + src.step_y + src.bound_y + SubStepY + (src.bound_height / 2)

		MoveBy(var/StepX, var/StepY)

			var/oSX = step_x
			var/oSY = step_y

			var/SX = SubStepX + oSX + StepX
			var/SY = SubStepY + oSY + StepY

			var/MX = round(SX)
			var/MY = round(SY)

			if (SX < 0)
				SX += world.icon_size
			if (SY < 0)
				SY += world.icon_size

			var/NX = round(SX) % world.icon_size
			var/NY = round(SY) % world.icon_size

			. = Move(loc, dir, MX, MY)

			if (step_x == NX)
				// Successful X movement
				SubStepX = SX - round(SX)

			if (step_y == NY)
				// Successful Y movement
				SubStepY = SY - round(SY)

		Above(atom/movable/Ref, Fudge)
			return GetFineY() + bound_y + Fudge >= Ref.GetFineY() + Ref.bound_height + Ref.bound_y

		RightOf(atom/movable/Ref, Fudge)
			return GetFineX() + bound_x + Fudge >= Ref.GetFineX() + Ref.bound_width + Ref.bound_x



		// Determines if the atom is overlapping anything
		Overlaps(atom/movable/AM)
			. = TRUE
			. = . && (GetFineX() + bound_x < AM.GetFineX() + AM.bound_x + AM.bound_width)
			. = . && (GetFineX() + bound_x + bound_width > AM.GetFineX() + AM.bound_x)
			. = . && (GetFineY() + bound_y < AM.GetFineY() + AM.bound_y + AM.bound_height)
			. = . && (GetFineY() + bound_y + bound_height > AM.GetFineY() + AM.bound_y)