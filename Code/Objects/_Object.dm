/obj
	opacity = 0
	density = 0
	layer = ForegroundObjectLayer

	var
		CanHit = FALSE

	proc
		Hop()
			animate(src, pixel_y = 0, 0)
			animate(src, pixel_y = 0, 1)
			animate(src, pixel_y = 8, 1.5)
			animate(src, pixel_y = 0, 2)

			var/obj/Runtime/HitZone/HZ = new(src, 0, 12)
			HZ.Fire()

		OnHit()

	// Damage anything standing on the block when it's hit from below, giving it a little bump
	HitZoneCallback(var/mob/M)
		if (ismob(M) && M.Damage(src))
			M.YVelocity += 4

	Bumped(var/atom/movable/AM)
		if (CanHit && Above(AM))
			Hop()
			OnHit()