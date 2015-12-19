world
	New()
		..()
		spawn
			while (1)
				for(var/atom/A in world)
					A.Tick()
				sleep(world.tick_lag)