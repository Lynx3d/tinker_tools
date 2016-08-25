local Dta = select(2, ...)

Dta.flying_ui = {}

local FlyingWindowSettings = {
	WIDTH = 300,
	HEIGHT = 100,
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
	local DFlying = Dta.ui.createFrame("ImportExport", Flyingwindow, 10, 5, Flyingwindow:GetWidth()-20, Flyingwindow:GetHeight()-20)
	DFlying:SetLayer(30)

	DFlying.placeButton = Dta.ui.createButton("DFlyingPlaceBtn", DFlying, 0, 55, nil, nil, Dta.Locale.Buttons.Place, nil, Dta.flying.PlaceFlying)
	DFlying.placeButton:SetLayer(100)
	if Dta.carpetId then
		DFlying.placeButton:SetEnabled(false)
	else
		DFlying.placeButton:SetEnabled(true)
	end

	DFlying.pickupButton = Dta.ui.createButton("DFlyingPickUpBtn", DFlying, 140, 55, nil, nil, Dta.Locale.Buttons.PickUp, nil, Dta.flying.PickUpFlying)
	DFlying.pickupButton:SetLayer(100)
	if Dta.carpetId then
		DFlying.pickupButton:SetEnabled(true)
	else
		DFlying.pickupButton:SetEnabled(false)
	end

	DFlying.pitchSlider = UI.CreateFrame("RiftSlider", "FlyingwindowSlider", DFlying)
	DFlying.pitchSlider:SetPoint("TOPLEFT", DFlying, "TOPLEFT", 20, 5)
	DFlying.pitchSlider:SetWidth(240)
	DFlying.pitchSlider:SetHeight(40)
	DFlying.pitchSlider:SetRange(-4, 4)
	DFlying.pitchSlider:SetPosition(0)
	DFlying.pitchSlider:EventAttach(Event.UI.Input.Mouse.Wheel.Back, Dta.flying.PitchWheelBack, "PitchWheelBack")
	DFlying.pitchSlider:EventAttach(Event.UI.Input.Mouse.Wheel.Forward, Dta.flying.PitchWheelForward, "PitchWheelForward")
	DFlying.pitchSlider:EventAttach(Event.UI.Slider.Change, Dta.flying.SliderMoved, "PitchChanged")
	Dta.flying.pitchPosition = 0

	local labels = {}
	for i = 1, 9 do
		local labelText = tostring(i-5)
		if i-5 > 0 then
			labelText = "+"..labelText
		end
		local label = Dta.ui.createText("PitchLabel"..i, DFlying, nil, nil, labelText, 14)
		label:SetPoint("BOTTOMCENTER", DFlying.pitchSlider, "BOTTOMLEFT", (i-1)*30, 0)
		labels[i] = label
	end
	labels[5]:SetFontColor(107/255, 203/255, 189/255)
	newWindow.pitchLabels = labels

	-- TODO: temp fix for new window hierarchy
	newWindow.DFlying = DFlying

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
