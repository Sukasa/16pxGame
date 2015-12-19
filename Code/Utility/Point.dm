Point
	var
		TileX = 0
		TileY = 0
		PixelX = 0
		PixelY = 0
		FineX = 0
		FineY = 0

		// Spoof variables, so Point can masquerade as a mob
		x
		y
		step_y
		step_x
		SubStepX
		SubStepY

Point/New(var/atom/Ref)
	if (!Ref)
		return
	TileX = Ref.x
	TileY = Ref.y
	x = Ref.x
	y = Ref.y

	if (IsMovable(Ref))
		PixelX = Ref:step_x
		PixelY = Ref:step_y
		step_x = PixelX
		step_y = PixelY
		PixelX += Ref:SubStepX
		PixelY += Ref:SubStepY
		SubStepY = Ref:SubStepX
		SubStepX = Ref:SubStepY

	FineX = (TileX * world.icon_size) + PixelX
	FineY = (TileY * world.icon_size) + PixelY


Point/proc/Polar(var/Angle, var/DistPixels)
	PixelX += fix(sin(Angle) * DistPixels)
	PixelY += fix(cos(Angle) * DistPixels)

	while (PixelX < 0)
		PixelX += world.icon_size
		TileX--

	while (PixelX > world.icon_size)
		PixelX -= world.icon_size
		TileX++

	while (PixelY < 0)
		PixelY += world.icon_size
		TileY--

	while (PixelY > world.icon_size)
		PixelY -= world.icon_size
		TileY++

Point/proc/Intersects(var/atom/A)
	var/Width = world.icon_size
	var/Height = world.icon_size

	var/Point/Offset = new(A)
	if (IsMovable(A))
		Width = A:bound_width
		Height = A:bound_height

	.= (FineX in Offset.FineX to Offset.FineX + Width) && (FineY in Offset.FineY to Offset.FineY + Height)

Point/proc/Center(var/atom/movable/X)
	PixelX = X.step_x
	PixelY = X.step_y
	PixelX += X.bound_x
	PixelY += X.bound_y
	PixelX += X.bound_width / 2
	PixelY += X.bound_height / 2
	if (ismob(X))
		PixelX += X:SubStepX
		PixelY += X:SubStepY
	FineX = (TileX * world.icon_size) + PixelX
	FineY = (TileY * world.icon_size) + PixelY
	step_x = PixelX
	step_y = PixelY

Point/proc/SetXOffset(var/X)
	PixelX = X
	FineX = (TileX * world.icon_size) + PixelX
	step_x = PixelX

Point/proc/SetYOffset(var/Y)
	PixelY = Y
	FineY = (TileY * world.icon_size) + PixelY
	step_y = PixelY

Point/proc/CopyXOffset(var/atom/movable/AM)
	PixelX = AM.step_x
	if (ismob(AM))
		PixelX += AM:SubStepX
	FineX = (TileX * world.icon_size) + PixelX
	step_x = PixelX

Point/proc/CopyYOffset(var/atom/movable/AM)
	PixelY = AM.step_y
	if (ismob(AM))
		PixelY += AM:SubStepY
	FineY = (TileY * world.icon_size) + PixelY
	step_y = PixelY

Point/proc/GetXDistanceTo(var/Point/To)
	if (IsAtom(To))
		To = new/Point(To)
	return abs(To.FineX - src.FineX) / world.icon_size

Point/proc/GetYDistanceTo(var/Point/To)
	if (IsAtom(To))
		To = new/Point(To)
	return abs(To.FineY - src.FineY) / world.icon_size

Point/proc/GetDistanceTo(var/Point/To)
	if (IsAtom(To))
		To = new/Point(To)
	var/dX = (To.FineX - src.FineX) / world.icon_size
	var/dY = (To.FineY - src.FineY) / world.icon_size
	return sqrt((dX * dX) + (dY * dY))

Point/proc/GetAngleTo(var/Point/To)
	if (IsAtom(To))
		To = new/Point(To)
	var/dX = To.FineX - src.FineX
	var/dY = To.FineY - src.FineY
	if(!dY)
		return (dX >= 0) ? 90 : 270
	. = arctan(dX / dY)
	if(dY < 0)
		return . + 180
	if (dX < 0)
		return . + 360

Point/proc/Clone()
	var/Point/P = new()
	P.TileX = TileX
	P.TileY = TileY
	P.PixelX = PixelX
	P.PixelY = PixelY
	P.FineX = FineX
	P.FineY = FineY
	P.x = x
	P.y = y
	P.step_x = step_x
	P.step_y = step_y
	return P