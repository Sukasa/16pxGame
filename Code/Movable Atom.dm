/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0
		Underwater = FALSE

	Crossed(var/atom/movable/AM)
		. = ..(AM)
		AM.CrossedOver(src)

	proc
		HitZoneCallback(var/atom/movable/AM)
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

			. = Move(loc, 0, MX, MY)

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