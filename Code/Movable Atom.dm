/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0
		Underwater = FALSE

	proc
		Bumped (atom/movable/AM)
			return

/atom/movable/proc/MoveBy(var/StepX, var/StepY)

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

//------------------------------------

/atom/movable/proc/GetFineX()
	return (src.x * world.icon_size) + src.step_x


/atom/movable/proc/GetFineY()
	return (src.y * world.icon_size) + src.step_y

//------------------------------------

/atom/movable/proc/Above(atom/movable/Ref, Fudge)
	return GetFineY() + bound_y + Fudge >= Ref.GetFineY() + Ref.bound_height + Ref.bound_y

/atom/movable/proc/RightOf(atom/movable/Ref, Fudge)
	return GetFineX() + bound_x + Fudge >= Ref.GetFineX() + Ref.bound_width + Ref.bound_x