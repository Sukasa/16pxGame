datum/SignalChannel
	var
		list/NotificationSubscriptions = list( )
		list/Callbacks = list( )

		State
		Key

	New(SignalKey)
		..()
		Key = SignalKey

	proc
		Signal(SignalValue)
			for(var/x = NotificationSubscriptions.len; x; x--)
				var/atom/A = NotificationSubscriptions[x]
				if (A && A.loc != null)
					A.Notify(SignalValue, src)

		SetCallback(FrameTime, atom/CallbackObj, State)
			Callbacks += new/datum/SignalCallback(FrameTime, CallbackObj, State)

		SetState(NewState)
			State = NewState
			Signal(State)

		Tick()
			for(var/x = Callbacks.len; x; x--)
				var/datum/SignalCallback/SC = Callbacks[x]
				SC.Time--
				if (SC.Time < 0)
					SC.CallbackObj.SignalCallback(src, SC.State)
					Callbacks -= SC
			for(var/x = NotificationSubscriptions.len; x; x--)
				var/atom/A = NotificationSubscriptions[x]
				if (!A || A.loc == null)
					NotificationSubscriptions -= A