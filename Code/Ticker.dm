/datum/Ticker
	var
		//list/TickAtoms = list( )
		list/PersistentTickAtoms = list( ) // Use this for blocks like the Acid block that gives off bubbles

		TickFlag = 0
		State = 0

	proc
		Run()
			while (TRUE)

				// Technically this has the ability to cause the game to suddenly hang after a while
				// due to numeric limits (2^24), but..  that will only happen after 6.4 DAYS of continuous play.
				TickFlag++

				//if (!(TickFlag % 12))
				//	world.log << world.cpu

				//TickAtoms = PersistentTickAtoms.Copy()

				for(var/atom/A in PersistentTickAtoms)
					if (A.LastTickVal != TickFlag)
						A.Tick()
						A.LastTickVal = TickFlag

				for(var/datum/SignalChannel/SC in Signals)
					SC.Tick()

				// Tick all entities
				for(var/mob/M)
					if (M.loc)
						if (M.LastTickVal != TickFlag)
							M.Tick()
							M.LastTickVal = TickFlag

				for(var/mob/M)
					if (M.loc)
						for(var/atom/A in range(M, M.ActivationRange))
							if (A.LastTickVal != TickFlag)
								A.Tick()
								A.LastTickVal = TickFlag

						//TickAtoms |= M // Ensure that mobs are stuffed in before the blocks they are affecting
						//TickAtoms |= range(M, M.ActivationRange) // It affects Ramp functionality

				//for(var/atom/A in TickAtoms)
					//A.Tick()
				do
					sleep(world.tick_lag) // Sleep for 1 frame
				while (State != TickerRunning)

		Start()
			if (State == TickerNotStarted)
				spawn
					Run()
			State = TickerRunning

		Suspend()
			State = TickerSuspended
