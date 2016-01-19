/obj/Checkpoint
	name = "Checkpoint"
	icon = 'Checkpoint.dmi'
	density = 0

	icon_state = "Low"
	var
		Raised = FALSE

	Cross(atom/movable/AM)
		. = ..(AM)
		if (!Raised && isplayer(AM))
			AM:SpawnLocation = src.loc
			icon_state = "Raised"
			Raised = TRUE