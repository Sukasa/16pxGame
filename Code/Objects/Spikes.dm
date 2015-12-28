/obj/Hazards/Spikes
	icon = 'Spikes.dmi'
	icon_state = "Spikes"

	Crossed(atom/movable/AM)
		. = ..(AM)
		if (ismob(AM))
			AM:Damage(src)