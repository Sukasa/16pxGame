/mob/verb/Say(var/Text as text)
	var/T = findtext(Text, "Loadmap ", 1)
	if (T)
		var/Map = copytext(Text, T + 8)
		world.log << "Test: [Map]"
		MapLoader.LoadMap("Maps/[Map].dmm")