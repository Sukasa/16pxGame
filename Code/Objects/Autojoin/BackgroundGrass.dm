/obj/Autojoin/BackgroundGrassCliff
	icon = 'BGGrass.dmi'
	icon_state = "124"
	density = 0
	layer = BackgroundObjectLayer

	Init()
		..()
		if (icon_state == "64" || icon_state == "112")
			CreateEdge(EAST, /obj/Decorative/GrassEdge)
		else if (icon_state == "28" || icon_state == "4")
			CreateEdge(WEST, /obj/Decorative/GrassEdge)