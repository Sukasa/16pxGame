/obj/Logic/MapLoader
	var
		MapName = ""
		SpawnTag = ""

	Notify(var/State)
		spawn
			MapLoader.SpawnTag = SpawnTag
			MapLoader.LoadMap(MapName)
