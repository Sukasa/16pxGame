/turf
	name = "Empty Space"
	icon = 'Flats.dmi'
	icon_state = "White"

	color = rgb(128, 128, 255)

/turf/proc/Neighbors()
	. = list( )
	for(var/Dir in Cardinal8)
		. += get_step(src, Dir)