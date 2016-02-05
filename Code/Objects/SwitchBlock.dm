/obj/SwitchBlock
	icon = 'SwitchBlock.dmi'
	icon_state = "SwitchBlock"

	CanHit = TRUE
	density = 1

	New()
		..()
		var/datum/SignalChannel/SC = GetSignalChannel("OnOff")
		SC.NotificationSubscriptions += src

	// Handle being hit from below
	OnHit()
		..()
		var/datum/SignalChannel/SC = GetSignalChannel("OnOff")
		SC.SetState(!SC.State)