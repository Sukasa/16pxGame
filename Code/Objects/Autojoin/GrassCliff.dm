/obj/Autojoin/GrassCliff
	icon = 'Grass.dmi'
	icon_state = "124"
	density = 1

	Init()
		..()
		if (icon_state == "64" || icon_state == "112" || icon_state == "16")
			CreateEdge(EAST, /obj/Decorative/GrassEdge)
		if (icon_state == "28" || icon_state == "20" || icon_state == "4" || icon_state == "16")
			CreateEdge(WEST, /obj/Decorative/GrassEdge)