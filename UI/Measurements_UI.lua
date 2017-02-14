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
	--ITEM DETAILS
	-------------------------------
	Measurementswindow.Measurements = Dta.ui.createFrame("Measurements", Measurementswindow, 10, 5, Measurementswindow:GetWidth()-20, Measurementswindow:GetHeight()-20)
	Measurementswindow.Measurements:SetLayer(30)
	--Measurementswindow.modifyRotation:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	Measurementswindow.Measurements.TypeLabel = Dta.ui.createText("MeasurementsTypeLabel", Measurementswindow.Measurements, 0, 0, Dta.Locale.Text.Type, 14)
	Measurementswindow.Measurements.TypeLoad = Dta.ui.createDropdown("MeasurementsTypeLoad", Measurementswindow.Measurements, 80, 0, 150)
	Measurementswindow.Measurements.TypeLoad:SetItems(Dta.Locale.Menus.ItemType)

	Measurementswindow.Measurements.OrientationLabel = Dta.ui.createText("MeasurementsOrientationLabel", Measurementswindow.Measurements, 0, 30, Dta.Locale.Text.Orientation, 14)
	Measurementswindow.Measurements.OrientationLoad = Dta.ui.createDropdown("MeasurementsOrientationLoad", Measurementswindow.Measurements, 80, 30, 150)
	Measurementswindow.Measurements.OrientationLoad:SetItems(Dta.Locale.Menus.Orientation)

	Measurementswindow.Measurements.SizeLabel = Dta.ui.createText("MeasurementsSizeLabel", Measurementswindow.Measurements, 0, 60, Dta.Locale.Text.Scale, 14)
	Measurementswindow.Measurements.Size = Dta.ui.createTextfield("MeasurementsSize", Measurementswindow.Measurements, 80, 60, 50)

	Measurementswindow.Measurements.Calculate = Dta.ui.createButton("MeasurementsCalculate", Measurementswindow.Measurements, 0, 145, nil, nil, Dta.Locale.Buttons.Calculate, nil, Dta.measurements.CalculationsClicked)
	Measurementswindow.Measurements.Detect = Dta.ui.createButton("MeasurementsDetect", Measurementswindow.Measurements, 135, 145, nil, nil, Dta.Locale.Buttons.Detect, nil, Dta.measurements.DetectClicked)
	Measurementswindow.Measurements.TransferBtn = Dta.ui.Button.Create("MeasurementsTransfer",
		Measurementswindow.Measurements, Dta.measurements.TogglePopup,
		"DimensionWindow_I107.dds", "DimensionWindow_I109.dds",
		"DimensionWindow_I10B.dds", "DimensionWindow_I10D.dds")
	Measurementswindow.Measurements.TransferBtn:SetWidth(32)
	Measurementswindow.Measurements.TransferBtn:SetHeight(32)
	Measurementswindow.Measurements.TransferBtn:SetPoint("TOPLEFT", Measurementswindow.Measurements, "TOPLEFT", 275, 145)

	Measurementswindow.Divider1 = Dta.ui.createTexture("MeasurementsDivider1", Measurementswindow, Dta.AddonID, "textures/divider.png", 20, 100, Measurementswindow:GetWidth()-40)
	Measurementswindow.Divider1:SetLayer(29)

	Measurementswindow.Measurements.xLabel = Dta.ui.createText("MeasurementsXLabel", Measurementswindow.Measurements, 0, 120, "X", 16, {1, 0, 0, 1})
	Measurementswindow.Measurements.yLabel = Dta.ui.createText("MeasurementsYLabel", Measurementswindow.Measurements, 100, 120, "Y", 16, {0, 1, 0, 1})
	Measurementswindow.Measurements.zLabel = Dta.ui.createText("MeasurementsZLabel", Measurementswindow.Measurements, 200, 120, "Z", 16, {0, 1, 1, 1})

	Measurementswindow.Measurements.x = Dta.ui.createText("MeasurementsX", Measurementswindow.Measurements, 25, 120, "-", 16)
	Measurementswindow.Measurements.y = Dta.ui.createText("MeasurementsY", Measurementswindow.Measurements, 125, 120, "-", 16)
	Measurementswindow.Measurements.z = Dta.ui.createText("MeasurementsZ", Measurementswindow.Measurements, 225, 120, "-", 16)

	-- "abuse" cycle function for clearing input focus on 'return' key
	Measurementswindow:EventAttach(Event.UI.Input.Key.Down.Dive, Dta.ui.FocusCycleCallback, "Measurementswindow_TabFocusCycle")

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
