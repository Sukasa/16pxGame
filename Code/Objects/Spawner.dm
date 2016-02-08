/obj/Spawner
	var
		Cooldown = 0
		SpawnType = null
		MinXVelocity = 0
		MaxXVelocity = 0
		MinYVelocity = 0
		MaxYVelocity = 0

	BlastDamage()
		return

	New()
		Ticker.PersistentTickAtoms += src

	Tick()
		if (--Cooldown <= 0)
			Cooldown = rand(500) + 50
			if (SpawnType)
				var/mob/M = new SpawnType(loc)
				M.XVelocity = rand() * (MaxXVelocity - MinXVelocity) + MinXVelocity
				M.YVelocity = rand() * (MaxYVelocity - MinYVelocity) + MinYVelocity

	LitBomb
		SpawnType = /mob/LitBomb
		MinXVelocity = -3
		MaxXVelocity = 3