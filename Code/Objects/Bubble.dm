/obj/Decor/Bubble
	name = "Bubble"
	density = 0
	icon = 'Bubble.dmi'
	icon_state = "Bubble"

	var
		Life = 0

	Tick()
		Life -= 1
		MoveBy(0, 1)

		if( Life == 1 )
			icon_state = "Pop"

		else if( Life <= 0 )
			loc=null

		. = ..()
