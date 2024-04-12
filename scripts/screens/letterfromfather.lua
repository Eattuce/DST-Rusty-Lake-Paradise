local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"

local function CreateHintBox(widget, root, string, w)
    widget.line1hint = root:AddChild(Image("images/global.xml", "square.tex"))
    local width = 480
    if w then
        width = w
    end
    widget.line1hint:SetSize(width,60)
    widget.line1hint:SetTint(0, 0, 0, 0)
    widget.line1hint.OnMouseButton = function ()
        widget.cleartext:SetString(STRINGS.PARADISE_TEXTS.LETTER_FROM_FATHER[string])
    end
end

local LetterFromFather = Class(Screen, function(self, owner)
    self.owner = owner

    -- Register screen name
    Screen._ctor(self, "LetterFromFather")

    local black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    black.image:SetVRegPoint(ANCHOR_MIDDLE)
    black.image:SetHRegPoint(ANCHOR_MIDDLE)
    black.image:SetVAnchor(ANCHOR_MIDDLE)
    black.image:SetHAnchor(ANCHOR_MIDDLE)
    black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    black.image:SetTint(0,0,0,.5)
    black:SetOnClick(function() TheFrontEnd:PopScreen() end)

    local root = self:AddChild(Widget("ROOT"))
    root:SetVAnchor(ANCHOR_MIDDLE)
    root:SetHAnchor(ANCHOR_MIDDLE)
    root:SetPosition(20, 0, 0)
    root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    -- 展示清晰的文字
    self.cleartext = root:AddChild(Text(NEWFONT_OUTLINE, 40, STRINGS.PARADISE_TEXTS.HELP))
    self.cleartext:SetPosition(-450,200)

    -- 信纸
    local parchmentpaper = root:AddChild(Image("images/widgets/paper.xml", "paper.tex"))

    -- 文字内容
    local date = parchmentpaper:AddChild(Text(LETTERFONT_PARADISE, 50, "April 22, 1796", {0,0,0,1}))
    date:SetPosition(120, 250)
    CreateHintBox(self, date, "date", 200)


    local line1 = parchmentpaper:AddChild(Text(LETTERFONT_PARADISE, 50, "My dear son Jakob,", {0,0,0,1}))
    line1:SetPosition(0, 150)
    CreateHintBox(self, line1, "line1")

    local line2 = parchmentpaper:AddChild(Text(LETTERFONT_PARADISE, 50, "I'm sorry to inform you that", {0,0,0,1}))
    line2:SetPosition(0, 90)
    CreateHintBox(self, line2, "line2")

    local line3 = parchmentpaper:AddChild(Text(LETTERFONT_PARADISE, 50, "your mother passed away.", {0,0,0,1}))
    line3:SetPosition(0, 30)
    CreateHintBox(self, line3, "line3")

    local line4 = parchmentpaper:AddChild(Text(LETTERFONT_PARADISE, 50, "Please return to Paradise,", {0,0,0,1}))
    line4:SetPosition(0, -50)
    CreateHintBox(self, line4, "line4")

    local line5 = parchmentpaper:AddChild(Text(LETTERFONT_PARADISE, 50, "We need you here.", {0,0,0,1}))
    line5:SetPosition(0, -110)
    CreateHintBox(self, line5, "line5")

    local name = parchmentpaper:AddChild(Text(LETTERFONT_PARADISE, 50, "Your father.", {0,0,0,1}))
    name:SetPosition(0, -170)
    CreateHintBox(self, name, "name", 200)

    SetAutopaused(true)

end)

function LetterFromFather:OnDestroy()
    SetAutopaused(false)

    POPUPS.LETTERFROMFATHER:Close(self.owner)

	LetterFromFather._base.OnDestroy(self)
end

function LetterFromFather:OnBecomeInactive()
    LetterFromFather._base.OnBecomeInactive(self)
end

function LetterFromFather:OnBecomeActive()
    LetterFromFather._base.OnBecomeActive(self)
end

function LetterFromFather:OnControl(control, down)
    -- Sends clicks to the screen
    if LetterFromFather._base.OnControl(self, control, down) then return true end

    if not down and (control == CONTROL_MAP or control == CONTROL_CANCEL) then
		TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        TheFrontEnd:PopScreen()
        return true
    end

	return false
end

return LetterFromFather
