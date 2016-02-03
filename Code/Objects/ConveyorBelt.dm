/obj/Conveyor
	icon = 'ConveyorBelt.dmi'
	icon_state = "Conveyor0"
	color = rgb(255, 224, 32)
	dir = EAST
	density = 1

	bound_y = 26
	bound_height = 6

	var
		Active = TRUE
		Speed = 1
		list/Riders = list( )

	New()
		..()
		icon_state = "Conveyor[Active]"

		if (dir == WEST)
			var/matrix/MX = transform || matrix()
			transform = MX.Scale(-1, 1)

	Bumped(atom/movable/AM)
		Riders += AM

	Tick()
		..()
		if (Active)
			for(var/atom/movable/AM in Riders)
				var/obj/Conveyor/Other = locate(/obj/Conveyor) in AM.loc
				if (Other && Other != src)
					continue
				AM.MoveBy(Speed * (dir == EAST ? 1 : -1), 0)
		Riders.len = 0

	Switched
		color = rgb(255, 62, 245)
		Tick()
			if (OnOffTick)
				Active = !Active
				icon_state = "Conveyor[Active]"
			..()