/obj/Hazard/Spikes
	icon = 'Spikes.dmi'
	icon_state = "Spikes"
	dir = NORTH
	density = 1

	Bumped(atom/movable/AM)
		. = ..(AM)
		if (ismob(AM))
			if (dir == NORTH && AM.Above(src))
				AM:Damage(src)
			if (dir == EAST && AM.RightOf(src))
				AM:Damage(src)
			if (dir == WEST && RightOf(AM))
				AM:Damage(src)
			if (dir == SOUTH && Above(AM))
				AM:Damage(src)
