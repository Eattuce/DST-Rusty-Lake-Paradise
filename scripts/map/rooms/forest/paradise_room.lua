AddRoom("Paradise_room", {
    colour={r=.5,g=0.6,b=.080,a=.10},
    value = GROUND.FOREST,
    -- tags = {"RoadPoison", "nohunt", "nohasslers", "not_mainland", "paradisearea"},
    required_prefabs = {
    },
    contents =  {
        distributepercent = 0.01 ,
        distributeprefabs =
        {
            seastack = 1,
            seastack_spawner_rough = 0.09,
        },
        countstaticlayouts =
        {
            ["ParadiseIsland"] = 1,
        },
    }})

