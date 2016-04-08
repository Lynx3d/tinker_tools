local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.measurements_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS MeasurementsWINDOW
-------------------------------

local MeasurementsWindowSettings = {
	WIDTH = 315,
	HEIGHT = 190,
	CLOSABLE = true,
	MOVABLE = true,
}

function Dta.measurements_ui.buildMeasurementsWindow()
	local x = Dta.settings.get("MeasurementswindowPosX")
	local y = Dta.settings.get("MeasurementswindowPosY")
	local newWindow = Dta.ui.Window.Create("MeasurementsWindow",
								Dta.ui.context,
								Lang[Dta.Language].Titles.OffsetCalc,
								MeasurementsWindowSettings.WIDTH,
								MeasurementsWindowSettings.HEIGHT,
								x,
								y,
								MeasurementsWindowSettings.CLOSABLE,
								MeasurementsWindowSettings.MOVABLE,
								Dta.measurements_ui.MeasurementsWindowClosed,
								Dta.measurements_ui.MeasurementsWindowMoved
								)
	local Measurementswindow = newWindow.content

	Measurementswindow.background2 = UI.CreateFrame("Texture", "MeasurementsVindowBackground2", Measurementswindow)
	Measurementswindow.background2:SetPoint("BOTTOMCENTER", Measurementswindow, "BOTTOMCENTER")
	Measurementswindow.background2:SetWidth(MeasurementsWindowSettings.WIDTH)
	Measurementswindow.background2:SetHeight(80)
	Measurementswindow.background2:SetAlpha(0.3)
	Measurementswindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	Measurementswindow.background2:SetLayer(5)

	-------------------------------
	--ITEM DETAILS
	-------------------------------
	Measurementswindow.Measurements = Dta.ui.createFrame("Measurements", Measurementswindow, 10, 5, Measurementswindow:GetWidth()-20, Measurementswindow:GetHeight()-20)
	Measurementswindow.Measurements:SetLayer(30)
	--Measurementswindow.modifyRotation:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	Measurementswindow.Measurements.TypeLabel = Dta.ui.createText("MeasurementsTypeLabel", Measurementswindow.Measurements, 0, 0, Lang[Dta.Language].Text.Type, 14)
	Measurementswindow.Measurements.TypeLoad = UI.CreateFrame("SimpleSelect", "MeasurementsTypeLoad", Measurementswindow.Measurements)
	Measurementswindow.Measurements.TypeLoad:SetPoint("TOPLEFT", Measurementswindow.Measurements, "TOPLEFT", 80, 0)
	Measurementswindow.Measurements.TypeLoad:SetLayer(100)
	Measurementswindow.Measurements.TypeLoad:SetItems(Lang[Dta.Language].Menus.ItemType)
	--Measurementswindow.Measurements.TypeLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end
	Measurementswindow.Measurements.TypeLoad:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	Measurementswindow.Measurements.TypeLoad:SetWidth(150)
	Measurementswindow.Measurements.TypeLoad:SetEnabled(true)

	Measurementswindow.Measurements.OrientationLabel = Dta.ui.createText("MeasurementsOrientationLabel", Measurementswindow.Measurements, 0, 30, Lang[Dta.Language].Text.Orientation, 14)
	Measurementswindow.Measurements.OrientationLoad = UI.CreateFrame("SimpleSelect", "MeasurementsOrientationLoad", Measurementswindow.Measurements)
	Measurementswindow.Measurements.OrientationLoad:SetPoint("TOPLEFT", Measurementswindow.Measurements, "TOPLEFT", 80, 30)
	Measurementswindow.Measurements.OrientationLoad:SetLayer(100)
	Measurementswindow.Measurements.OrientationLoad:SetItems(Lang[Dta.Language].Menus.Orientation)
	--Measurementswindow.Measurements.OrientationLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end
	Measurementswindow.Measurements.OrientationLoad:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	Measurementswindow.Measurements.OrientationLoad:SetWidth(150)
	Measurementswindow.Measurements.OrientationLoad:SetEnabled(true)

	Measurementswindow.Measurements.SizeLabel = Dta.ui.createText("MeasurementsSizeLabel", Measurementswindow.Measurements, 0, 60, Lang[Dta.Language].Text.Scale, 14)
	Measurementswindow.Measurements.Size = Dta.ui.createTextfield("MeasurementsSize", Measurementswindow.Measurements, 80, 60, 50)

	Measurementswindow.Measurements.Calculate = Dta.ui.createButton("MeasurementsCalculate", Measurementswindow.Measurements, 0, 145, nil, nil, Lang[Dta.Language].Buttons.Calculate, nil, Dta.measurements.CalculationsClicked)
	Measurementswindow.Measurements.Detect = Dta.ui.createButton("MeasurementsDetect", Measurementswindow.Measurements, 135, 145, nil, nil, Lang[Dta.Language].Buttons.Detect, nil, Dta.measurements.DetectClicked)
	Measurementswindow.Measurements.TransferBtn = Dta.ui.Button.Create("MeasurementsTransfer",
		Measurementswindow.Measurements, Dta.measurements.TogglePopup,
		"DimensionWindow_I107.dds", "DimensionWindow_I109.dds",
		"DimensionWindow_I10B.dds", "DimensionWindow_I10D.dds")
	Measurementswindow.Measurements.TransferBtn:SetWidth(32)
	Measurementswindow.Measurements.TransferBtn:SetHeight(32)
	Measurementswindow.Measurements.TransferBtn:SetPoint("TOPLEFT", Measurementswindow.Measurements, "TOPLEFT", 275, 145)

	Measurementswindow.Divider1 = Dta.ui.createTexture("MeasurementsDivider1", Measurementswindow, "Dimtools", "textures/divider.png", 20, 100, Measurementswindow:GetWidth()-40)
	Measurementswindow.Divider1:SetLayer(29)

	Measurementswindow.Measurements.xLabel = Dta.ui.createText("MeasurementsXLabel", Measurementswindow.Measurements, 0, 120, "X", 16, {1, 0, 0, 1})
	Measurementswindow.Measurements.yLabel = Dta.ui.createText("MeasurementsYLabel", Measurementswindow.Measurements, 100, 120, "Y", 16, {0, 1, 0, 1})
	Measurementswindow.Measurements.zLabel = Dta.ui.createText("MeasurementsZLabel", Measurementswindow.Measurements, 200, 120, "Z", 16, {0, 1, 1, 1})

	Measurementswindow.Measurements.x = Dta.ui.createText("MeasurementsX", Measurementswindow.Measurements, 25, 120, "-", 16)
	Measurementswindow.Measurements.y = Dta.ui.createText("MeasurementsY", Measurementswindow.Measurements, 125, 120, "-", 16)
	Measurementswindow.Measurements.z = Dta.ui.createText("MeasurementsZ", Measurementswindow.Measurements, 225, 120, "-", 16)

	-- TODO: temp fix for new window hierarchy
	newWindow.Measurements = Measurementswindow.Measurements
	newWindow.TransferPopup = Dta.measurements_ui.buildTransferPopup(Measurementswindow)
	newWindow.TransferPopup:ClearPoint("TOPLEFT")
	newWindow.TransferPopup:SetPoint("BOTTOMLEFT", Measurementswindow, "BOTTOMRIGHT", 10, 0)
	return newWindow
end

function Dta.measurements_ui.buildTransferPopup(parent)
	local popup = Dta.ui.Window.CreatePopup("Xfer popup", parent, 200, 180, 0, 0, false)
	popup:SetVisible(false)
	popup.Title = Dta.ui.createText("Xfer Title", popup, 20, 10, Lang[Dta.Language].Titles.TransferValues , 16)
	popup.ToMove = Dta.ui.createCheckbox("ToMove", popup, 20, 40, Lang[Dta.Language].Buttons.MoveWindow)
	popup.ToCopa = Dta.ui.createCheckbox("ToCopa", popup, 20, 65, Lang[Dta.Language].Buttons.CopyPaste)
	popup.x = Dta.ui.createCheckbox("XferX", popup, 20, 90, "X", true, {1, 0, 0, 1})
	popup.y = Dta.ui.createCheckbox("XferY", popup, 60, 90, "Y", true, {0, 1, 0, 1})
	popup.z = Dta.ui.createCheckbox("XferZ", popup, 100, 90, "Z", true, {0, 1, 1, 1})
	popup.Invert = Dta.ui.createCheckbox("XferInvert", popup, 20, 115, Lang[Dta.Language].Text.Invert)
	popup.Transfer = Dta.ui.createButton("Transfer", popup, 30, 140, nil, nil, Lang[Dta.Language].Buttons.Transfer, nil, Dta.measurements.TransferClicked)
	return popup
end
-- Show the toolbox window
function Dta.measurements_ui.showMeasurementsWindow()
	if Dta.ui.windowMeasurements == nil then
		Dta.ui.windowMeasurements = Dta.measurements_ui.buildMeasurementsWindow()
	else
		Dta.ui.windowMeasurements:SetVisible(true)
		Dta.ui.windowMeasurements.Measurements.TypeLoad:SetEnabled(true)
		Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetEnabled(true)
	end
	Dta.ui.activeMeasurements = true
end

-- Hide the toolbox window
function Dta.measurements_ui.hideMeasurementsWindow()
	Dta.ui.windowMeasurements:SetVisible(false)
	Dta.ui.windowMeasurements:ClearKeyFocus()
	-- workaround for dropdown not closing automatically
	Dta.ui.windowMeasurements.Measurements.TypeLoad:SetEnabled(false)
	Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetEnabled(false)
--	Dta.ui.windowMeasurements = nil
	Dta.ui.activeMeasurements = false
end

-- Toggle the toolbox window
function Dta.measurements_ui.toggleMeasurementsWindow()
	if Dta.ui.activeMeasurements then Dta.measurements_ui.hideMeasurementsWindow()
	else Dta.measurements_ui.showMeasurementsWindow() end
end

--Called when the window has been closed
function Dta.measurements_ui.MeasurementsWindowClosed()
	Dta.measurements_ui.hideMeasurementsWindow()
end

--Called when the window has been moved
function Dta.measurements_ui.MeasurementsWindowMoved()
	Dta.settings.set("MeasurementswindowPosX", Dta.ui.windowMeasurements:GetLeft())
	Dta.settings.set("MeasurementswindowPosY", Dta.ui.windowMeasurements:GetTop())
end
