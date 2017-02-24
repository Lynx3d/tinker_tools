local Dta = select(2, ...)

Dta.measurements_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS MeasurementsWINDOW
-------------------------------

local MeasurementsWindowSettings = {
	WIDTH = 315,
	HEIGHT = 190,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "MeasurementswindowPosX",
	POS_Y = "MeasurementswindowPosY"
}

function Dta.measurements_ui.buildWindow()
	local x = Dta.settings.get("MeasurementswindowPosX")
	local y = Dta.settings.get("MeasurementswindowPosY")
	local newWindow = Dta.ui.Window.Create("MeasurementsWindow",
								Dta.ui.context,
								Dta.Locale.Titles.OffsetCalc,
								MeasurementsWindowSettings.WIDTH,
								MeasurementsWindowSettings.HEIGHT,
								x,
								y,
								MeasurementsWindowSettings.CLOSABLE,
								MeasurementsWindowSettings.MOVABLE,
								Dta.measurements_ui.hideWindow,
								Dta.ui.WindowMoved
								)
	newWindow.settings = MeasurementsWindowSettings
	local Measurementswindow = newWindow.content

	Measurementswindow.background2 = UI.CreateFrame("Texture", "MeasurementsVindowBackground2", Measurementswindow)
	Measurementswindow.background2:SetPoint("BOTTOMCENTER", Measurementswindow, "BOTTOMCENTER")
	Measurementswindow.background2:SetWidth(MeasurementsWindowSettings.WIDTH)
	Measurementswindow.background2:SetHeight(80)
	Measurementswindow.background2:SetAlpha(0.3)
	Measurementswindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	Measurementswindow.background2:SetLayer(5)

	-------------------------------
	-- Offset Calc Inputs
	-------------------------------
	local measure = Dta.ui.createFrame("Measurements", Measurementswindow, 10, 5, Measurementswindow:GetWidth()-20, Measurementswindow:GetHeight()-20)
	measure:SetLayer(30)
	--Measurementswindow.modifyRotation:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	measure.TypeLabel = Dta.ui.createText("MeasurementsTypeLabel", measure, 0, 0, Dta.Locale.Text.Type, 14)
	measure.TypeLoad = Dta.ui.createDropdown("MeasurementsTypeLoad", measure, 90, 0, 180)
	measure.TypeLoad:SetItems(Dta.Locale.Menus.ItemType)
	measure.TypeLoad.Event.ItemSelect = Dta.measurements_ui.ShapeChanged

	measure.OrientationLabel = Dta.ui.createText("MeasurementsOrientationLabel", measure, 0, 25, Dta.Locale.Text.Orientation, 14)
	measure.OrientationLoad = Dta.ui.createDropdown("MeasurementsOrientationLoad", measure, 90, 25, 180)
	measure.OrientationLoad:SetItems(Dta.Locale.Menus.Orientation)
	measure.OrientationLoad.Event.ItemSelect = Dta.measurements_ui.OrientationChanged

	measure.SizeLabel = Dta.ui.createText("MeasurementsSizeLabel", measure, 0, 50, Dta.Locale.Text.Scale, 14)
	measure.Size = Dta.ui.createTextfield("MeasurementsSize", measure, 90, 50, 50)
	measure.SizeHint = Dta.ui.createText("MeasurementsSizeHint", measure, 150, 50, "", 14)

	measure.MultiLabel = Dta.ui.createText("MeasurementsMultiLabel", measure, 0, 75, Dta.Locale.Text.Multiplier, 14)
	measure.Multi = Dta.ui.createTextfield("MeasurementsMulti", measure, 90, 75, 50)

	measure.Calculate = Dta.ui.createButton("MeasurementsCalculate", measure, 0, 145, nil, nil, Dta.Locale.Buttons.Calculate, nil, Dta.measurements.CalculationsClicked)
	measure.Detect = Dta.ui.createButton("MeasurementsDetect", measure, 135, 145, nil, nil, Dta.Locale.Buttons.Detect, nil, Dta.measurements.DetectClicked)
	measure.TransferBtn = Dta.ui.Button.Create("MeasurementsTransfer",
		measure, Dta.measurements.TogglePopup,
		"DimensionWindow_I107.dds", "DimensionWindow_I109.dds",
		"DimensionWindow_I10B.dds", "DimensionWindow_I10D.dds")
	measure.TransferBtn:SetWidth(32)
	measure.TransferBtn:SetHeight(32)
	measure.TransferBtn:SetPoint("TOPLEFT", measure, "TOPLEFT", 275, 145)

	measure.Divider1 = Dta.ui.createTexture("MeasurementsDivider1", measure, "Rift", "divider_06.png.dds", 0, 100, measure:GetWidth())

	measure.xLabel = Dta.ui.createText("MeasurementsXLabel", measure, 0, 120, "X", 16, {1, 0, 0, 1})
	measure.yLabel = Dta.ui.createText("MeasurementsYLabel", measure, 100, 120, "Y", 16, {0, 1, 0, 1})
	measure.zLabel = Dta.ui.createText("MeasurementsZLabel", measure, 200, 120, "Z", 16, {0, 1, 1, 1})

	measure.x = Dta.ui.createText("MeasurementsX", measure, 25, 120, "-", 16)
	measure.y = Dta.ui.createText("MeasurementsY", measure, 125, 120, "-", 16)
	measure.z = Dta.ui.createText("MeasurementsZ", measure, 225, 120, "-", 16)

	-- "abuse" cycle function for clearing input focus on 'return' key
	Measurementswindow:EventAttach(Event.UI.Input.Key.Down.Dive, Dta.ui.FocusCycleCallback, "Measurementswindow_TabFocusCycle")

	-- TODO: temp fix for new window hierarchy
	newWindow.Measurements = measure
	newWindow.TransferPopup = Dta.measurements_ui.buildTransferPopup(Measurementswindow)
	newWindow.TransferPopup:ClearPoint("TOPLEFT")
	newWindow.TransferPopup:SetPoint("BOTTOMLEFT", Measurementswindow, "BOTTOMRIGHT", 10, 0)
	return newWindow
end

function Dta.measurements_ui.buildTransferPopup(parent)
	local popup = Dta.ui.Window.CreatePopup("Xfer popup", parent, 200, 180, 0, 0, false)
	popup:SetVisible(false)
	popup.Title = Dta.ui.createText("Xfer Title", popup, 20, 10, Dta.Locale.Titles.TransferValues , 16)
	popup.ToMove = Dta.ui.createCheckbox("ToMove", popup, 20, 40, Dta.Locale.Buttons.MoveWindow)
	popup.ToCopa = Dta.ui.createCheckbox("ToCopa", popup, 20, 65, Dta.Locale.Buttons.CopyPaste)
	popup.x = Dta.ui.createCheckbox("XferX", popup, 20, 90, "X", true, {1, 0, 0, 1})
	popup.y = Dta.ui.createCheckbox("XferY", popup, 60, 90, "Y", true, {0, 1, 0, 1})
	popup.z = Dta.ui.createCheckbox("XferZ", popup, 100, 90, "Z", true, {0, 1, 1, 1})
	popup.Invert = Dta.ui.createCheckbox("XferInvert", popup, 20, 115, Dta.Locale.Text.Invert)
	popup.Transfer = Dta.ui.createButton("Transfer", popup, 30, 140, nil, nil, Dta.Locale.Buttons.Transfer, nil, Dta.measurements.TransferClicked)
	return popup
end

function Dta.measurements_ui.OrientationChanged(self, entry, value, index)
	local Measurement_UI = Dta.Tools.Offset.window.Measurements
	if index == 7 then -- Selection Delta
		Measurement_UI.TypeLabel:SetAlpha(0.5)
		Measurement_UI.TypeLoad:SetEnabled(false)
		Measurement_UI.SizeLabel:SetAlpha(0.5)
		Measurement_UI.SizeHint:SetAlpha(0.5)
		--TODO: implement a Measurement_UI.Size:SetEnabled(false)
	else
		Measurement_UI.TypeLabel:SetAlpha(1)
		Measurement_UI.TypeLoad:SetEnabled(true)
		Measurement_UI.SizeLabel:SetAlpha(1)
		Measurement_UI.SizeHint:SetAlpha(1)
		--TODO: implement a Measurement_UI.Size:SetEnabled(true)
	end
end

function Dta.measurements_ui.ShapeChanged(self, entry, value, index)
	local Measurement_UI = Dta.Tools.Offset.window.Measurements
	if not index then
		Measurement_UI.SizeHint:SetText("")
	else
		local sizes = Dta.measurements.Dimensions[index]
		Measurement_UI.SizeHint:SetText(string.format("(%g ... %g)", sizes.minScale, sizes.maxScale))
	end
end

-- Show the toolbox window
function Dta.measurements_ui.showWindow(mm_window)
	mm_window:SetVisible(true)
	mm_window.Measurements.TypeLoad:SetEnabled(true)
	mm_window.Measurements.OrientationLoad:SetEnabled(true)
end

-- Hide the toolbox window
function Dta.measurements_ui.hideWindow(mm_window)
	mm_window:SetVisible(false)
	mm_window:ClearKeyFocus()
	-- workaround for dropdown not closing automatically
	mm_window.Measurements.TypeLoad:SetEnabled(false)
	mm_window.Measurements.OrientationLoad:SetEnabled(false)
end

Dta.RegisterTool("Offset", Dta.measurements_ui.buildWindow, Dta.measurements_ui.showWindow, Dta.measurements_ui.hideWindow)
