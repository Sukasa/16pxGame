#define TRUE 1
#define FALSE 0

/*
 *		Constants File.  This file contains all of the compile-time constants (but done up as const vars), plus a few "constants" that are
 *	produced at run-time such as tile autojoin and all of the /list constants.
 */

var
	const

		Pi = 3.1415926535			// Pi.  This should be accurate enough for most uses.

		#ifdef DEBUG
		Debug = TRUE				// Debug variable marks current compile mode (Debug or Release)
		#else
		Debug = FALSE				// Debug variable marks current compile mode (Debug or Release)
		#endif

		DefaultWorldView = 9		// Default world view radius

		TurfLayer = 1
		BackgroundObjectLayer = 5
		ForegroundObjectLayer = 10
		MobLayer = 15
		PlayerLayer = 17
		HighForegroundObjectLayer = 20

		EffectLayer = 30

		HUDLayer = 99

		Gravity = 0.6

		KeyStateUp = 0				// Key is unpressed
		KeyStatePressed = 3			// Key was just pressed
		KeyStateHeld = 1			// Key has been held down for more than 1 frame

		Infinity = 1.#INF
		NegativeInfinity = -1.#INF
		NaN = 1.#IND

		Visible = 0					// "Visble Always" setting for atom.visibility var
		Invisible = 101				// "Never Visible" setting for atom.visibility var

		AlphaTransparent = 0		// Fully transparent alpha.  Same effect as using Invisible visibility
		AlphaOpaque = 255			// Fully opaque alpha.  Same effect as using Visible visibility
		AlphaHalf = 128				// Semitransparent alpha, half-visible.

		// ASCII Codes
		Tab = 9						// ASCII code for a tab 					(	)
		LineFeed = 10				// ASCII code for a line feed 				(\n)
		CarriageReturn = 13			// ASCII code for a carriage return 		(\r)
		Space = 32					// ASCII code for a space 					( )
		DoubleQuote = 34			// ASCII code for a double quote 			(")
		SingleQuote = 39			// ASCII code for a single quote			(')
		OpenParenthesis = 40		// ASCII code for an open parenthesis 		(()
		EndParenthesis = 41			// ASCII code for an end parenthesis 		())
		Comma = 44					// ASCII code for a comma					(,)
		ForwardSlash = 47			// ASCII code for a forward slash 			(/)
		Semicolon = 59				// ASCII code for a semicolon				(;)
		Equals = 61					// ASCII code for an equals sign character	(=)
		N = 78						// ASCII code for N 						(N)
		R = 82						// ASCII code for R 						(R)
		SmallN = 110				// ASCII code for n 						(n)
		SmallR = 114				// ASCII code for r 						(r)
		Backslash = 92				// ASCII code for a backslash 				(\)
		OpenBracket = 123			// ASCII code for a square opening bracket	([)
		EndBracket = 125			// ASCII code for a square end bracket 		(])

		TickerNotStarted = 0		// Game ticker has not started, or stopped
		TickerRunning = 1			// Game ticker is running
		TickerSuspended = 2			// Game ticker operation temporarily suspended

	OnePixel = (1 / world.icon_size)	// Distance of one pixel

	list

		//NOTE: Don't change the order of these!  The Cardinal* and CardinalAngles* value orders match up with code implemented in Utility/Geometry.dm and Atom.dm
		//Cardinal8 is also used for Autojoin tiling
		Cardinal = 			list(NORTH, EAST, SOUTH, WEST)
		CardinalAngles = 	list(90, 180, 270, 360)

		Cardinal8 = 		list(NORTH, NORTHEAST, EAST, SOUTHEAST, SOUTH, SOUTHWEST, WEST, NORTHWEST)
		CardinalAngles8 =	list(45, 90, 135, 180, 225, 270, 315, 360)

		// Conversion array to take BYOND dir value and convert to an angle.  Used in polar coordinate math
		DirectionAngles =   list(0, 0, 180, 0, 90, 45, 135, 0, 270, 315, 225, 0, 0, 0, 0, 0)
