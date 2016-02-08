/datum
	var
		global
			list/Signals = list( )

	proc
		GetSignalChannel(ChannelName)
			if (Signals[ChannelName])
				return Signals[ChannelName]

			var/datum/SignalChannel/SignalChannel = new(ChannelName)
			Signals[ChannelName] = SignalChannel
			return SignalChannel