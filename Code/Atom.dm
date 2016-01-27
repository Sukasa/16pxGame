atom
	mouse_opacity = 0

	var
		Age = 0
		DamageValue = 1

		global
			OnOffTimer = 0
			OnOffTick = FALSE
			OnOffValue = FALSE

	proc
		// Handle the "On / Off" state logic that some blocks may end up using
		DoOnOff()
			OnOffTick = FALSE
			if (OnOffTimer)
				OnOffTimer--
				if (!OnOffTimer)
					OnOffTick = TRUE
					OnOffValue = !OnOffValue

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