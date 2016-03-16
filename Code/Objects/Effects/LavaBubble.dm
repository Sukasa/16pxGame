/obj/Effect/LavaBubble
	name = "Bubble"
	density = 0
	icon = 'LavaBubble.dmi'
	icon_state = "Bubble"
	color = rgb(255, 128, 128)
	pixel_y = -10

	Tick()
		Life -= 1

		if( Life == 5 )
			icon_state = "Pop"

		if( Life == 10 )
			icon_state = "Bubble2"

		else if( Life <= 0 )
			loc=null
			Ticker.PersistentTickAtoms -= src

		. = ..()
