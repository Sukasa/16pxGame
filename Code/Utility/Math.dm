proc/tan(var/V)
	var/C = cos(V)
	if (C == 0)
		return 0
	. = sin(V) / C

proc/arctan(var/V)
	. = arcsin(V / sqrt(1 + (V * V)))

proc/sign(x)
	. = x ? x / abs(x) : 0

proc/fix(x)
	. = x ? round(abs(x)) * sign(x) : 0

proc/ceil(x)
	. = round(x)
	if (x != .)
		. += 1

proc/avg()
	var/Sum = 0
	var/Count = 0
	for(var/i in args)
		Sum += i
		Count++
	return Count ? Sum / Count : 0

proc/lerp(var/From, var/To, var/Amount)
	. = From + min(max(Amount, 0), 1) * (To - From)