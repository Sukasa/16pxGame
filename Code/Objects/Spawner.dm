/obj/Spawner
	var
		Cooldown = 0
		SpawnType = null
		MinXVelocity = 0
		MaxXVelocity = 0
		MinYVelocity = 0
		MaxYVelocity = 0
		CooldownPeriod = 500
		CooldownMin = 50

	BlastDamage()
		return

	Init()
		Ticker.PersistentTickAtoms += src
		if (istext(SpawnType))
			SpawnType = text2path(SpawnType)

	Tick()
		if (--Cooldown <= 0)
			Cooldown = rand(CooldownPeriod) + CooldownMin
			if (SpawnType)
				var/mob/M = new SpawnType(loc)
				world.log << "Spawned new [SpawnType]"
				M.XVelocity = rand() * (MaxXVelocity - MinXVelocity) + MinXVelocity
				M.YVelocity = rand() * (MaxYVelocity - MinYVelocity) + MinYVelocity

	LitBomb
		SpawnType = /mob/LitBomb
		MinXVelocity = -3
		MaxXVelocity = 3

	Quota
		CooldownPeriod = 150
		var
			MaxNum = 2
			list/Created = list( )

		Tick()
			if (--Cooldown <= 0)
				Cooldown = rand(500) + 50

				for(var/x = Created.len; x; x--)
					var/mob/C = Created[x]
					if (!C.loc)
						Created -= C

				if (Created.len < MaxNum && SpawnType)
					var/mob/M = new SpawnType(loc)
					Created += M
					M.XVelocity = rand() * (MaxXVelocity - MinXVelocity) + MinXVelocity
					M.YVelocity = rand() * (MaxYVelocity - MinYVelocity) + MinYVelocity