/obj/ToggleBlock
	icon = 'ToggleBlock.dmi'
	icon_state = "Off"

	density = 0

	New()
		. = ..()
		density = icon_state == "On"
		var/datum/SignalChannel/SC = GetSignalChannel("OnOff")
		SC.NotificationSubscriptions += src

	Notify(State)
		density = !density
		icon_state = (icon_state == "Off" ? "On" : "Off")