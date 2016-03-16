/obj/Effect/Airbubble
	name = "Bubble"
	density = 0
	icon = 'AirBubble.dmi'
	icon_state = "Bubble"
	Underwater = TRUE
	step_y = 6
	pixel_y = -6


	Tick()
		MoveBy(sin(Age * 20), 1)

		if( !Underwater && icon_state != "Pop" )
			icon_state = "Pop"

		else if(!Underwater)
			loc=null
			Ticker.PersistentTickAtoms -= src

		if (!(locate(/obj/Water) in loc))
			loc = null
			Ticker.PersistentTickAtoms -= src

		. = ..()
