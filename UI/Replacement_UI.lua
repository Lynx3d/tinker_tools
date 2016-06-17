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
	local Locale = Dta.Locale
	local x = Dta.settings.get("ReskinwindowPosX")
	local y = Dta.settings.get("ReskinwindowPosY")

	local newWindow = Dta.ui.Window.Create("ReskinWindow",
							Dta.ui.context,
							Locale.Titles.Reskin,
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

	newWindow.oldSkinLabel = Dta.ui.createText("OldSkinLabel", reskinWindow, 10, 5, Locale.Text.OldSkin, 14)
	newWindow.oldSkinSelect = Dta.ui.createDropdown("OldSkinSelect", reskinWindow, 120, 5, 180)
	newWindow.oldSkinSelect:SetItems(Dta.Replacement.loadSkins())

	newWindow.newSkinLabel = Dta.ui.createText("NewSkinLabel", reskinWindow, 10, 30, Locale.Text.NewSkin, 14)
	newWindow.newSkinSelect = Dta.ui.createDropdown("NewSkinSelect", reskinWindow, 120, 30, 180)
	newWindow.newSkinSelect:SetItems(Dta.Replacement.loadSkins())

	newWindow.tile = Dta.ui.createCheckbox("replaceTiles", reskinWindow, 20, 60, Locale.Text.Tile, true)
	newWindow.rectangle = Dta.ui.createCheckbox("replaceRectangle", reskinWindow, 20, 85, Locale.Text.Rectangle, true)
	newWindow.triangle = Dta.ui.createCheckbox("replaceTriangles", reskinWindow, 20, 110, Locale.Text.Triangle, true)
	newWindow.plank = Dta.ui.createCheckbox("replacePlanks", reskinWindow, 20, 135, Locale.Text.Plank, true)
	--
	newWindow.cube = Dta.ui.createCheckbox("replaceCubes", reskinWindow, 155, 60, Locale.Text.Cube, true)
	newWindow.sphere = Dta.ui.createCheckbox("replaceSpheres", reskinWindow, 155, 85, Locale.Text.Sphere, true)
	newWindow.pole = Dta.ui.createCheckbox("replacePoles", reskinWindow, 155, 110, Locale.Text.Pole, true)
	newWindow.disc = Dta.ui.createCheckbox("replaceDiscs", reskinWindow, 155, 135, Locale.Text.Disc, true)


	newWindow.replaceBtn = Dta.ui.createButton("SkinReplace", reskinWindow, 100, 160, nil, nil, Locale.Buttons.Apply, nil, Dta.Replacement.ReplaceClicked)
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
