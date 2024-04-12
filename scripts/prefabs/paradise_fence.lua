
local function gatefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddSoundEmitter()
    -- inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    -- MakeObstaclePhysics(inst, .4)

    inst:AddTag("plant")
    inst:AddTag("tree")

    inst.AnimState:SetBank("paradise_gate")
    inst.AnimState:SetBuild("paradise_gate")
    inst.AnimState:PlayAnimation("idle")


    if not TheWorld.ismastersim then
        return inst
    end

    -- inst:AddComponent("inspectable")

    return inst
end

local function fencefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.entity:SetPristine()

    MakeObstaclePhysics(inst, .5)
    inst.Physics:SetDontRemoveOnSleep(true)

    -- inst:AddTag("wall")

    inst.AnimState:SetBank("paradise_fence")
    inst.AnimState:SetBuild("paradise_fence")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetMultColour(0.75, 0.75, 0.75, 1)
    inst.AnimState:SetScale(0.7,0.8,1)

    -- MakeSnowCoveredPristine(inst)

    -----------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end


return Prefab("paradise_fence", fencefn, {Asset("ANIM", "anim/paradise_fence.zip")}),
    Prefab("paradise_gate", gatefn, {Asset("ANIM", "anim/paradise_gate.zip")})

