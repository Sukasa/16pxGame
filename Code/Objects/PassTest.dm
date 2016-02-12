/obj/PassTest
	density = 0

	New(var/atom/movable/Source, var/XOffs = 0, var/YOffs = 0, var/XSize = 0, var/YSize = 0)
		. = ..()

		bound_height = YSize || 4
		bound_width = XSize || 4

		world.log << Move(get_turf(Source), 0, Source.step_x, Source.step_y)

		MoveBy(XOffs, YOffs)

	Tick()
		loc = null

	proc
		Test(CheckDistance, Steps = 1)
			density = 1
			var/Y = CheckDistance / Steps
			. = TRUE
			while (Steps--)
				var/MB = MoveBy(0, - Y)
				. = . && MB

			. = !.
			density = 0



