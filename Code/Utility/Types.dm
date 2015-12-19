proc/IsTurf(var/A)
	return istype(A, /turf)

proc/IsAtom(var/A)
	return istype(A, /atom)

proc/IsObj(var/A)
	return istype(A, /obj)

proc/IsClient(var/A)
	return istype(A, /client)

proc/IsMovable(var/A)
	return istype(A, /atom/movable)

proc/Subtypes(var/Type)
	return typesof(Type) - Type

proc/IsList(var/L)
	return istype(L, /list)