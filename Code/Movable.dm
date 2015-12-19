
//------------------------------------

/atom/movable
	var
		Point/Destination = null
		SubStepX = 0
		SubStepY = 0
		SmoothMove = 0

///atom/movable/proc/WarpTo(var/Point/Target = Destination)
//	if (!istype(Target, /Point))
//		Target = new/Point(Target)
//	step_y = Target.step_y - (bound_height / 2) - bound_y
//	step_x = Target.step_x - (bound_width / 2) - bound_x
//	. = Move(locate(Target.TileX, Target.TileY, z || 1))

/atom/movable/proc/MoveBy(var/StepX, var/StepY)
	var/NewX = (StepX + step_x + SubStepX) + (x * world.icon_size)
	var/NewY = (StepY + step_y + SubStepY) + (y * world.icon_size)

	SubStepX = NewX - round(NewX)
	SubStepY = NewY - round(NewY)

	return Move(locate(round(NewX / world.icon_size), round(NewY / world.icon_size), z), 0, round(NewX % world.icon_size), round(NewY % world.icon_size))

///atom/movable/Move()
//	. = ..()
//	if (SmoothMove)
//		SmoothMove--
//	else
//		Destination = null

///atom/movable/proc/MoveSpeed()
//	return world.icon_size
