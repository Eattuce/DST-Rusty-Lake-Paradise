
-- 增加hud对screen的开关
AddClassPostConstruct("screens/playerhud", function (self)
    local GateShrimp = require("screens/gateshrimp")
    function self:OpenGateShrimpScreen()
        self:CloseGateShrimpScreen()
        self.gateshrimpscreen = GateShrimp(self.owner)
        self:OpenScreenUnderPause(self.gateshrimpscreen)
        return true
    end

    function self:CloseGateShrimpScreen()
        if self.gateshrimpscreen ~= nil then
            if self.gateshrimpscreen.inst:IsValid() then
                TheFrontEnd:PopScreen(self.gateshrimpscreen)
            end
            self.gateshrimpscreen = nil
        end
    end

end)

-- 增加弹出界面
AddPopup("PARADISEGATESHRIMP") -- AddPopup(Name of the popup)
POPUPS.PARADISEGATESHRIMP.fn = function (inst,show)
    if inst.HUD then
        if not show then
            inst.HUD:CloseGateShrimpScreen()
        elseif not inst.HUD:OpenGateShrimpScreen() then
            POPUPS.PARADISEGATESHRIMP:Close(inst)
        end
    end
end




local start_master = State{
    name = "closeinspect_start",
    tags = { "doing" },

    onenter = function(inst)
        inst.components.locomotor:StopMoving()
        inst.AnimState:PlayAnimation("idle_loop", true)
    end,

    timeline =
    {
        TimeEvent(8 * FRAMES, function(inst)
            inst:PerformBufferedAction()
        end),
    },

    onupdate = function(inst)
        if not CanEntitySeeTarget(inst, inst) then
            inst.sg:GoToState("closeinspect_end")
        end
    end,

    events =
    {
        EventHandler("ms_closepopup", function(inst, data)
            if data.popup == POPUPS.PARADISEGATESHRIMP then
                inst.sg:GoToState("closeinspect_end")
            end
        end),
    },

    onexit = function(inst)
        inst:ShowPopUp(POPUPS.PARADISEGATESHRIMP, false)
    end,
}
AddStategraphState("wilson", start_master)

local end_master = State{
    name = "closeinspect_end",
    tags = { "idle", "nodangle" },

    onenter = function(inst)
        inst.components.locomotor:StopMoving()
        inst.sg:GoToState("idle")
    end,
}
AddStategraphState("wilson", end_master)





-- 定义 [仔细观察] 动作
local CLOSEINSPECT = Action({priority = 0})
CLOSEINSPECT.id = "CLOSEINSPECT"
-- CLOSEINSPECT.str = STRINGS.CLOSEINSPECT
-- 动作具体内容
CLOSEINSPECT.fn = function(act)
    local tar = act.target or act.invobject

    if tar ~= nil and
        tar.components.closeinspectable ~= nil and
        tar.components.closeinspectable:CanInteract(act.doer) then
        return tar.components.closeinspectable:StartInspecting(act.doer)
    end
end

-- 动作显示的名字
CLOSEINSPECT.strfn = function(act)
    local tar = act.target or act.invobject
    return tar:HasTag("closeinspect_talk") and "TALKTO" or "GENERIC"
end
AddAction(CLOSEINSPECT)

-- 为 [仔细观察] 组件增加 [仔细观察] 动作
-- 这里是为组件增加动作，在这里判断组件 在什么条件下 可以进行的动作是什么
AddComponentAction("SCENE", "closeinspectable", function(inst, doer, actions, right)
    table.insert(actions, ACTIONS.CLOSEINSPECT)
end)

-- 触发[]动作的时候进入[]状态
AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.CLOSEINSPECT, "closeinspect_start"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.CLOSEINSPECT, "closeinspect_start"))
