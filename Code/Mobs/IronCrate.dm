/mob/IronCrate
	icon = 'IronCrate.dmi'
	icon_state = "IronCrate"
	DamageValue = 1

	Damage()
		return

	// Iron crates can now do blast damage when they land on things
	Bump(atom/movable/AM)
		. = ..()
		if (YVelocity < -24)
			if (Above(AM))
				YVelocity = 3
				DamageValue = 2
				AM.BlastDamage(src)
		else if (YVelocity < 0 && ismob(AM) && Above(AM))
			AM:Damage(src)
		DamageValue = 1