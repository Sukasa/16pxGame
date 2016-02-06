/obj/OneWayBlock
	icon = 'OneWay.dmi'
	icon_state = "OneWay"
	dir = NORTH

	Cross(atom/movable/AM)
		if (ismob(AM) && AM.density)
			if (dir == NORTH && AM.Above(src))
				return FALSE
			if (dir == EAST && AM.RightOf(src))
				return FALSE
			if (dir == WEST && RightOf(AM))
				return FALSE
			if (dir == SOUTH && Above(AM))
				return FALSE
		. = ..(AM)

	MobHint

		invisibility = 1
		color = rgb(255, 0, 0)

		Cross(atom/movable/AM)
			if (ismob(AM) && !isplayer(AM) && AM.density)
				if (dir == NORTH && AM.Above(src))
					return FALSE
				if (dir == EAST && AM.RightOf(src))
					return FALSE
				if (dir == WEST && RightOf(AM))
					return FALSE
				if (dir == SOUTH && Above(AM))
					return FALSE
			return TRUE