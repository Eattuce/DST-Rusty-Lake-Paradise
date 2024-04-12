local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"

local GateShrimpAWidget = Class(Widget, function(self, owner)

    Widget._ctor(self, "GateShrimpAWidget")

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

    local function turnon(stage) return self:TurnOn(stage) end
    local function turnoff() return self:TurnOff() end

    self.owner:ListenForEvent("GateShrimp_DavidFace_unlock", function() turnon("david") end)
    self.owner:ListenForEvent("GateShrimp_Block_unlock", function() turnon("block") end)
    self.owner:ListenForEvent("GateShrimp_Thought_unlock", function() turnon("thought") end)


    self.david_face = self:AddChild(Image("images/widgets/david_face.xml", "david_face.tex"))
    self.david_face:SetPosition(-200, 0)

end)

function GateShrimpAWidget:TurnOn(stage)
    self.stages[stage] = true
    self.stage = self.stage + 1
    self:StartUpdating()
end

function GateShrimpAWidget:TurnOff(stage)
    self:StopUpdating()
end


function GateShrimpAWidget:OnUpdate(dt)
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

    if self.stages["thought"] then
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




return GateShrimpAWidget