Stack
	var/list/Items = list( )

	proc
		Push(var/Item)
			Items.Insert(1, list(Item))

		Pop()
			. = Peek()
			Items.Cut(1, 2)

		Peek()
			ASSERT(Items.len)
			. = Items[1]

		IsEmpty()
			. = Items.len == 0

		Count()
			. = Items.len

		Clear()
			Items = list( )