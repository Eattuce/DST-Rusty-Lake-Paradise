local assets =
{
    Asset("ANIM", "anim/paradise_envelope.zip"),
}

local function OnReadBook(inst, doer)
	doer:ShowPopUp(POPUPS.LETTERFROMFATHER, true)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("paradise_envelope")
    inst.AnimState:SetBuild("paradise_envelope")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetScale(0.5,0.5,0.5)

    -- inst:AddTag("irreplaceable")
    -- inst:AddTag("nonpotatable")

    MakeInventoryFloatable(inst, "med", 0.05, 0.68)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst:AddComponent("inspectable")

    inst:AddComponent("simpleletter")
    inst.components.simpleletter.onreadfn = OnReadBook

    -- inst:AddComponent("fuel")
    -- inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    -- MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    -- MakeSmallPropagator(inst)

    -- MakeHauntableLaunchAndIgnite(inst)

    return inst
end

return Prefab("paradise_envelope", fn, assets)
