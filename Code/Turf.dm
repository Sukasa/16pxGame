/turf
	name = "Empty Space"
	icon = 'Flats.dmi'
	icon_state = "White"

	color = rgb(128, 160, 255)

	proc
		Neighbors()
			. = list( )
			for(var/Dir in Cardinal8)
				. += get_step(src, Dir)