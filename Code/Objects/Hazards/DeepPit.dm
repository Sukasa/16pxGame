/obj/Hazard/DeepPit
	DamageValue = 9999999

	// A bit that says everything should die in
	// here, even things normally immune to damage.
	var/UniversalHazard = 1

	density = 1
	bound_height = 6
	icon = 'Pit.dmi'
	icon_state = "Pit"

	Bumped(atom/movable/AM)
		AM:Damage(src)

	Solid
		bound_height = 32
		icon = 'Flats.dmi'
		icon_state = "White"
		color = rgb(0, 0, 0)

	Hollow
		density = 0
		icon = 'Flats.dmi'
		icon_state = "White"
		color = rgb(0, 0, 0)