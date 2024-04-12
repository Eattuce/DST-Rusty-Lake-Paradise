local function onbeinginspected(self, beinginspected)
    if beinginspected then
        self.inst:AddTag("beinginspected")
    else
        self.inst:RemoveTag("beinginspected")
    end
end

local CloseInspectable = Class(function(self, inst)
	self.inst = inst
	self.oninspectfn = nil
	self.onstopinspectfn = nil
	self.beinginspected = false
	self.stopinspectevents = nil
end,
nil,
{
    beinginspected = onbeinginspected,
})

function CloseInspectable:OnRemoveFromEntity()
    self.inst:RemoveTag("beinginspected")
end

function CloseInspectable:SetOnInspectFn(fn)
	self.oninspectfn = fn
end

function CloseInspectable:SetCanInteractfn(fn)
	self.oninspectfn = fn
end

function CloseInspectable:SetOnStopInspectFn(fn)
	self.onstopinspectfn = fn
end

function CloseInspectable:CanInteract(doer)
    if self.caninteractfn then
        return self.caninteractfn(doer)
    end
    -- if self.exclusive then
    --     return not self.beinginspected
    -- end
    return true
end

function CloseInspectable:StartInspecting(doer)
	self.beinginspected = true
	if self.oninspectfn then
		self.beinginspected = self.oninspectfn(self.inst, doer) ~= false
	end

	if self.stopinspectevents then
		self.stopinspectevents(self.inst)
	end
	return self.beinginspected
end

function CloseInspectable:StopInspecting(doer)
	self.beinginspected = false
	if self.onstopinspectfn then
		self.onstopinspectfn(self.inst, doer)
	end
end

function CloseInspectable:GetDebugString()

    return string.format("ininspect=%s", tostring(self.beinginspected))
end


return CloseInspectable