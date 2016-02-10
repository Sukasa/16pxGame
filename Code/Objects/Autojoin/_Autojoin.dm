/obj/Autojoin
	Init()
		AutoJoin()

	proc
		CreateEdge(Direction, Type)
			var/turf/T = loc
			T = get_step(T, Direction)
			var/obj/Edge = new Type(T)
			Edge.dir = Direction
			Edge.layer = layer