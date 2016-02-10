/mob/IronCrate
	icon = 'IronCrate.dmi'
	icon_state = "IronCrate"
	DamageValue = 1

	Damage()
		return

	// Iron crates can now do blast damage when they land on things
	Bump(atom/movable/AM)
		. = ..()
		if (YVelocity < -16)
			if (Above(AM))
				YVelocity = 3
				DamageValue = 2
				AM.BlastDamage(src)
		else if (YVelocity < 0 && Above(AM))
			if (ismob(AM))
				AM:Damage(src)
			YVelocity = 1.5
		DamageValue = 1