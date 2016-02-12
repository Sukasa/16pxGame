/datum/Ticker
	var
		list/TickAtoms = list( )
		list/PersistentTickAtoms = list( ) // Use this for blocks like the Acid block that gives off bubbles

		State = 0

	proc
		Run()
			while (TRUE)

				while (State != TickerRunning)
					sleep(world.tick_lag)

				TickAtoms = PersistentTickAtoms.Copy()

				for(var/datum/SignalChannel/SC in Signals)
					SC.Tick()

				// Tick all entities
				for(var/mob/M)
					if (M.loc)
						TickAtoms |= M // Ensure that mobs are stuffed in before the blocks they are affecting
						TickAtoms |= range(M, M.ActivationRange) // It affects Ramp functionality

				for(var/atom/A in TickAtoms)
					A.Tick()

				sleep(world.tick_lag) // Sleep for 1 frame

		Start()
			if (State == TickerNotStarted)
				spawn
					Run()
			State = TickerRunning

		Suspend()
			State = TickerSuspended
