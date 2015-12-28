/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0

/atom/movable/proc/MoveBy(var/StepX, var/StepY)
	var/NewX = (StepX + step_x + SubStepX) + (x * world.icon_size)
	var/NewY = (StepY + step_y + SubStepY) + (y * world.icon_size)

	. = Move(locate(round(NewX / world.icon_size), round(NewY / world.icon_size), z), 0, round(NewX % world.icon_size), round(NewY % world.icon_size))

	if (.)
		SubStepX = NewX - round(NewX)
		SubStepY = NewY - round(NewY)

//------------------------------------

/atom/movable/proc/GetFineX()
	return (src.x * world.icon_size) + src.step_x


/atom/movable/proc/GetFineY()
	return (src.y * world.icon_size) + src.step_y

//------------------------------------

/atom/movable/proc/Above(atom/movable/Ref)
	return GetFineY() + bound_y >= Ref.GetFineY() + Ref.bound_height + bound_y