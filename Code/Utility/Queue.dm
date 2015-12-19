Queue
	var/list/Items = list( )

	proc
		Enqueue(var/Item)
			Items += Item

		Dequeue()
			ASSERT(Items.len)
			. = Items[1]
			Items.Cut(1, 2)

		IsEmpty()
			return Items.len == 0

		Count()
			return Items.len

		Clear()
			Items = list( )