local assets =
{
    Asset("ANIM", "anim/paradise_coffin.zip"),
}

local prefabs =
{

}


local PHYSICS_RADIUS = .75

local function OnHammered(inst, worker)
    inst.AnimState:PlayAnimation("nail_"..inst.components.workable.workleft)
    inst.AnimState:PushAnimation("idle_"..inst.components.workable.workleft)
end

local function OnWorked(inst, worker)
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("singingshell_cluster")
    inst.AnimState:SetBuild("singingshell_cluster")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("heavy")

	MakeHeavyObstaclePhysics(inst, PHYSICS_RADIUS)
	inst:SetPhysicsRadiusOverride(PHYSICS_RADIUS)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

	inst:AddComponent("heavyobstaclephysics")
	inst.components.heavyobstaclephysics:SetRadius(PHYSICS_RADIUS)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(11)
    inst.components.workable:SetOnWorkCallback(nil)
	inst.components.workable:SetOnFinishCallback(OnWorked)

	inst:AddComponent("submersible")
	inst:AddComponent("symbolswapdata")
	inst.components.symbolswapdata:SetData("singingshell_cluster", "swap_body")
                                        --     Build                 Symbol

    return inst
end

return Prefab("shell_cluster", fn, assets, prefabs)
