local Widget = require "widgets/widget"
local Image = require "widgets/image"
require("mathutil")
local ParadiseShockOver =  Class(Widget, function(self, owner)
    self.owner = owner
    Widget._ctor(self, "ParadiseShockOver")
    self:UpdateWhilePaused(false)

    self:SetClickable(false)

    self.bg = self:AddChild(Image("images/shockover.xml", "shockover.tex"))
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)

    self:Hide()

    self.time_since_pulse = 0
    self.pulse_period = 1
    self.cantrigger = true
    local function _Flash() self:Flash() end
    local function _UpdateState() self:UpdateState() end

    -- self.inst:ListenForEvent("PW_steponparadiseground", _Flash, owner)
    self.inst:ListenForEvent("PW_steponparadiseground", _UpdateState, owner)
    self.inst:DoTaskInTime(0, _UpdateState)
end)

function ParadiseShockOver:UpdateState()
    if self.cantrigger then
        self:TurnOn()
    else
        self:TurnOff()
    end
end

function ParadiseShockOver:TurnOn()
    self:StartUpdating()
    self.time_since_pulse = 0
end

function ParadiseShockOver:TurnOff()
    -- --self:OnUpdate(0)
end

function ParadiseShockOver:OnUpdate(dt)
    self.time_since_pulse = self.time_since_pulse + dt
    self:Show()
    self.bg:SetTint(1, 1, 1, Lerp(0.8, 0, self.time_since_pulse))

    if self.time_since_pulse > self.pulse_period then
        self.time_since_pulse = 0
        -- TheWorld.components.paradise:SetPlayerHasBeenToIsland(self.owner)
        -- self.cantrigger = not TheWorld.components.paradise:GetPlayerHasBeenToIsland(self.owner)
        if not IsEntityDead(self.owner) then
            TheInputProxy:AddVibration(VIBRATION_BLOOD_OVER, .2, .3, false)
            self:StopUpdating()
            self:Hide()
        end
    end
end

function ParadiseShockOver:Flash()
    TheInputProxy:AddVibration(VIBRATION_BLOOD_FLASH, .2, .7, false)
    self:StartUpdating()
end

return ParadiseShockOver
