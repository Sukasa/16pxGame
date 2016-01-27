world
	New()
		..()
		spawn
			var/obj/AtomProcs = new()

			while (TRUE)

				// Handle the on/off timer
				AtomProcs.DoOnOff()

				// Tick all entities
				for(var/atom/A)
					if (A.loc) // Don't tick stuff if it's being killed off
						A.Tick()
				sleep(world.tick_lag) // Sleep for 1 frame