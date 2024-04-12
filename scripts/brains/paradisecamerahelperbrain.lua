require "behaviours/standandattack"
require "behaviours/faceentity"

local ParadiseCameraHelperBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetFaceTargetFn(inst)
    local target = TheWorld.components.paradise:GetParadise()
    return target ~= nil and target or nil
end

local function KeepFaceTargetFn(inst, target)
    return true
end

function ParadiseCameraHelperBrain:OnStart()
    local root = LoopNode({FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn)})

    self.bt = BT(self.inst, root)
end

return ParadiseCameraHelperBrain
