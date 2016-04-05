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

	Iron
		icon_state = "Iron124"
		AutojoinPrefix = "Iron"

		Fancy
			icon_state = "IronFancy124"
			AutojoinPrefix = "IronFancy"

		Midbar
			icon_state = "IronMidBar68"
			AutojoinPrefix = "IronMidBar"
			density = 0
			layer = HighForegroundObjectLayer