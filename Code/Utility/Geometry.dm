// Angle2Index takes a list of angles and returns the index of the angle that is closest to it while remaining counterclockwise of the supplied angle.
// Generally, you will want to pass this CardinalAngles or CardinalAngles8 as the RefAngles parameter.
proc/Angle2Index(var/Angle, var/list/RefAngles)
	var/Index = 0
	for (var/RefAngle in RefAngles)
		Index++
		if (RefAngle > Angle)
			return Index
	return 1

// Raytrace algorithm.  Given a starting position and Angle (CW from North), returns the terminus turf
proc/Raytrace(var/atom/Start, var/Angle, var/CollideWith = 0)
	if (!CollideWith)
		CollideWith = list(/atom)

	// TODO

	return


// Returns a list of all the turfs in a specific direction from Ref, not including Ref, for a specified amount of tiles
proc/GetOSteps(var/atom/Ref, var/Dir, var/Dist)
	. = list( )
	var/atom/A = Ref
	for(var/X = 1, X <= Dist, X++)
		A = get_step(A, Dir)
		if (!A)
			break
		. += A


// Returns a list of all the turfs in a specific direction from Ref, including but not counting Ref, for a specified amount of tiles
proc/GetSteps(var/atom/Ref, var/Dir, var/Dist)
	. = list( get_turf(Ref) )
	var/atom/A = Ref
	for(var/X = 1, X <= Dist, X++)
		A = get_step(A, Dir)
		if (!A)
			break
		. += A

// TODO: Refactor to match coding style
// Bresenham line-drawing algorithm from Space Station 13.  No idea who the original implementor was, but we can probably assume it wasn't Kelson.
// (Refer to your preferred SS13 branch and check helpers.dm)
proc/GetTilesInLine(var/atom/Start,var/atom/End)
	var/px=Start.x		//starting x
	var/py=Start.y

	var/line[] = list(locate(get_turf(Start)))

	var/dx=End.x-px	//x distance
	var/dy=End.y-py
	var/dxabs=abs(dx)//Absolute value of x distance
	var/dyabs=abs(dy)
	var/sdx=sign(dx)	//Sign of x distance (+ or -)
	var/sdy=sign(dy)
	var/x=dxabs>>1	//Counters for steps taken, setting to distance/2
	var/y=dyabs>>1	//Bit-shifting makes me l33t.  It also makes getline() fast.
	var/j			//Generic integer for counting
	if(dxabs>=dyabs)	//x distance is greater than y
		for(j=0;j<dxabs;j++)//It'll take dxabs steps to get there
			y+=dyabs
			if(y>=dxabs)	//Every dyabs steps, step once in y direction
				y-=dxabs
				py+=sdy
			px+=sdx		//Step one in x direction
			line+=locate(px,py,Start.z)//Add the turf to the list
	else
		for(j=0;j<dyabs;j++)
			x+=dxabs
			if(x>=dyabs)
				x-=dyabs
				px+=sdx
			py+=sdy
			line+=locate(px,py,Start.z)
	return line

proc/Reverse(var/Dir)
	return turn(Dir, 180)