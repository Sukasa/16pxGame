/obj/SwitchBlock
	icon = 'SwitchBlock.dmi'
	icon_state = "SwitchBlock"

	CanHit = TRUE
	density = 1

	// Handle being hit from below
	OnHit()
		OnOffTimer = OnOffTimer || TRUE

	// Damage anything standing on the block when it's hit from below, giving it a little bump
	HitZoneCallback(var/mob/M)
		if (ismob(M) && M.Damage(src))
			M.YVelocity += 4