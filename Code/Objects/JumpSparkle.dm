/obj/Sparkle
	name = "Jump Sparkle"
	icon = 'JumpSparkle.dmi'
	icon_state = "Sparkle"

	var/Cooldown = 120
	invisibility = 0

	bound_x = 8
	bound_y = 8
	bound_width = 16
	bound_height = 16

	CrossedOver(atom/movable/AM)
		Crossed(AM)

	Crossed(atom/movable/AM)
		. = ..(AM)
		if (ismob(AM) && !invisibility)
			if (AM:Jump(TRUE))
				invisibility = Cooldown

	Tick()
		if (invisibility > 0)
			invisibility--