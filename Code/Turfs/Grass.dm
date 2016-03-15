/turf/Autojoin/Grass
	// This is the grass cliff object, but in turf form.
	icon = 'Grass.dmi'
	icon_state = "255"
	density = 1
	name = "Grass"
	layer = ForegroundObjectLayer

	Init()
		..()
		if (icon_state == "64" || icon_state == "112" || icon_state == "16")
			CreateEdge(EAST, /obj/Decorative/GrassEdge)
		if (icon_state == "28" || icon_state == "4" || icon_state == "16")
			CreateEdge(WEST, /obj/Decorative/GrassEdge)