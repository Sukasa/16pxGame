/obj/SwitchBlock
	icon = 'SwitchBlock.dmi'
	icon_state = "SwitchBlock"

	CanHit = TRUE
	density = 1

	var
		SignalChannel = "OnOff"

	// Handle being hit from below
	OnHit()
		..()
		var/datum/SignalChannel/SC = GetSignalChannel(SignalChannel)
		SC.SetState(!SC.State)