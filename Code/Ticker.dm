/datum/Ticker
	proc
		Run()
			while (TRUE)
				for(var/datum/SignalChannel/SC in Signals)
					SC.Tick()

				// Tick all entities
				for(var/atom/A)
					if (A.loc) // Don't tick stuff if it's being killed off
						A.Tick()
				sleep(world.tick_lag) // Sleep for 1 frame