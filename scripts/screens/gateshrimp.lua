local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
require "mathutil"



local GateShrimp = Class(Screen, function(self, owner)
    Screen._ctor(self, "GateShrimp")

    self.owner = owner
    self.time_since_start = 0
    self.duration = 1
    self.stages =
    {
        david = false,
        block = false,
        thought = false,
    }
    self.stage = 0

    self.owner:ListenForEvent("GateShrimp_DavidFace_unlock", function() self.stages["david"] = true end)
    self.owner:ListenForEvent("GateShrimp_Block_unlock", function() self.stages["block"] = true end)
    self.owner:ListenForEvent("GateShrimp_Thought_unlock", function() self.stages["thought"] = true end)

    local function MoveImage(image, x, y) return self:_MoveImage(image, x, y) end
    -- self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    -- self:SetMaxPropUpscale(MAX_HUD_SCALE)
    -- self:SetPosition(0, 0, 0)
    -- self:SetVAnchor(ANCHOR_MIDDLE)
    -- self:SetHAnchor(ANCHOR_MIDDLE)
    local black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    black.image:SetVRegPoint(ANCHOR_MIDDLE)
    black.image:SetHRegPoint(ANCHOR_MIDDLE)
    black.image:SetVAnchor(ANCHOR_MIDDLE)
    black.image:SetHAnchor(ANCHOR_MIDDLE)
    black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    black.image:SetTint(0,0,0,.3)
    black:SetOnClick(function() TheFrontEnd:PopScreen() end)

    local root = self:AddChild(Widget("ROOT"))
    root:SetVAnchor(ANCHOR_MIDDLE)
    root:SetHAnchor(ANCHOR_MIDDLE)
    root:SetPosition(20, 0, 0)
    root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    -- 门
    local bgdoor = root:AddChild(Image("images/widgets/gateshrimp_background.xml", "gateshrimp_background.tex"))

    local uproot = root:AddChild(Widget("uproot"))
    uproot:SetPosition(-210,115)

    local downroot = root:AddChild(Widget("downroot"))


    self.david_face = uproot:AddChild(Image("images/widgets/david_face.xml", "david_face.tex"))
    self.david_face:SetPosition(-200, 0)




    local frontdoor = root:AddChild(Image("images/widgets/gateshrimp_background.xml", "gateshrimp_background.tex"))
    local superroot = frontdoor:AddChild(Widget("uproot"))
    superroot:SetPosition(-210,115)


    local upwintrigger = superroot:AddChild(Image("images/global.xml", "square.tex"))
    upwintrigger:SetSize(200,200)
    upwintrigger:SetTint(0,0,0,.3)
    upwintrigger.OnMouseButton = function (button, down, x, y)
        if self.stage == 0 then
            self.owner:PushEvent("GateShrimp_Block_unlock", self.owner)
        elseif self.stage == 1 then
            self.owner:PushEvent("GateShrimp_DavidFace_unlock", self.owner)
        elseif self.stage == 2 then
            self.owner:PushEvent("GateShrimp_Thought_unlock", self.owner)
        end
    end
end)


function GateShrimp:_MoveImage(image, x, y)
    self.tasks[#self.tasks + 1] = self.inst:DoPeriodicTask(.1, function()
        local pos = image:GetPosition()
        local xpercent = 1
        image:SetPosition(pos.x , pos.y)
        image:SetString("Y: " .. pos.y)
    end)

end

function GateShrimp:OnDestroy()
    SetAutopaused(false)

    POPUPS.PARADISEGATESHRIMP:Close(self.owner)

	GateShrimp._base.OnDestroy(self)
end

function GateShrimp:OnBecomeInactive()
    GateShrimp._base.OnBecomeInactive(self)
end

function GateShrimp:OnBecomeActive()
    GateShrimp._base.OnBecomeActive(self)
end

function GateShrimp:OnControl(control, down)
    -- Sends clicks to the screen
    if GateShrimp._base.OnControl(self, control, down) then return true end

    if not down and (control == CONTROL_MAP or control == CONTROL_CANCEL) then
		TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        TheFrontEnd:PopScreen()
        return true
    end

	return false
end

function GateShrimp:OnUpdate(dt)
    if self.stages["david"] then
        self.time_since_start = self.time_since_start + dt
        if self.time_since_start > 0 and self.time_since_start <= 1 then
            local x = Lerp(-200, 0, self.time_since_start)
            self.david_face:SetPosition(x, 0)
        elseif self.time_since_start > 1 then
            self.time_since_start = 0
            self.stages["david"] = false
            self.stage = self.stage + 1
        end
    end

    if self.stages["block"] then
        self.time_since_start = self.time_since_start + dt
        if self.time_since_start > 0 and self.time_since_start <= 1 then
            local x = Lerp(-200, 0, self.time_since_start)
            self.david_face:SetPosition(x, 0)
        elseif self.time_since_start > 1 then
            self.time_since_start = 0
            self.stages["david"] = false
            self.stage = self.stage + 1
        end
    end

    if self.stages["david"] then
        self.time_since_start = self.time_since_start + dt
        if self.time_since_start > 0 and self.time_since_start <= 1 then
            local x = Lerp(-200, 0, self.time_since_start)
            self.david_face:SetPosition(x, 0)
        elseif self.time_since_start > 1 then
            self.time_since_start = 0
            self.stages["david"] = false
            self.stage = self.stage + 1
        end
    end

end




return GateShrimp