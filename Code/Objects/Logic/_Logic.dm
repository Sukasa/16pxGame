/obj/Logic
	density = 0
	invisibility = 101

	var
		SignalChannel = null


	Init()
		..()
		if (SignalChannel)
			var/datum/SignalChannel/SC = GetSignalChannel(SignalChannel)
			SC.NotificationSubscriptions += src