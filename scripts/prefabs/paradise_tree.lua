
local assets =
{
    Asset("ANIM", "anim/paradise_tree1.zip"), -- deciduous
}

local function RegisterToParadise(inst)
    if TheWorld.components.paradise ~= nil then
        TheWorld.components.paradise.paradise = inst
    end
end

local function MakeTree(id)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        -- inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeObstaclePhysics(inst, .4)

        if id == "2" then
            inst.MiniMapEntity:SetIcon("twiggy.png")
        else
            inst.MiniMapEntity:SetIcon("tree_leaf.png")

        end

        inst:AddTag("plant")
        inst:AddTag("tree")

        inst.AnimState:SetBank("paradise_tree"..id)
        inst.AnimState:SetBuild("paradise_tree"..id)
        inst.AnimState:PlayAnimation("idle")


        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        RegisterToParadise(inst)

        -- inst:ListenForEvent("PW_steponparadiseground", Update, TheWorld)

        -- inst.prevCamDist = 30
        -- inst.prevCamAngle = 45


        return inst
    end
    return Prefab("paradise_tree"..id, fn, assets)
end


return MakeTree("1")