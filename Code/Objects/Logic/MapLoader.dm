/obj/Logic/MapLoader
	var
		MapName = ""
		SpawnTag = ""
		tmp
			Triggered = FALSE

	Notify(var/State)
		if (!Triggered)
			Triggered = TRUE
			spawn
				MapLoader.SpawnTag = SpawnTag
				MapLoader.LoadMap(MapName)

