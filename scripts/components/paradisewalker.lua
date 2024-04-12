require("mathutil")
local percentFromPlayer = 1
local STARTING_CAMERA_OFFSET = 1.5
local FINAL_CAMERA_OFFSET = 1
-- local camangle_final = getheadingtarget()


local function getheadingtarget()
	return TheWorld.components.paradise:GetCameraHeadingTarget() or 270
end

local function roundToNearest(numToRound, multiple)
	-- local half = multiple/2
	-- return numToRound+half - (numToRound+half) % multiple
	return multiple
end

local ParadiseWalker = Class(function(self, inst)
    self.inst = inst

    self.current_tile = nil
    self.last_tile = nil

    self.objToTrack = nil

    self.prevCamAngle = 45
    self.prevCamDist = 30

    -- self.inst:ListenForEvent("PW_steponparadiseground", self.LockCamera(self))
	-- self.inst:ListenForEvent("PW_stepoutofparadiseground", self.ReleaseCamera(self))

    self.inst:StartUpdatingComponent(self)
end)

function ParadiseWalker:Pause()
	self.inst:StopUpdatingComponent(self)
	if not TheCamera:IsControllable() then
		TheCamera:SetDistance(self.prevCamDist)
		TheCamera:SetHeadingTarget(self.prevCamAngle)
		TheCamera:Apply()
	end
	TheCamera:SetControllable(true)
	self.prevCamAngle = TheCamera:GetHeadingTarget()
	self.prevCamDist = TheCamera:GetDistance()
end

function ParadiseWalker:OnUpdate(dt)
    if not self.inst:IsValid() then
        return
    end

    local x, y, z = self.inst.Transform:GetWorldPosition()
    local current_ground_tile = TheWorld.Map:GetTileAtPoint(x, 0, z)

    self.last_tile = self.current_tile
    self.current_tile = current_ground_tile
    if self.current_tile ~= self.last_tile then
		self.landtime = GetTime()
        if self.current_tile == GROUND.FOREST then
			self.isinparadise = true
            self.inst:PushEvent("PW_steponparadiseground",{})
		else
			self.inst:PushEvent("PW_stepoutofparadiseground",{})
			self.isinparadise = false
        end
    end

	self:LockCamera()
end

function ParadiseWalker:LockCamera()
	local camangle_final = getheadingtarget()

	if self.isinparadise then
		TheCamera:SetControllable(false)
		percentFromPlayer = 1 - 0.3 * (GetTime() - self.landtime)

		if percentFromPlayer >= 0 and percentFromPlayer <= 1 then
			local camAngle = Lerp(roundToNearest(self.prevCamAngle, camangle_final), self.prevCamAngle, percentFromPlayer)
			local camDist = Lerp(15, self.prevCamDist, percentFromPlayer)
			TheCamera:SetOffset(Vector3(0,Lerp(FINAL_CAMERA_OFFSET,STARTING_CAMERA_OFFSET,percentFromPlayer),0))
			TheCamera:SetDistance(camDist)
			TheCamera:SetHeadingTarget(camAngle)
			TheCamera:Apply()
		elseif percentFromPlayer < 0 then
			if TheCamera:GetHeadingTarget() ~= roundToNearest(self.prevCamAngle, camangle_final) then
				TheCamera:SetOffset(Vector3(0,FINAL_CAMERA_OFFSET,0))
				TheCamera:SetDistance(15)
				TheCamera:SetHeadingTarget(roundToNearest(self.prevCamAngle, camangle_final))
				TheCamera:Apply()
			end
		end
	else
		if not TheCamera:IsControllable() then
			TheCamera:SetDistance(self.prevCamDist)
			TheCamera:SetHeadingTarget(self.prevCamAngle)
			TheCamera:Apply()
		end
		TheCamera:SetControllable(true)
		self.prevCamAngle = TheCamera:GetHeadingTarget()
		self.prevCamDist = TheCamera:GetDistance()
	end
end

function ParadiseWalker:OnLoad(data)
    self.prevCamAngle = 45
    self.prevCamDist = 30
end


return ParadiseWalker