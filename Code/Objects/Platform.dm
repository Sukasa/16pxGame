/obj/Platform
	name = "Platform"
	icon = 'Platform.dmi'
	icon_state = "Platform"

	bound_y = 31
	bound_height = 1

	Cross(atom/movable/AM)
		. = ..(AM)
		if (!AM.density || (ismob(AM) && !AM:Alive))
			return TRUE
		if (AM.Above(src) && !(isplayer(AM) && AM:client.ButtonPressed("South")))
			return FALSE
		return TRUE