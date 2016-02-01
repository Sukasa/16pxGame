/obj/Effect/Explosion
	icon = 'Explosion.dmi'
	icon_state = "Explosion"
	DamageValue = 2
	density = 0
	layer = FLY_LAYER

	bound_width = 48
	bound_x = -24
	bound_y = -24
	bound_height = 48

	pixel_x = -12
	pixel_y = -12

	transform = list(1.5, 0, 0, 0, 1.5, 0)

	New(turf/Source, StepX, StepY)
		..()
		Move(get_turf(Source), StepX, StepY)

	Tick()
		..()
		if (Age == 4)
			DoBlast()
		if (Age == 16)
			DoBlast()
		if (Age >= 20)
			loc = null

	proc
		DoBlast()
			var/list/AtomCheck = list()
			for(var/turf/T in locs)
				AtomCheck |= T.contents

			for(var/atom/movable/AM in AtomCheck)
				if (!istype(AM, /obj/Effect) && Overlaps(AM))
					AM.BlastDamage(src)