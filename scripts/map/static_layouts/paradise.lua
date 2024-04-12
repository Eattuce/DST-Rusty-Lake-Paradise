

local cx = 1
local cy = 1
local camx = cx
local camy = cx-64

local function tree(ptx,pty)
  return {name = "",type = "evergreen",shape = "rectangle",x = ptx,y = pty,width = 0,height = 0,visible = true,properties = {}}
end
local function sign(ptx,pty,p)
  local endstring=p or "" return {name="",type="locationsign",shape="rectangle",x=ptx,y=pty,width= 0,height=0,visible = true,properties={["data.setepitaph"]=ptx.."_"..pty..endstring}
}
end
local function fence(ptx, pty)
  return {name = "", type = "paradise_fence", shape = "rectangle", x = ptx, y = pty, width = 0, height = 0, visible = true, properties = {}}
end
local function collider(ptx, pty)
  return {name = "", type = "paradise_door_collider", shape = "rectangle", x = ptx, y = pty, width = 0, height = 0, visible = true, properties = {}}
end
local function blood(ptx, pty)
  return {name = "", type = "oceanblood",shape="rectangle",x=ptx,y=pty,width=0,height=0,visible=true, properties={}}
end

local layout = {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 20,
  height = 20,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      filename = "../../../../tools/tiled/dont_starve/ground.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../../../../tools/tiled/dont_starve/tiles.png",
      imagewidth = 512,
      imageheight = 384,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "BG_TILES",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,18,18,18,18,18,18,18,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,0 ,18,18,18,17,17,17,17,17,17,17,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,18,18,17,17,17,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,18,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,18,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,18,17,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,18,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,18,17,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,0 ,
        0 ,18,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,0 ,
        0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,
        0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,
        0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,0 ,0 ,0 ,0 ,
        0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,0 ,0 ,0 ,0 ,
        0 ,18,17,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,0 ,0 ,0 ,0 ,
        0 ,18,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,
        0 ,0 ,18,17,17,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,18,0 ,0 ,0 ,0 ,
        0 ,0 ,18,18,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,18,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,18,17,17,17,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,7 ,17,17,17,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,18,18,18,17,7 ,7 ,7 ,7 ,7 ,7 ,2 ,7 ,7 ,7 ,7 ,7 ,17,18,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,18,17,17,7 ,7 ,7 ,7 ,7 ,2 ,7 ,7 ,7 ,7 ,17,17,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,18,18,18,17,7 ,7 ,7 ,7 ,2 ,7 ,7 ,7 ,17,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,0 ,0 ,18,17,17,17,17,17,17,17,17,17,17,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,0 ,0 ,18,18,18,18,18,18,18,18,18,18,18,18,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,
        0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,

        }
    },
    {
      type = "objectgroup",
      name = "FG_OBJECTS",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "paradisecamerahelper_center",
          shape = "rectangle",
          x = 720,
          y = 720,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        sign(192,1472,"David"),
-----------------------------------------------------------
        {
          name = "",
          type = "treasurechest", -- 初始箱子
          shape = "rectangle",
          x = 736,
          y = 1472+32,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["scenario"] = "chest_paradise_arrival_boat"
          }
        },
        {
          name = "",
          type = "boat", -- 初始船
          shape = "rectangle",
          x = 768,
          y = 1472+32,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "hammer", -- 船上有把锤子
          shape = "rectangle",
          x = 768,
          y = 1472+64,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },

-----------------------------------------------------------
        {
          name = "",
          type = "boat", -- 弟弟David所在船
          shape = "rectangle",
          x = 192,
          y = 1472+10,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "twiggy_tall", -- 多枝树
          shape = "rectangle",
          x = 288,
          y = 1344,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pumpkin_oversized_waxed", -- 南瓜
          shape = "rectangle",
          x = 416,
          y = 1408-32,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "paradise_gatetree", -- 门右边大树
          shape = "rectangle",
          x = 704,
          y = 1312,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
-----------------------------------------------------------
        {
          name = "",
          type = "paradisecamerahelper", -- camera
          shape = "rectangle",
          x = 720,
          y = 600,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },

        {
          name = "",
          type = "paradise_gate", -- 大门
          shape = "rectangle",
          x = 552,
          y = 1280,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "paradise_doors", -- men
          shape = "rectangle",
          x = 552,
          y = 1280+1,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },

      }
    }
  }
}


-- 门边围墙
for i=760, 584, -16 do
  table.insert(layout.layers[2].objects, fence(i,1280))
end
for i=520, 248, -16 do
  table.insert(layout.layers[2].objects, fence(i,1280))
end
-----------------------------------------------------------
-- 门碰撞
for i=568, 536, -16 do
  table.insert(layout.layers[2].objects, collider(i,1280-1))
end
-----------------------------------------------------------
-- Test
for signx=-192+32, 1216, 64 do
  for signy=-192+32, 1344, 64 do
    table.insert(layout.layers[2].objects, sign(signx,signy))
  end
end
-----------------------------------------------------------
-- 血红色
local mat=
{
  {864,1248},{992,1120},{1056,992},{1120,864},{1184,800},{1184,672},{1120,608},
  {1056,480},{1056,352},{992,288},{992,224},{928,160},{928,96},{864,32},
  {800,-32},{736,-96},{672,-160},{544,-160},{288,-96},{160,-32},{96,96},
  {96,224},{32,352},{-32,480},{-96,544},{-96,672},{-32,800},{32,864},{352,-160},
  {96,992},{32,1120},{160,1184},{160,1248},{256,1360},{384,1360},{512,1360},{640,1360},{768,1360}
}
for _,v in pairs(mat) do
  table.insert(layout.layers[2].objects, blood(v[1],v[2]))
end


return layout