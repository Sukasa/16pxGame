/obj/Collectible/Emerald
	name = "Emerald"
	icon = 'Emerald.dmi'
	icon_state = "Emerald"

	bound_x = 13
	bound_y = 10
	bound_width = 6
	bound_height = 13

	Crossed(atom/movable/AM)
		if (isplayer(AM))
			AM:Emeralds++
			loc = null