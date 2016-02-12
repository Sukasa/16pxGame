// Obvious goomba knockoff, awaiting something better than placeholder graphics

/mob/Squishy
	icon = 'Squishy.dmi'
	icon_state = "GoombaWalk"
	dir = WEST

	bound_x = 8
	bound_width = 16
	bound_height = 16

	var
		Speed = -1.3

	Init()
		if (dir == EAST)
			Speed *= -1

	Tick()


		XVelocity = Speed

		..()

		if (XVelocity == 0)
			Speed *= -1
			XFlip()

	Bump(var/atom/movable/AM)
		if (isplayer(AM))
			AM:Damage(src)

	Bumped(var/atom/movable/AM)
		if (AM.Above(src))

			Die()
			YVelocity += 5
			if (ismob(AM))
				spawn
					AM:Jump(0.5)
		else if (isplayer(AM))
			AM:Damage(src)