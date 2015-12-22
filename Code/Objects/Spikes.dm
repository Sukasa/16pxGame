/obj/Hazards/Spikes
	icon = 'Spikes.dmi'
	icon_state = "Spikes"

	Cross(atom/movable/AM)
		. = ..(AM)

		if (istype(AM, /mob))
			AM:Damage(src)

