local assets =
{
    Asset("ANIM", "anim/paradise_doors.zip"),
}


local function colliderfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
    MakeObstaclePhysics(inst, 0.5)


    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("Paradise_Door_Open",function () RemovePhysicsColliders(inst) end, TheWorld)

    return inst
end

local function turnon(inst)
    inst.AnimState:PlayAnimation("open")
    inst:AddTag("NOCLICK")
    inst:ListenForEvent("animover", function ()
        if inst.AnimState:IsCurrentAnimation("open") then
            TheWorld:PushEvent("Paradise_Door_Open", inst)
        end
    end)
end


local function onaccept(inst, giver, item)
    local obj = SpawnPrefab(item.prefab)
    inst.components.inventory:GiveItem(obj)
    inst:RemoveTag("fueldepleted")
end

local function CheckItemCorrect(inst, item, giver)
    -- TheWorld.components.paradise:GetCurrentPlague() == "water_turns_into_blood" and item:HasTag("paradise_shrimp") or item:HasTag("paradise_bottled_blood")
    if item:HasTag("cattoy") then
        return true
    end
    return false, "NOT_KEY_FOR_PARADISE"
end

local function onsave(inst)
    local data = {}
    data.tag = not inst:HasTag("fueldepleted")
    return data
end

local function onload(inst, data)
    if data then
        if data.tag then
            onaccept(inst)
        end
    end
end

local function checkinventory(inst)
    if inst.components.inventory:HasItemWithTag("cattoy",1) then
        inst:RemoveTag("fueldepleted")
    end
end

local function oninspect(inst, doer)
    if doer then
        if not CanEntitySeeTarget(doer, inst) then return false end
        -- doer.sg:GoToState("plantregistry_open")
        doer:ShowPopUp(POPUPS.PARADISEGATESHRIMP, true)
    end

end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddPhysics()

    inst:AddTag("door")
    inst:AddTag("fueldepleted")

    inst.AnimState:SetBank("paradise_doors")
    inst.AnimState:SetBuild("paradise_doors")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("closeinspectable")
    inst.components.closeinspectable:SetOnInspectFn(oninspect)

    inst:AddComponent("trader")
    inst.components.trader:SetAbleToAcceptTest(CheckItemCorrect)
    inst.components.trader.onaccept = onaccept
    inst.components.trader.acceptnontradable = true

    inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon

    inst:AddComponent("inventory")

    inst.inittask = inst:DoTaskInTime(0,checkinventory)
    -- inst.OnLoadPostPass = checkinventory
    -- inst.OnSave = onsave
    -- inst.OnLoad = onload


    return inst
end

return Prefab("paradise_doors", fn, assets),
    Prefab("paradise_door_collider", colliderfn)