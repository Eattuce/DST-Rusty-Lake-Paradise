
local events = {}
local states=
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst)
            --
        end,
        events =
        {
            -- EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    }
}

return StateGraph("paradisecamerahelper", states, events, "idle")
