/mob/Crawler
	density = 1
	icon = 'Crawler.dmi'
	icon_state = "Crawler"
	pixel_x = -1

	bound_height = 8
	bound_width = 28

	var
		Speed = 0.7

	Tick()
		if (Grounded) // As long as we're on the ground, plod along at a varying bug-ish speed
			XVelocity = Speed * (0.75 + (0.45 * sin(Age * 10) * Speed))

		..()

		if (XVelocity == 0) // If we hit an obstacle, turn around and go the other direction
			Speed = 0 - Speed
			var/matrix/M = transform || matrix() // Flip the sprite
			transform = M.Scale(-1, 1)

	Damage(atom/movable/AM)
		if (ismob(AM))
			Die()

	Bump(atom/movable/AM)
		. = ..()
		if (isplayer(AM)) // Player gets hurt if the crawler bites him (i.e. bumps into the player)
			AM:Damage(src)

	Bumped(atom/movable/AM)
		if (isplayer(AM) && !AM.Above(src)) // Player gets hurt if they run into the crawler's sides or bottom
			AM:Damage(src)