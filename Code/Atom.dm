atom
	var
		Age
	mouse_opacity = 0

//------------------------------------

// Returns the angle to the passed atom, where 0° is due north
/atom/proc/GetAngleTo(var/atom/To)
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