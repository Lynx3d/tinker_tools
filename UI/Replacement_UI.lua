local Dta = select(2, ...)

local ReskinWindowSettings = {
	WIDTH = 315,
	HEIGHT = 200,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "ReskinwindowPosX",
	POS_Y = "ReskinwindowPosY"
}

function Dta.ui.buildReskinWindow()
	local Lang = Dta.Lang[Dta.Language]
	local x = Dta.settings.get("ReskinwindowPosX")
	local y = Dta.settings.get("ReskinwindowPosY")

	local newWindow = Dta.ui.Window.Create("ReskinWindow",
							Dta.ui.context,
							Lang.Titles.Reskin,
							ReskinWindowSettings.WIDTH,
							ReskinWindowSettings.HEIGHT,
							x, y,
							ReskinWindowSettings.CLOSABLE,
							ReskinWindowSettings.MOVABLE,
							Dta.ui.hideReskinWindow,
							Dta.ui.WindowMoved
							)
	local reskinWindow = newWindow.content
	newWindow.settings = ReskinWindowSettings

	newWindow.oldSkinLabel = Dta.ui.createText("OldSkinLabel", reskinWindow, 10, 5, Lang.Text.OldSkin, 14)
	newWindow.oldSkinSelect = UI.CreateFrame("SimpleSelect", "OldSkinSelect", reskinWindow)
	newWindow.oldSkinSelect:SetPoint("TOPLEFT", reskinWindow, "TOPLEFT", 120, 5)
	newWindow.oldSkinSelect:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	newWindow.oldSkinSelect:SetWidth(180)
	newWindow.oldSkinSelect:SetItems(Dta.Replacement.loadSkins())

	newWindow.newSkinLabel = Dta.ui.createText("NewSkinLabel", reskinWindow, 10, 30, Lang.Text.NewSkin, 14)
	newWindow.newSkinSelect = UI.CreateFrame("SimpleSelect", "NewSkinSelect", reskinWindow)
	newWindow.newSkinSelect:SetPoint("TOPLEFT", reskinWindow, "TOPLEFT", 120, 30)
	newWindow.newSkinSelect:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	newWindow.newSkinSelect:SetWidth(180)
	newWindow.newSkinSelect:SetItems(Dta.Replacement.loadSkins())

	newWindow.tile = Dta.ui.createCheckbox("replaceTiles", reskinWindow, 20, 60, Lang.Text.Tile, true)
	newWindow.rectangle = Dta.ui.createCheckbox("replaceRectangle", reskinWindow, 20, 85, Lang.Text.Rectangle, true)
	newWindow.triangle = Dta.ui.createCheckbox("replaceTriangles", reskinWindow, 20, 110, Lang.Text.Triangle, true)
	newWindow.plank = Dta.ui.createCheckbox("replacePlanks", reskinWindow, 20, 135, Lang.Text.Plank, true)
	--
	newWindow.cube = Dta.ui.createCheckbox("replaceCubes", reskinWindow, 155, 60, Lang.Text.Cube, true)
	newWindow.sphere = Dta.ui.createCheckbox("replaceSpheres", reskinWindow, 155, 85, Lang.Text.Sphere, true)
	newWindow.pole = Dta.ui.createCheckbox("replacePoles", reskinWindow, 155, 110, Lang.Text.Pole, true)
	newWindow.disc = Dta.ui.createCheckbox("replaceDiscs", reskinWindow, 155, 135, Lang.Text.Disc, true)


	newWindow.replaceBtn = Dta.ui.createButton("SkinReplace", reskinWindow, 100, 160, nil, nil, Lang.Buttons.Apply, nil, Dta.Replacement.ReplaceClicked)
	return newWindow
end

-- Show the reskin window
function Dta.ui.showReskinWindow()
	if Dta.ui.windowReskin == nil then
		Dta.ui.windowReskin = Dta.ui.buildReskinWindow()
	else
		Dta.ui.windowReskin:SetVisible(true)
		Dta.ui.windowReskin.oldSkinSelect:SetEnabled(true)
		Dta.ui.windowReskin.newSkinSelect:SetEnabled(true)
	end
	Dta.ui.activeReskin = true
end

-- Hide the reskin window
function Dta.ui.hideReskinWindow()
	Dta.ui.windowReskin:SetVisible(false)
	Dta.ui.windowReskin:ClearKeyFocus()
	-- workaround for dropdown not closing automatically
	Dta.ui.windowReskin.oldSkinSelect:SetEnabled(false)
	Dta.ui.windowReskin.newSkinSelect:SetEnabled(false)
	Dta.ui.activeReskin = false
end

-- Toggle the reskin window
function Dta.ui.toggleReskinWindow()
	if Dta.ui.activeReskin then Dta.ui.hideReskinWindow()
	else Dta.ui.showReskinWindow() end
end
