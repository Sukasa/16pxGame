/obj/Collectible/Powerup
	icon = 'Powerup.dmi'
	var
		Cooldown = 0

	New()
		..()

		Cooldown = rand(500) + 50

	Collected(var/mob/Player/Player)
		Player.Powerups += src
		loc = null

	Tick()
		if(--Cooldown <= 0)
			Cooldown = rand(500) + 50
			flick("Blink[icon_state]", src)
