GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

PrefabFiles =
{
    "locationsign",
    "paradise_envelope",
    -- "paradise_tree",
    "cameraheadinghelpers",
    "paradise_gatetree",
    "paradise_gate",
    "paradise_fence",
    "nailtree",
    "paradise_bloodpool"
}

Assets=
{
    Asset("IMAGE", "images/widgets/paper.tex"),
    Asset("ATLAS", "images/widgets/paper.xml"),
    Asset("IMAGE", "images/inventoryimages/paradise_envelope.tex"),
    Asset("ATLAS", "images/inventoryimages/paradise_envelope.xml"),

    Asset("IMAGE", "images/shockover.tex"),
    Asset("ATLAS", "images/shockover.xml"),

    Asset("IMAGE", "images/widgets/gateshrimp_background.tex"),
    Asset("ATLAS", "images/widgets/gateshrimp_background.xml"),
    Asset("IMAGE", "images/widgets/david_face.tex"),
    Asset("ATLAS", "images/widgets/david_face.xml"),

    Asset("FONT", "fonts/letterfont.zip"),

    Asset("ANIM", "anim/letter.zip"),
    Asset("ANIM", "anim/upperwin.zip"),

}

modimport("scripts/languages/strings_chinese.lua")
modimport("scripts/paradise_actions.lua")



RegisterInventoryItemAtlas("images/inventoryimages/paradise_envelope.xml", "paradise_envelope.tex")

-- 增加字体
GLOBAL.LETTERFONT_PARADISE = "letterfont"
AddSimPostInit(function()
	TheSim:UnloadFont(GLOBAL.LETTERFONT_PARADISE)
	TheSim:UnloadPrefabs({"letterfont"})

	local Assets = {
		Asset("FONT", GLOBAL.resolvefilepath("fonts/letterfont.zip")),
	}
	local FontsPrefab = GLOBAL.Prefab("letterfont", function() return GLOBAL.CreateEntity() end, Assets)
	GLOBAL.RegisterPrefabs(FontsPrefab)
	TheSim:LoadPrefabs({"letterfont"})
	TheSim:LoadFont(GLOBAL.resolvefilepath("fonts/letterfont.zip"), GLOBAL.LETTERFONT_PARADISE)
end)
-----------------------------------------------------------

-- 增加hud对screen的开关
AddClassPostConstruct("screens/playerhud", function (self)
    local LetterFromFather = require("screens/letterfromfather")
    function self:OpenLetterScreen()
        self:CloseLetterScreen()
        self.letterscreen = LetterFromFather(self.owner)
        self:OpenScreenUnderPause(self.letterscreen)
        return true
    end

    function self:CloseLetterScreen()
        if self.letterscreen ~= nil then
            if self.letterscreen.inst:IsValid() then
                TheFrontEnd:PopScreen(self.letterscreen)
            end
            self.letterscreen = nil
        end
    end

end)

-- 增加弹出界面
AddPopup("LETTERFROMFATHER") -- AddPopup(Name of the popup)
POPUPS.LETTERFROMFATHER.fn = function (inst,show)
    if inst.HUD then
        if not show then
            inst.HUD:CloseLetterScreen()
        elseif not inst.HUD:OpenLetterScreen() then
            POPUPS.LETTERFROMFATHER:Close(inst)
        end
    end
end
-----------------------------------------------------------


-- 增加读和收信的state
local letteropen_master = State{
    name = "letter_open",
    tags = { "doing" },

    onenter = function(inst)
        inst.components.locomotor:StopMoving()
        inst.AnimState:OverrideSymbol("book_cook", "letter", "book_cook")
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("reading_in", false)
        inst.AnimState:PushAnimation("reading_loop", true)
    end,

    timeline =
    {
        TimeEvent(8 * FRAMES, function(inst)
            inst:PerformBufferedAction()
        end),
    },

    onupdate = function(inst)
        if not CanEntitySeeTarget(inst, inst) then
            inst.sg:GoToState("letter_close")
        end
    end,

    events =
    {
        EventHandler("ms_closepopup", function(inst, data)
            if data.popup == POPUPS.LETTERFROMFATHER then
                inst.sg:GoToState("letter_close")
            end
        end),
    },

    onexit = function(inst)
        inst:ShowPopUp(POPUPS.LETTERFROMFATHER, false)
    end,
}
AddStategraphState("wilson", letteropen_master)

local letterclose_master = State{
    name = "letter_close",
    tags = { "idle", "nodangle" },

    onenter = function(inst)
        inst.components.locomotor:StopMoving()
        inst.AnimState:PlayAnimation("reading_pst")
    end,

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState(inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) ~= nil and "item_out" or "idle")
            end
        end),
    },
}
AddStategraphState("wilson", letterclose_master)
-----------------------------------------------------------

-- 增加读信的动作
local READLETTER = Action({priority = 0, invalid_hold_action = true })
READLETTER.id = "READLETTER"
READLETTER.str = STRINGS.READLETTER
READLETTER.fn = function(act)
    local targ = act.target or act.invobject
    if targ ~= nil and act.doer ~= nil then
		if targ.components.book ~= nil and act.doer.components.reader ~= nil then
	        return act.doer.components.reader:Read(targ)
		elseif targ.components.simpleletter ~= nil then
			targ.components.simpleletter:Read(act.doer)
			return true
		end
	end
end
AddAction(READLETTER)
-- 把动作绑定到simpleletter组件
AddComponentAction("INVENTORY", "simpleletter", function(inst, doer, actions)
    table.insert(actions, ACTIONS.READLETTER)
end)
-- 触发读信动作的时候进入letter_open这个state
AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.READLETTER, "letter_open"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.READLETTER, "letter_open"))
-----------------------------------------------------------

-- 给玩家增加组件以实现登录天堂岛视角转化
AddPlayerPostInit(function(inst)
    inst:AddComponent("paradisewalker")
end)

-- 给世界增加天堂岛组件存储数据
AddPrefabPostInit("forest", function (inst)
    if not inst.ismastersim then
        return inst
    end
    inst:AddComponent("paradise")
end)

-- 增加画面图层
AddClassPostConstruct("screens/playerhud", function (self)
    local ParadiseShockOver = require "widgets/paradiseshockover"
    local _CreateOverlays = self.CreateOverlays
    function self:CreateOverlays(owner)
        _CreateOverlays(self, owner)
        self.paradiseshockover = self.overlayroot:AddChild(ParadiseShockOver(owner))
    end
end)
