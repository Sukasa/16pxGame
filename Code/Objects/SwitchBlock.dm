/obj/SwitchBlock
	icon = 'SwitchBlock.dmi'
	icon_state = "SwitchBlock"

	CanHit = TRUE
	density = 1

	// Handle being hit from below
	OnHit()
		OnOffTimer = OnOffTimer || TRUE