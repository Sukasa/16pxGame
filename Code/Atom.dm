atom
	var
		Age
	mouse_opacity = 0

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

// Returns the angle to the passed atom, where 0° is due north
/atom/movable/proc/GetAngleTo(var/atom/movable/To)
	var/Point/P = new(src)
	return P.GetAngleTo(To)


// Returns the Distance to the passed atom
atom/proc/GetDistanceTo(var/atom/movable/To)
	var/Point/P = new(src)
	return P.GetDistanceTo(To)


/atom/proc/GetXDistanceTo(var/atom/movable/To)
	var/Point/P = new(src)
	return P.GetXDistanceTo(To)


/atom/proc/GetYDistanceTo(var/atom/movable/To)
	var/Point/P = new(src)
	return P.GetYDistanceTo(To)

//------------------------------------

/atom/proc/Tick()
	Age++
	return


//------------------------------------

/atom/proc/Closest(var/list/Candidates)
	var/Dist = Infinity
	for(var/atom/Candidate in Candidates)
		if (Dist > GetDistanceTo(Candidate))
			Dist = GetDistanceTo(Candidate)
			. = Candidate

//------------------------------------

/atom/proc/IsOnScreen(var/Expand = 0)
	var/list/Range = range(world.view + Expand, src)
	for(var/client/C)
		if (C.eye in Range)
			return TRUE
	return FALSE