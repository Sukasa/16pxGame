/obj/Collectible

	CrossedOver(atom/movable/AM)
		Crossed(AM)

	Crossed(atom/movable/AM)
		if (isplayer(AM))
			loc = null
			Collected(AM)

	proc
		Collected()
			return