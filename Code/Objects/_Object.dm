/obj
	opacity = 0
	density = 0
	var
		CanHit = FALSE

	proc
		Hop()
			animate(src, pixel_y = 0, 0)
			animate(src, pixel_y = 0, 1)
			animate(src, pixel_y = 8, 1.5)
			animate(src, pixel_y = 0, 2)


		OnHit()

	Bumped(var/atom/movable/AM)
		if (CanHit && Above(AM))
			Hop()
			OnHit()