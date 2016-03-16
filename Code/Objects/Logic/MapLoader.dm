/obj/Logic/MapLoader
	var
		MapName = ""
		SpawnTag = ""

	Notify(var/State)
		MapLoader.SpawnTag = SpawnTag
		MapLoader.LoadMap(MapName)
