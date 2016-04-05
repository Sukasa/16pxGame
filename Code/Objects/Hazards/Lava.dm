/obj/Hazard/Lava
	DamageValue = Infinity
	UniversalHazard = 1
	density = 0
	bound_height = 20
	icon = 'Lava.dmi'
	icon_state = "LavaSurface"
	layer = HighForegroundObjectLayer

	var
		list/Affecting = list()
		Cooldown = 0

	proc
		SpawnBubble()
			Cooldown = rand() * 5.1 * world.fps + world.fps

			if( IsOnScreen(1) )
				var/obj/Effect/M = new /obj/Effect/LavaBubble(get_step(loc, NORTH))
				M.step_x = rand(-14,14)
				M.Life = rand(15, 20)
				Ticker.PersistentTickAtoms |= M

	Init()
		Ticker.PersistentTickAtoms |= src
		Cooldown = rand() * 5.1 * world.fps + world.fps

	Crossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting += AM
			AM:Gooped++

	Uncrossed(var/atom/movable/AM)
		if (ismob(AM))
			Affecting -= AM
			AM:Gooped--
			if (Above(AM))
				AM:Die(TRUE)

	Tick()
		..()
		for(var/x = Affecting.len; x >= 1; x--)
			var/mob/M = Affecting[x]

			if (!M.Alive)
				continue

			var/obj/Hazard/Lava/Other = locate(/obj/Hazard/Lava) in M.loc
			if (Other && Other != src)
				continue

			M.YVelocity = (Gravity * M.GetGravityModifier()) * 0.75
			M.Damage(src)

		Cooldown--
		if( Cooldown < 1 && Cooldown > -2)
			SpawnBubble()


	Deep
		bound_height = 32
		icon = 'Flats.dmi'
		icon_state = "White"
		color = rgb(255, 51, 51)
		Cooldown = -2

		Init()
			return