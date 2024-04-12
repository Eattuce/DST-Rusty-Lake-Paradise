AddTask("Paradise_Task", {
	locks={LOCKS.NONE},
	keys_given={},
	region_id = "island_paradise",
	level_set_piece_blocker = true,
	room_tags = {"RoadPoison", "nohunt", "nohasslers", "paradisearea", "not_mainland"},
    room_choices =
    {
        ["Paradise_room"] = 1,
    },
    room_bg = GROUND.PEBBLEBEACH,
    background_room = "Empty_Cove",
	-- cove_room_name = "Blank",
    -- make_loop = true,
	crosslink_factor = 2,
	-- cove_room_chance = 1,
	-- cove_room_max_edges = 2,
    colour={r=0.6,g=0.6,b=0.0,a=1},
})
