/datum/SignalCallback
	var
		Time
		atom/CallbackObj
		State

	New(Timer, Callback, StateValue)
		Time = Timer
		CallbackObj = Callback
		State = StateValue