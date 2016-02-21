/mob/PlatformWalker
	icon = 'PlatformWalker.dmi'
	icon_state = "Walk"

	bound_height = 24
	bound_width = 16

	var
		Speed = 2

	Tick()
		XVelocity = Speed
		..()
		if (!XVelocity || !HasPlatform())
			Turn()

	Bump(var/atom/movable/AM)
		..()
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

	proc
		Turn()
			flick("Turn", src)
			XFlip()
			Speed *= -1