atom
	mouse_opacity = 0

	var
		Age = 0
		DamageValue = 1

	proc

		// Called when something is affected by blast damage
		BlastDamage(atom/movable/Source)
			return

		// Returns the angle to the passed atom, where 0° is due north
		GetAngleTo(var/atom/To)
			var/Point/P = new(src)
			return P.GetAngleTo(To)


		// Returns the Distance to the passed atom
		GetDistanceTo(var/atom/movable/To)
			var/Point/P = new(src)
			return P.GetDistanceTo(To)

		GetXDistanceTo(var/atom/movable/To)
			var/Point/P = new(src)
			return P.GetXDistanceTo(To)


		GetYDistanceTo(var/atom/movable/To)
			var/Point/P = new(src)
			return P.GetYDistanceTo(To)

		Tick()
			Age++

		isplayer(atom/A)
			return istype(A, /mob/Player)

		Closest(var/list/Candidates)
			var/Dist = Infinity
			for(var/atom/Candidate in Candidates)
				if (Dist > GetDistanceTo(Candidate))
					Dist = GetDistanceTo(Candidate)
					. = Candidate

		IsOnScreen(var/Expand = 0)
			var/list/Range = range(world.view + Expand, src)
			for(var/client/C)
				if (C.eye in Range)
					return TRUE
			return FALSE

		Notify(State, datum/SignalChannel/Channel)
			return

		SignalCallback(datum/SignalChannel/Channel, State)
			return