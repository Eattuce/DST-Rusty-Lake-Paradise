local assets =
{
    Asset("ANIM", "anim/nailtree.zip"),
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("nailtree")
    inst.AnimState:SetBuild("nailtree")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    local color = 0.75 + math.random() * 0.25
    inst.AnimState:SetMultColour(color, color, color, 1)

    -- inst:AddComponent("playerprox")


    return inst
end

return Prefab("nailtree", fn, assets)
