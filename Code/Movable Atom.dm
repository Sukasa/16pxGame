/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0

	proc
		Bumped (atom/movable/AM)
			return

/atom/movable/proc/MoveBy(var/StepX, var/StepY)

	var/SX = SubStepX + step_x + StepX
	var/SY = SubStepY + step_y + StepY

	var/MX = round(SX)
	var/MY = round(SY)

	if (SX < 0)
		SX += world.icon_size
	if (SY < 0)
		SY += world.icon_size

	var/NX = round(SX)
	var/NY = round(SY)

	. = Move(loc, 0, MX, MY)

	if (step_x == NX)
		// Successful X movement
		SubStepX = SX - round(SX)
	if (step_y == NY)
		// Successful Y movement
		SubStepY = SY - round(SY)

/atom/movable/proc/OldMoveBy(var/StepX, var/StepY)
	var/sx = step_x, sy = step_y    // put these in local vars for faster access
	var/ssx = SubStepX, ssy = SubStepY  // same deal
	var/NewSX = (StepX + sx + ssx)
	var/NewSY = (StepY + sy + ssy)
	var/RX = round(NewSX,1), RY = round(NewSY,1)
	var/dx = NewSX - sx, dy = NewSY - sy
	var/ax = abs(RX-sx), ay = abs(RY-sy)

	SubStepX = NewSX - RX
	SubStepY = NewSY - RY
	. = Move(loc, 0, RX, RY)

	if(. < max(ax,ay))
		if(ax > ay)
			SubStepX = 0
			// apply fractional Y change
			ssy = dy * . / ax
			SubStepY = ssy - round(ssy)
		else if(ay > ax)
			SubStepY = 0
            // apply fractional X change
			ssx = dx * . / ay
			SubStepX = ssx - round(ssx)
		return FALSE
	else
		SubStepX = 0
		SubStepY = 0

//------------------------------------

/atom/movable/proc/GetFineX()
	return (src.x * world.icon_size) + src.step_x


/atom/movable/proc/GetFineY()
	return (src.y * world.icon_size) + src.step_y

//------------------------------------

/atom/movable/proc/Above(atom/movable/Ref)
	return GetFineY() + bound_y >= Ref.GetFineY() + Ref.bound_height + Ref.bound_y

/atom/movable/proc/RightOf(atom/movable/Ref)
	return GetFineX() + bound_x >= Ref.GetFineX() + Ref.bound_width + Ref.bound_x