Dta.measurements_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS MeasurementsWINDOW
-------------------------------

local MeasurementsWindowSettings = {
	TITLE = Lang[Dta.Language].Titles.OffsetCalc,
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
								MeasurementsWindowSettings.TITLE,
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
	Measurementswindow.Measurements.TypeLoad:SetItems(Dta.measurements.TypeIndex)
	--Measurementswindow.Measurements.TypeLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end
	Measurementswindow.Measurements.TypeLoad:ResizeToFit()
	Measurementswindow.Measurements.TypeLoad:SetWidth(150)
	Measurementswindow.Measurements.TypeLoad:SetEnabled(true)

	Measurementswindow.Measurements.OrientationLabel = Dta.ui.createText("MeasurementsOrientationLabel", Measurementswindow.Measurements, 0, 30, Lang[Dta.Language].Text.Orientation, 14)
	Measurementswindow.Measurements.OrientationLoad = UI.CreateFrame("SimpleSelect", "MeasurementsOrientationLoad", Measurementswindow.Measurements)
	Measurementswindow.Measurements.OrientationLoad:SetPoint("TOPLEFT", Measurementswindow.Measurements, "TOPLEFT", 80, 30)
	Measurementswindow.Measurements.OrientationLoad:SetLayer(100)
	Measurementswindow.Measurements.OrientationLoad:SetItems(Dta.measurements.OrientationIndex)
	--Measurementswindow.Measurements.OrientationLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end
	Measurementswindow.Measurements.OrientationLoad:ResizeToFit()
	Measurementswindow.Measurements.OrientationLoad:SetWidth(150)
	Measurementswindow.Measurements.OrientationLoad:SetEnabled(true)

	Measurementswindow.Measurements.SizeLabel = Dta.ui.createText("MeasurementsSizeLabel", Measurementswindow.Measurements, 0, 60, Lang[Dta.Language].Text.Scale, 14)
	Measurementswindow.Measurements.Size = Dta.ui.createTextfield("MeasurementsSize", Measurementswindow.Measurements, 80, 60, 50)

	Measurementswindow.Measurements.Calculate = Dta.ui.createButton("MeasurementsCalculate", Measurementswindow.Measurements, 165, 55, nil, nil, Lang[Dta.Language].Buttons.Calculate, nil, Dta.measurements.CalculationsClicked)

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
	return newWindow
end

-- Show the toolbox window
function Dta.measurements_ui.showMeasurementsWindow()
	if Dta.ui.windowMeasurements == nil then
		Dta.ui.windowMeasurements = Dta.measurements_ui.buildMeasurementsWindow()
	else
		Dta.measurements_ui.windowMeasurements:SetVisible(true)
	end
	Dta.ui.activeMeasurements = true
end

-- Hide the toolbox window
function Dta.measurements_ui.hideMeasurementsWindow()
	Dta.ui.windowMeasurements:SetVisible(false)
	Dta.ui.windowMeasurements.Measurements.TypeLoad:SetEnabled(false)
	Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetEnabled(false)
	Dta.ui.windowMeasurements = nil
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
