var
	datum/Ticker/Ticker = new()
	list/AutoTile = list()
	MapLoader/MapLoader = new()

world
	New()
		..()
		spawn
			MapLoader.Init()

			// Do bitmask handling for 47-state joins
			for(var/X = 0; X < 256, X++)
				var/B = X & 85
				if (((X & 5) == 5) && (X & 2))
					B |= 2
				if (((X & 20) == 20) && (X & 8))
					B |= 8
				if (((X & 80) == 80) && (X & 32))
					B |= 32
				if (((X & 65) == 65) && (X & 128))
					B |= 128

				AutoTile += B

			for(var/atom/A)
				A.Init()

			Ticker.Start()
