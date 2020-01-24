note
	description: "Summary description for {EDGE_COMPARATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDGE_COMPARATOR [G -> COMPARABLE]

inherit
	KL_COMPARATOR [EDGE[G]]

create
	make

feature -- make
	make
	do
		
	end

feature -- Access
	attached_less_than (u, v: EDGE[G]): BOOLEAN
		do
			Result := u.destination < v.destination
		end


end
