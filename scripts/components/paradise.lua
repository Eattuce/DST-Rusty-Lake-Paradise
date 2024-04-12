
local Paradise = Class(function(self, inst)
    assert(TheWorld.ismastersim, "Paradise should not exist on client")

    self.inst = inst
    self.headingtarget = 270
    self.charpter = nil
    self.shrimp = false


    self.paradise = nil -- Registered in prefab file
    self.playermetparadiseisland = {}
end)

function Paradise:GetCameraHeadingTarget()
	return self.headingtarget
end






function Paradise:SetPlayerHasBeenToIsland(player, info)
    self.playermetparadiseisland[player.userid] = info or true
end

function Paradise:GetPlayerHasBeenToIsland(player)
    return self.playermetparadiseisland[player.userid]
end

function Paradise:GetParadise()
	return self.paradise ~= nil and self.paradise:IsValid() and self.paradise or nil
end

function Paradise:OnUpdate()
    -- 
end

function Paradise:OnSave()
    local data = {}

	if next(self.playermetparadiseisland) ~= nil then
		data.playermetparadiseisland = self.playermetparadiseisland
	end
    -- data.shrimp = self.shrimp

    return data
end


function Paradise:OnLoad(data)
    if data ~= nil then
        if data.playermetparadiseisland then
            self.playermetparadiseisland = data.playermetparadiseisland
        end
        -- if data.shrimp then
        --     self.shrimp = data.shrimp
        -- end
    end
end



return Paradise