atom
	mouse_opacity = 0

	var
		Age = 0
		DamageValue = 1
		AutojoinFlags = 255

		AutojoinPrefix = ""
		list
			MatchTypes = null

		LastTickVal = -1

	proc

		// Initialization function
		Init()
			return

		// Called when something is affected by blast damage
		BlastDamage(atom/movable/Source)
			return

		CrossedOver(atom/movable/AM)
			return

		Bumped (var/atom/movable/AM)
			return

		// Returns the angle to the passed atom, where 0� is due north
		GetAngleTo(var/atom/To)
			var/Point/P = new(src)
			return P.GetAngleTo(To)

		GetFineX()
			return src.x * world.icon_size

		GetFineY()
			return src.y * world.icon_size

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

		// Returns TRUE if the atom is on-screen for any player.
		// Expand is measured in tiles, and expands the view to account for larger graphical objects
		IsOnScreen(var/Expand = 0)
			var/MyX = src:GetFineX()
			var/MyY = src:GetFineY()

			for(var/client/C)
				if (C.eye)
					var/EyeX = C.eye:GetFineX()
					var/EyeY = C.eye:GetFineY()

					if (min(abs(MyX - EyeX), abs(MyY - EyeY)) < (world.view + Expand) * world.icon_size)
						return TRUE
			return FALSE

		Notify(State, datum/SignalChannel/Channel)
			return

		SignalCallback(datum/SignalChannel/Channel, State)
			return

		AutoJoin()
			var/B = 0
			var/turf/Start = get_turf(src)
			var/Type = type
			for(var/X = 1, X <= 8, X++)
				if (!(AutojoinFlags & (1 << (X - 1))))
					continue
				var/turf/T = get_step(Start, Cardinal8[X])
				if (!T || T.type == Type || (locate(Type) in T) || (T.type in MatchTypes))
					B |= 1 << X
			B = AutoTile[(B >> 1) + 1]
			icon_state = "[AutojoinPrefix][B]"
			//world.log << "[x] [y] = [B]"