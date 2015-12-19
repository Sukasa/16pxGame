
//------------------------------------

/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0

/atom/movable/proc/WarpTo(var/Point/Target = Destination)
	if (!istype(Target, /Point))
		Target = new/Point(Target)
	step_y = Target.step_y - (bound_height / 2) - bound_y
	step_x = Target.step_x - (bound_width / 2) - bound_x
	. = Move(locate(Target.TileX, Target.TileY, z || 1))

/atom/movable/proc/MoveBy(var/StepX, var/StepY)
	var/NewX = (StepX + step_x + SubStepX) + (x * world.icon_size)
	var/NewY = (StepY + step_y + SubStepY) + (y * world.icon_size)

	SubStepX = NewX - round(NewX)
	SubStepY = NewY - round(NewY)

	return Move(locate(round(NewX / world.icon_size), round(NewY / world.icon_size), z), 0, round(NewX % world.icon_size), round(NewY % world.icon_size))

/atom/movable/proc/MoveTo(var/Target = Destination)
	Destination = Target
	if (!Target)
		return

	if (GetDistanceTo(Destination) <= OnePixel)
		if (IsMovable(Destination))
			SubStepX = Destination:SubStepX
			SubStepY = Destination:SubStepY
			. = Move(Destination:loc, 0, Destination:step_x, Destination:step_y)

		Destination = null
	else

		var/Angle = GetAngleTo(Destination)
		var/MoveSpeed = min(MoveSpeed(), GetDistanceTo(Destination) * world.icon_size)

		var/NewX = ((MoveSpeed * sin(Angle)) + step_x + SubStepX) + (x * world.icon_size)
		var/NewY = ((MoveSpeed * cos(Angle)) + step_y + SubStepY) + (y * world.icon_size)

		SubStepX = NewX - round(NewX)
		SubStepY = NewY - round(NewY)

		if (GetXDistanceTo(Destination) <= OnePixel && GetXDistanceTo(Destination) != 0)
			if (Debug)
				world.log << "X Jump: Moving from [x]:[step_x + SubStepX] to [Destination:x]:[Destination:step_x] (Distance is [GetXDistanceTo(Destination)])"
			SmoothMove = 1
			. = Move(locate(Destination:x, y, z), 0, round(Destination:step_x), step_y)
			SubStepX = 0
		else
			SmoothMove = 1
			. = Move(locate(round(NewX / world.icon_size), y, z), 0, round(NewX % world.icon_size), step_y)

		if (GetYDistanceTo(Destination) <= OnePixel && GetYDistanceTo(Destination) != 0)
			if (Debug)
				world.log << "Y Jump: Moving from [y]:[step_y + SubStepY] to [Destination:y]:[Destination:step_y] (Distance is [GetYDistanceTo(Destination)])"
			SmoothMove = 1
			. = . && Move(locate(x, Destination:y, z), 0, step_x, round(Destination:step_y))
			SubStepY = 0
		else
			SmoothMove = 1
			. = . && Move(locate(x, round(NewY / world.icon_size), z), 0, step_x, round(NewY % world.icon_size))

/atom/movable/Move()
	. = ..()
	if (SmoothMove)
		SmoothMove--
	else
		Destination = null

/atom/movable/proc/MoveSpeed()
	return world.icon_size
