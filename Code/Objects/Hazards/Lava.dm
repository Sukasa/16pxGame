/obj/Hazard/Lava
	DamageValue = 0 // Lava surface shouldn't hurt you, deep lava should
	UniversalHazard = 1
	density = 0
	icon = 'Pit.dmi'
	icon_state = "Pit"
	layer = HighForegroundObjectLayer


	var
		list/Affecting = list()

	Crossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting += AM
			AM:Gooped++

	Uncrossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting -= AM
			AM:Gooped--

	Tick()
		..()
		for(var/x = Affecting.len; x >= 1; x--)
			var/mob/M = Affecting[x]

			var/obj/Hazard/Lava/Other = locate(/obj/Hazard/Lava) in M.loc
			if (Other && Other != src)
				continue

			M.YVelocity = 0
			M.Damage(src)


	Deep
		DamageValue = 9999999
		bound_height = 32
		icon = 'Flats.dmi'
		icon_state = "White"
		color = rgb(224, 0, 0)