// Specialty object used for non-contact hits, e.g. blocks hopping etc

/obj/Runtime/HitZone

	var
		atom/movable/CallBackObj = null

	New(var/atom/movable/Source, var/XOffs = 0, var/YOffs = 0, var/XSize = 0, var/YSize = 0)
		. = ..()

		bound_height = YSize || Source.bound_height
		bound_width = XSize || Source.bound_width
		bound_y = Source.bound_y
		bound_x = Source.bound_x
		CallBackObj = Source
		Move(get_turf(Source), 0, Source.step_x, Source.step_y)
		MoveBy(XOffs, YOffs)

	Tick()
		..()

		if (Age > world.fps)
			loc = null
			CallBackObj = null

	proc

		// Fire
		Fire()
			if (loc == null)
				return

			Age = 0

			for(var/turf/T in locs)
				if (!istype(T))
					continue
				for(var/atom/movable/AM in T)
					if (Overlaps(AM))
						CallBackObj.HitZoneCallback(AM)