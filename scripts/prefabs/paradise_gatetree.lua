
local assets =
{
    Asset("ANIM", "anim/gatetree.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddSoundEmitter()
    -- inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .4)

    inst:AddTag("plant")
    inst:AddTag("tree")

    inst.AnimState:SetBank("gatetree")
    inst.AnimState:SetBuild("gatetree")
    inst.AnimState:PlayAnimation("barran")


    if not TheWorld.ismastersim then
        return inst
    end

    -- inst:AddComponent("inspectable")

    return inst
end
return Prefab("paradise_gatetree", fn, assets)
