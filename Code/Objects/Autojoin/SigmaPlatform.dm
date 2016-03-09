/obj/Autojoin/SigmaPlatform
	icon = 'Sigma1.dmi'
	icon_state = "124"
	density = 1
	layer = ForegroundObjectLayer

	Pipe
		density = 0
		layer = HighForegroundObjectLayer
		AutojoinPrefix = "Pipe"
		dir = WEST
		icon_state = "Pipe17"

		Init()
			..()
			if (dir == EAST)
				pixel_x -= 16