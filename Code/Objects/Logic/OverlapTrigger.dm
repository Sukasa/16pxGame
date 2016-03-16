/obj/Logic/OverlapTrigger
	var
		State = TRUE

	Crossed(var/atom/movable/AM)
		if (ValidTrigger(AM))
			var/datum/SignalChannel/SC = GetSignalChannel(SignalChannel)
			SC.SetState(State)

	proc
		ValidTrigger(var/atom/movable/AM)
			return TRUE

	TypeFilter
		var
			FilterType = null

		ValidTrigger(var/atom/movable/AM)
			return istype(AM, FilterType)

		Player
			FilterType = /mob/Player

		IronCrate
			FilterType = /mob/IronCrate