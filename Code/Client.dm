client
	var
		list/Keys = list( )
		list/Pressed = list( )

	show_popup_menus = FALSE
	control_freak = CONTROL_FREAK_ALL
	perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE

/client/New()
	..()
	InitializeKeyboardMacros()

//*************************************
//*
//*			Keyboard Handling
//*
//*	  Initializes macros and provides
//*      a default keyboard handler
//*
//*************************************

/client/proc/ClearKeys()
	for (var/K in Keys)
		Keys[K] = KeyStateUp

/client/proc/KeyUp(K)
	Keys[K] = KeyStateUp

/client/proc/KeyDown(K)
	world.log << "KEYDOWN"
	Keys[K] = (Keys[K] | KeyStatePressed) || KeyStatePressed

/client/proc/KeyTick()
	Pressed = list( )
	for (var/K in Keys)
		if (Keys[K] == KeyStatePressed)
			Pressed[K] = TRUE
			Keys[K] |= KeyStateDepressed

/client/proc/ButtonPressed(var/Button)
	return Keys[Button]

/client/proc/InitializeKeyboardMacros()
	for(var/k in list("0","1","2","3","4","5","6","7","8","9","Q","W","E","R","T","Y","U","I","O","P","A","S","D","F",
					  "G","H","J","K","L","Z","X","C","V","B","N","M","West","East","North","South","Northeast",
					  "Northwest","Southeast","Southwest","Space","Shift","Ctrl","Alt","Escape","Return","Center",
					  "Tab","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12",".",",","`","\[","]",
					  ";","'","/", "\\\\","-","=","Multiply","Divide","Subtract","Add","Numpad0","Numpad1","Numpad2",
					  "Numpad3","Numpad4","Numpad5","Numpad6","Numpad7","Numpad8","Numpad9","Decimal","Insert",
					  "Delete","Back","Apps","Pause"))

		winset(src, "[k]", "parent=Macros;name=\"[k]\";command=\"KeyDown [k]\"")
		winset(src, "[k]UP", "parent=Macros;name=\"[k]+UP\";command=\"KeyUp [k]\"")

/mob/verb/KeyDown(var/Key as text)
	client.KeyDown(Key, src)

/mob/verb/KeyUp(var/Key as text)
	client.KeyUp(Key, src)