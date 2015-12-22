/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0

/atom/movable/proc/MoveBy(var/StepX, var/StepY)
	var/NewX = (StepX + step_x + SubStepX) + (x * world.icon_size)
	var/NewY = (StepY + step_y + SubStepY) + (y * world.icon_size)

	SubStepX = NewX - round(NewX)
	SubStepY = NewY - round(NewY)

	return Move(locate(round(NewX / world.icon_size), round(NewY / world.icon_size), z), 0, round(NewX % world.icon_size), round(NewY % world.icon_size))

//------------------------------------

/atom/movable/Cross(var/atom/movable/AM)
	AM.CrossedBy(src)
	. = ..()

/atom/movable/proc/CrossedBy(var/atom/movable/AM)
	return

/atom/movable/Uncross(var/atom/movable/AM)
	AM.UnCrossedBy(src)
	. = ..()

/atom/movable/proc/UnCrossedBy(var/atom/movable/AM)
	return

//------------------------------------

/atom/movable/proc/GetFineX()
	return (src.x * world.icon_size) + src.step_x


/atom/movable/proc/GetFineY()
	return (src.y * world.icon_size) + src.step_y

//------------------------------------
