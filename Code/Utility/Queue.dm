Queue
	var/list/Items = list( )

	proc
		Enqueue(var/Item)
			Items += Item

		Dequeue()
			. = Peek()
			Items.Cut(1, 2)

		Peek()
			ASSERT(Items.len)
			. = Items[1]

		IsEmpty()
			return Items.len == 0

		Count()
			return Items.len

		Clear()
			Items = list( )