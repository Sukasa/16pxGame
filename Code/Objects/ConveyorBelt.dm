/obj/Conveyor
	icon = 'ConveyorBelt.dmi'
	icon_state = "Conveyor0"
	color = rgb(255, 224, 32)
	dir = EAST
	density = 1

	layer = HighForegroundObjectLayer

	bound_y = 26
	bound_height = 6

	var
		Active = TRUE
		Speed = 1

	Init()
		icon_state = "Conveyor[Active]"

		if (dir == WEST)
			XFlip()

	Bumped(atom/movable/AM)
		RidersActive += AM

	Tick()
		..()
		if (Active)
			for(var/atom/movable/AM in RidersActive)

				var/obj/Conveyor/Other = locate(/obj/Conveyor) in get_step(AM.loc, SOUTH)
				if (Other && Other != src)
					continue

				AM.ApplyExternalMovement(Speed * (dir == EAST ? 1 : -1), 0)

		RidersActive.len = 0

	West
		dir = WEST

	Switched
		color = rgb(255, 62, 245)
		var
			SignalChannel = "OnOff"

		Init()
			..()
			var/datum/SignalChannel/SC = GetSignalChannel(SignalChannel)
			SC.NotificationSubscriptions += src

		Notify()
			Active = !Active
			icon_state = "Conveyor[Active]"

		West
			dir = WEST

		Off
			Active = FALSE

			West
				dir = WEST