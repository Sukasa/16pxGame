/obj/Effect/WaterSplash
	icon = 'Water.dmi'
	icon_state = "Splash"
	layer = 10
	step_y = 21

	Tick()
		. = ..()
		if (Age > 30)
			loc = null