
local SimpleLetter = Class(function(self, inst)
	self.inst = inst

	self.inst:AddTag("simpleletter")

	--self.onreadfn = nil
end)

function SimpleLetter:OnRemoveFromEntity()
    self.inst:RemoveTag("simpleletter")
end

function SimpleLetter:Read(doer)
	if not CanEntitySeeTarget(doer, self.inst) then
		return false
	end

	if self.onreadfn then
		self.onreadfn(self.inst, doer)
	end
end

return SimpleLetter