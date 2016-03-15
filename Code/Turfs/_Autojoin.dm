/turf/Autojoin
	Init()
		AutoJoin()

	proc
		CreateEdge(Direction, Type)
			var/turf/T = get_step(src, Direction)
			var/obj/Edge = new Type(T)
			Edge.dir = Direction
			Edge.layer = layer + 2