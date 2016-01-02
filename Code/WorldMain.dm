world
	New()
		..()
		spawn
			while (TRUE)

				// Tick all entities
				for(var/atom/A)
					if (A.loc) // Don't tick stuff if it's being killed off
						A.Tick()
				sleep(world.tick_lag) // Sleep for 1 frame