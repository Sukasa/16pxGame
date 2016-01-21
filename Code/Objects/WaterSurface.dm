/obj/Water/Surface
	icon = 'Water.dmi'
	icon_state = "WaterSurface"
	color = rgb(255, 255, 255, 255)
	bound_height = 24

	Cross(var/atom/movable/AM)
		. = ..()
		if (AM.Above(src))
			if (ismob(AM))
				var/obj/Effect/WaterSplash/W = new(src.loc)
				W.step_x = AM.step_x + (world.icon_size * (AM.x - x))
			AM:Underwater = TRUE

	Uncrossed(var/atom/movable/AM)
		. = ..()
		if (AM.Above(src))
			if (ismob(AM))
				var/obj/Effect/WaterSplash/W = new(src.loc)
				W.step_x = AM.step_x + (world.icon_size * (AM.x - x))
			AM:Underwater = FALSE