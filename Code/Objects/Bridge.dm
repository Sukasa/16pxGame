/obj/Bridge
	icon = 'Bridges.dmi'
	icon_state = "Bridge"
	bound_y = 16
	bound_height = 16
	density = 1

	Railing
		density = 0
		icon_state = "Railing"

		End
			icon_state = "RailingEnd"

	End
		icon_state = "BridgeEnd"
		bound_width = 10
		dir = WEST

		Init()
			..()
			if (dir == EAST)
				bound_x = 22