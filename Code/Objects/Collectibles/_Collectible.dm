/obj/Collectible

	Crossed(atom/movable/AM)
		if (isplayer(AM))
			loc = null
			Collected(AM)

	proc
		Collected()
			return