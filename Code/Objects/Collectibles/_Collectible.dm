/obj/Collectible
	New()
		..()
		Ticker.PersistentTickAtoms += src

	CrossedOver(var/atom/movable/AM)
		Crossed(AM)

	Crossed(var/atom/movable/AM)
		if (isplayer(AM))
			Ticker.PersistentTickAtoms -= src
			loc = null
			Collected(AM)

	proc
		Collected(var/mob/Player/Player)
			return