proc/get_turf(atom/A)
	while (A && !istype(A, /turf))
		A = A.loc
	return A