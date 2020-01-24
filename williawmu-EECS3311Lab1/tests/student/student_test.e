note
	description: "Summary description for {STUDENT_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TEST

inherit
	ES_TEST

create
	make
feature {NONE}-- Initialization

	make
		do
			add_boolean_case(agent t1)
			add_boolean_case(agent t2)
			add_boolean_case(agent t3)
			add_boolean_case(agent t4)
			add_boolean_case(agent t5)
		end

feature -- Tests

	t1: BOOLEAN
		local
			v1, v2: VERTEX[INTEGER]
			e1: EDGE[INTEGER]
		do
			comment("t1: Test add_edge src and des has the same value")
			create v1.make (3)
			create v2.make (3)
			create e1.make (v1, v2)
			v1.add_edge (e1)
			Result := v1.outgoing.count ~ 1 and v1.incoming.count ~ 1
			check
				Result
			end

			Result := v2.outgoing.count ~ 0 and v2.incoming.count ~ 0
			check
				Result
			end

			v2.add_edge (e1)

			Result := v2.outgoing.count ~ 1 and v2.incoming.count ~ 1
			check
				Result
			end
		end

	t2: BOOLEAN
		local
			v1, v2: VERTEX [INTEGER]
			e1: EDGE [INTEGER]
		do
			comment("t2: Seperate step Test on t10 add & remove first loop")
			create v1.make (4)
			create v2.make (-1)
			create e1.make (v1, v2)
			v1.add_edge (e1)

			v2.add_edge (e1)

			create v2.make (3)
			create e1.make (v2, v1)
			v1.add_edge (e1)


			-- Add self loop
			create e1.make (v1, v1)
			v1.add_edge (e1)
			Result := v1.incoming.has (e1) and v1.outgoing.has (e1) and v1.edge_count ~ 4
			check
				Result
			end



			-- Remove it via reference to object
			v1.remove_edge (e1)
			Result := not v1.incoming.has (e1) and not v1.outgoing.has (e1)
			check
				Result
			end

			-- Add self loop again
			create e1.make (v1, v1)
			v1.add_edge (e1)
			Result := v1.incoming.has (e1) and v1.outgoing.has (e1) and v1.edge_count ~ 4
			check
				Result
			end

				-- Remove it again
			v1.remove_edge (e1)
			Result := not v1.incoming.has (e1) and not v1.outgoing.has (e1)
			check
				Result
			end
		end





	t3: BOOLEAN
		local
			v1, v2: VERTEX [INTEGER]
			e1: EDGE [INTEGER]
		do
			comment("t2: Seperate step Test on t10 add & remove second loop")
			create v1.make (4)
			create v2.make (-1)
			create e1.make (v1, v2)
			v1.add_edge (e1)

			v2.add_edge (e1)

			create v2.make (3)
			create e1.make (v2, v1)
			v1.add_edge (e1)


			-- Add self loop  (1st loop)
			create e1.make (v1, v1)
			v1.add_edge (e1)

			-- Remove it via reference to object
			v1.remove_edge (e1)

			-- Add self loop again (2nd loop)
			create e1.make (v1, v1)
			v1.add_edge (e1)
			Result := v1.incoming.has (e1) and v1.outgoing.has (e1) and v1.edge_count ~ 4
			check
				Result
			end

				-- Remove it again
			v1.remove_edge (e1)
			Result := not v1.incoming.has (e1) and not v1.outgoing.has (e1)
			check
				Result
			end
		end

	t4: BOOLEAN
		local
				i_g: LIST_GRAPH [INTEGER]
				i_a: ARRAY [TUPLE [INTEGER, INTEGER]]
			do
				comment ("t4: inner test of t14 in List_Graph_Tester")
				i_a := <<[1, 2], [1, 3], [1, 1], [3, 4], [3, 5], [5, 6], [6, 5]>>
				i_a.compare_objects
				create i_g.make_from_array (i_a)
			--	assert_equal ("correct vertices & edges", "[1:1,2,3][2][3:4,5][4][5:6][6:5]", i_g.out)
				Result := i_g.edge_count ~ 7 and i_g.vertex_count ~ 6
			--	check
			--		Result
			--	end
				i_g.remove_edge (i_g.vertices [1].outgoing [1]) -- [1] will take out "[1,2]" because outgoing is not sorted
			--	assert_equal ("correct vertices & edges", "[1:1,3][2][3:4,5][4][5:6][6:5]", i_g.out)
				Result := i_g.edge_count ~ 6 --and i_g.vertex_count ~ 6
				check
					Result
				end
			end

	t5: BOOLEAN
		local
			i_g: LIST_GRAPH [INTEGER]
			i_a: ARRAY [TUPLE [INTEGER, INTEGER]]
		do
			comment ("t5: remove specific item")
			i_a := <<[1, 2], [1, 3], [1, 1], [3, 4], [3, 5], [5, 6], [6, 5]>>
			i_a.compare_objects
			create i_g.make_from_array (i_a)
			assert_equal ("correct vertices & edges", "[1:1,2,3][2][3:4,5][4][5:6][6:5]", i_g.out)

			Result := i_g.edge_count ~ 7 and i_g.vertex_count ~ 6
			check
				Result
			end
			Result := i_g.edges.count ~ i_g.edge_count
			check
				Result
			end


			i_g.remove_edge (i_g.vertices [1].outgoing [1])
			Result := i_g.edges.count ~ i_g.edge_count
			check
				Result
			end

			i_g.remove_edge (i_g.vertices [3].outgoing [1])
			Result := i_g.edges.count ~ i_g.edge_count
			check
				Result
			end
			i_g.remove_edge (i_g.vertices [5].outgoing [1])
			Result := i_g.edges.count ~ i_g.edge_count
			check
				Result
			end
			i_g.remove_edge (i_g.vertices [6].outgoing [1])
			Result := i_g.edges.count ~ i_g.edge_count
			check
				Result
			end
			assert_equal ("correct vertices & edges", "[1:1,3][2][3:5][4][5][6]", i_g.out)
			Result := i_g.edge_count ~ 3 and i_g.vertex_count ~ 6
			check
				Result
			end
		end
end
