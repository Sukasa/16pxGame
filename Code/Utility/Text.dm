//Title: ReplaceText
//Credit to: Kuraudo
//Contributed by: Kuraudo

/*
	replacetext(haystack, needle, replace)

		Replaces all occurrences of needle in haystack (case-insensitive)
		with replace value.

	replaceText(haystack, needle, replace)

		Replaces all occurrences of needle in haystack (case-sensitive)
		with replace value.
*/


proc
	replacetext(haystack, needle, replace)
		var
			pos = findtext(haystack, needle)
			needleLen = length(needle)
			replaceLen = length(replace)
		while(pos)
			haystack = copytext(haystack, 1, pos) + replace + copytext(haystack, pos + needleLen)
			pos = findtext(haystack, needle, pos + replaceLen + 1)

		return haystack

	replaceText(haystack, needle, replace)
		var
			pos = findtextEx(haystack, needle)
			needleLen = length(needle)
			replaceLen = length(replace)

		while(pos)
			haystack = copytext(haystack, 1, pos) + replace + copytext(haystack, pos + needleLen)
			pos = findtextEx(haystack, needle, pos + replaceLen)

		return haystack

	Capitalize(var/Text)
		return uppertext(copytext(Text, 1, 2)) + copytext(lowertext(Text), 2)

	split(var/Text, var/Delimiter)
		var/DelimiterLen = length(Delimiter)
		var/Pos = 1
		var/Pos2 = 1
		. = list()

		while (Pos2 > 0)
			Pos2 = findtext(Text, Delimiter, Pos)
			. += copytext(Text, Pos, Pos2 > 0 ? Pos2 : 0)
			Pos = Pos2 + DelimiterLen

		. += copytext(Text, Pos)

	Split(var/Text, var/Delimiter)
		var/DelimiterLen = length(Delimiter)
		var/Pos = 1
		var/Pos2 = 1
		. = list()

		while (Pos2 > 0)
			Pos2 = findtextEx(Text, Delimiter, Pos)
			. += copytext(Text, Pos, Pos2 > 0 ? Pos2 : 0)
			Pos = Pos2 + DelimiterLen

		. += copytext(Text, Pos)

	IsNumeric(var/Text)
		. = "[text2num(Text)]" == Text