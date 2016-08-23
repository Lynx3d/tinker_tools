local Dta = select(2, ...)

Dta.flying_ui = {}

local FlyingWindowSettings = {
	WIDTH = 300,
	HEIGHT = 265,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "FlyingwindowPosX",
	POS_Y = "FlyingwindowPosY"
}

function Dta.flying_ui.buildFlyingWindow()
	local x = Dta.settings.get("FlyingwindowPosX")
	local y = Dta.settings.get("FlyingwindowPosY")
	local newWindow = Dta.ui.Window.Create("FlyingWindow",
							Dta.ui.context,
							Dta.Locale.Titles.TribalMagic,
							FlyingWindowSettings.WIDTH,
							FlyingWindowSettings.HEIGHT,
							x,
							y,
							FlyingWindowSettings.CLOSABLE,
							FlyingWindowSettings.MOVABLE,
							Dta.flying_ui.FlyingWindowClosed,
							Dta.ui.WindowMoved
							)
	newWindow.settings = FlyingWindowSettings
	local Flyingwindow = newWindow.content

	Flyingwindow.background2 = UI.CreateFrame("Texture", "FlyingwindowBackground2", Flyingwindow)
	Flyingwindow.background2:SetPoint("BOTTOMCENTER", Flyingwindow, "BOTTOMCENTER")
	Flyingwindow.background2:SetWidth(FlyingWindowSettings.WIDTH)
	Flyingwindow.background2:SetHeight(80)
	Flyingwindow.background2:SetAlpha(0.3)
	Flyingwindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	Flyingwindow.background2:SetLayer(5)

	-------------------------------
	--ITEM DETAILS
	-------------------------------
	Flyingwindow.DFlying = Dta.ui.createFrame("ImportExport", Flyingwindow, 10, 5, Flyingwindow:GetWidth()-20, Flyingwindow:GetHeight()-20)
	Flyingwindow.DFlying:SetLayer(30)
	--Flyingwindow.DFlying:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	Flyingwindow.DFlying.placeButton = Dta.ui.createButton("DFlyingPlaceBtn", Flyingwindow.DFlying, 0, 95, nil, nil, Dta.Locale.Buttons.Place, nil, Dta.flying.PlaceFlying)
	Flyingwindow.DFlying.placeButton:SetLayer(100)
	if Dta.carpetId then
		Flyingwindow.DFlying.placeButton:SetEnabled(false)
	else
		Flyingwindow.DFlying.placeButton:SetEnabled(true)
	end

	Flyingwindow.DFlying.pickupButton = Dta.ui.createButton("DFlyingPickUpBtn", Flyingwindow.DFlying, 0, 125, nil, nil, Dta.Locale.Buttons.PickUp, nil, Dta.flying.PickUpFlying)
	Flyingwindow.DFlying.pickupButton:SetLayer(100)
	if Dta.carpetId then
		Flyingwindow.DFlying.pickupButton:SetEnabled(true)
	else
		Flyingwindow.DFlying.pickupButton:SetEnabled(false)
	end

	for i = 1, 9, 1 do
		Dta.pitchButtons[i] = UI.CreateFrame("RiftButton", "PitchButton"..i, Flyingwindow.DFlying)
		Dta.pitchButtons[i]:SetPoint("TOPLEFT", Flyingwindow.DFlying, "TOPLEFT", 140, 0 + ((i-1)*27))
		local labelText = tostring(5-i)
		if 5-i > 0 then
			labelText = "+"..labelText
		end
		Dta.pitchButtons[i]:SetText(labelText)
		Dta.pitchButtons[i]:SetLayer(100)
		if i == 5 then
			Dta.pitchButtons[i]:SetEnabled(false)
		end
	end

	for i = 1, 9, 1 do
		Dta.pitchButtons[i].Event.LeftPress = function() Dta.flying.AdjustPitch(i) end
	end

	-- TODO: temp fix for new window hierarchy
	newWindow.DFlying = Flyingwindow.DFlying

	return newWindow
end

-- Show the toolbox window
function Dta.flying_ui.showFlyingWindow()
	if Dta.ui.windowFlying == nil then
		Dta.ui.windowFlying = Dta.flying_ui.buildFlyingWindow()
	else
		Dta.ui.windowFlying:SetVisible(true)
	end
	Dta.ui.activeFlying = true
end

-- Hide the toolbox window
function Dta.flying_ui.hideFlyingWindow()
	Dta.ui.windowFlying:SetVisible(false)
--	Dta.ui.windowFlying = nil
	Dta.ui.activeFlying = false
end

-- Toggle the toolbox window
function Dta.flying_ui.toggleFlyingWindow()
	if Dta.ui.activeFlying then Dta.flying_ui.hideFlyingWindow()
	else Dta.flying_ui.showFlyingWindow() end
end

--Called when the window has been closed
function Dta.flying_ui.FlyingWindowClosed()
	Dta.flying_ui.hideFlyingWindow()
end
