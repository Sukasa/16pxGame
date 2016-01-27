/obj/ToggleBlock
	icon = 'ToggleBlock.dmi'
	icon_state = "Off"

	density = 0

	New()
		. = ..()
		density = icon_state == "On"

	Tick()
		if (OnOffTick)
			density = !density
			icon_state = (icon_state == "Off" ? "On" : "Off")