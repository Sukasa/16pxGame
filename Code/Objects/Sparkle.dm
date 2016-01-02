/obj/Sparkle
	name = "Jump Sparkle"
	icon = 'Sparkle.dmi'
	icon_state = "Sparkle"

	invisibility = 0

	bound_x = 4
	bound_y = 4
	bound_width = 24
	bound_height = 24

	Crossed(atom/movable/AM)
		if (ismob(AM) && !invisibility)
			if (AM:Jump(TRUE))
				invisibility = 120

	Tick()
		if (invisibility > 0)
			invisibility--