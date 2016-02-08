var
	datum/Ticker/Ticker = new()

world
	New()
		..()
		spawn
			Ticker.Run()
