/obj/Collectible/Emerald
	name = "Emerald"
	icon = 'Emerald.dmi'
	icon_state = "Emerald"

	bound_x = 13
	bound_y = 10
	bound_width = 6
	bound_height = 13

	var
		Cooldown

	New()
		. = ..()
		Cooldown = rand(500) + 50

	Collected(mob/Player/Player)
		Player.Emeralds++

	Tick()
		if(--Cooldown <= 0)
			Cooldown = rand(500) + 50
			flick("Shine", src)