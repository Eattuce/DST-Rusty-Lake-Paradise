
local function update(inst)
    local target = TheWorld.components.paradise:GetParadise()
    inst:FacePoint(target.Transform:GetWorldPosition())
    local headingtarget = math.floor(inst.Transform:GetRotation()+0.5)      -- 确保是个整数(89.998x)
                                                                            -- inst.Transform:GetRotation()的理论范围是[-PI,PI)
    headingtarget = - headingtarget
    if headingtarget < 0 then
        headingtarget = headingtarget + 360                                 -- 统一为[0,2PI)避免镜头旋转360度
    end
    if headingtarget == 360 or headingtarget == -0 then                     -- 实际中会出现-0?
        headingtarget = 0
    end
    TheWorld.components.paradise.headingtarget = headingtarget              -- 保存到世界
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.task = inst:DoPeriodicTask(1, update)

    return inst
end


local function RegisterToParadise(inst)
    if TheWorld.components.paradise ~= nil then
        TheWorld.components.paradise.paradise = inst
    end
end


local function fnc()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    RegisterToParadise(inst)

    return inst
end

return Prefab("paradisecamerahelper", fn),
    Prefab("paradisecamerahelper_center", fnc)
