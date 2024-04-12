local require = GLOBAL.require
require("map/tasks")
local LAYOUTS = require("map/layouts").Layouts
local STATICLAYOUT = require("map/static_layout")



-- 自己的
-- rooms
require("map/rooms/forest/paradise_room")

-- tasks
require("map/tasks/Paradise_task")


--引入我的Static_layout,可以作为Task_set, 也可以作为Room里包含的Static_layout
-----------------------------------------------------------
--------------------------ISLAND---------------------------
-----------------------------------------------------------
LAYOUTS["ParadiseIsland"] = STATICLAYOUT.Get("map/static_layouts/paradise",
{
    add_topology = {room_id = "StaticLayoutIsland:ParadiseIsland", tags = {"RoadPoison", "nohunt", "nohasslers", "not_mainland", "paradisearea"}},
    min_dist_from_land = 0,
})

AddRoomPreInit("OceanRough", function (room)
    room.contents.countstaticlayouts["ParadiseIsland"] = 1
end)


-- AddTaskSetPreInit("default", function(taskset)
--     table.insert(taskset.tasks, "Paradise_Task")
-- end)

-- AddTaskSetPreInit("default", function(taskset)
--     taskset.ocean_prefill_setpieces["ParadiseIsland"] = {count = 1}
-- end)

-- AddTaskPreInit("Lightning Bluff", function(task) -- 绿洲沙漠 DLCtasks
--     task.room_choices["TechandBush"] = 1  -- 科技是一个Static layout 放在了这个room里
-- end)


-- AddTaskPreInit("Lightning Bluff",function(task)
--     task.room_choices["WormholeToRelic"] = 1
-- end)


-- AddTaskSetPreInit("default", function(taskset)
--     table.insert( taskset.tasks,"IslandRelic" )
-- end)

