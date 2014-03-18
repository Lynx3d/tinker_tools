Dta.measurements_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS MeasurementsWINDOW
-------------------------------

function Dta.measurements_ui.createWindowMeasurements(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowMeasurements = UI.CreateFrame("Frame", name, parent)
		windowMeasurements:SetHeight(height)
		windowMeasurements:SetWidth(width)
		windowMeasurements:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowMeasurements:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowMeasurements:SetLayer(14)

  windowMeasurements.background = UI.CreateFrame("Texture", name .. "Background", windowMeasurements)
  windowMeasurements.background:SetPoint("TOPLEFT", windowMeasurements, "TOPLEFT", 0, 0)
  windowMeasurements.background:SetPoint("BOTTOMRIGHT", windowMeasurements, "TOPRIGHT", 0, height)
  windowMeasurements.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowMeasurements.background:SetLayer(3)

  local background2Position = windowMeasurements:GetHeight()-80
  windowMeasurements.background2 = UI.CreateFrame("Texture", name .. "Background2", windowMeasurements)
  windowMeasurements.background2:SetPoint("CENTERX", windowMeasurements, "CENTERX")
  windowMeasurements.background2:SetPoint("CENTERY", windowMeasurements, "CENTERY", nil, background2Position/2)
  windowMeasurements.background2:SetWidth(width)
  windowMeasurements.background2:SetHeight(95)
  windowMeasurements.background2:SetAlpha(0.3)
  windowMeasurements.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowMeasurements.background2:SetLayer(5)


  if closable then
    windowMeasurements.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowMeasurements, windowMeasurements:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowMeasurements.closeBtn:SetLayer(4)
  end

  if movable then
    windowMeasurements.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowMeasurements)
    windowMeasurements.moveFrame:SetPoint("TOPLEFT", windowMeasurements, "TOPLEFT", 0, -40)
    windowMeasurements.moveFrame:SetPoint("BOTTOMRIGHT", windowMeasurements, "TOPRIGHT", 0, 5)
    windowMeasurements.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowMeasurements.moveFrame:SetLayer(2)
    --windowMeasurements.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowMeasurements.header = UI.CreateFrame("Text", name .. "header", windowMeasurements.moveFrame)
    windowMeasurements.header:SetFontSize(20)
    windowMeasurements.header:SetText(title)
    windowMeasurements.header:SetFontColor(0,0,0,1)
    windowMeasurements.header:SetPoint("CENTERX", windowMeasurements.moveFrame, "CENTERX")
    windowMeasurements.header:SetPoint("CENTERY", windowMeasurements.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowMeasurements.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowMeasurements:GetLeft()
	    dragStartY = mouse.y - windowMeasurements:GetTop()
	end, "LMouseDown")

	windowMeasurements.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowMeasurements.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowMeasurements:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowMeasurements
  end
end

local MeasurementsWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.OffsetCalc,
  WIDTH = 315,
  HEIGHT = 200,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.measurements_ui.buildMeasurementsWindow()
  local x = Dta.settings.get("MeasurementswindowPosX")
  local y = Dta.settings.get("MeasurementswindowPosY")
  Measurementswindow = Dta.measurements_ui.createWindowMeasurements("MeasurementsWindow",
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

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                Measurementswindow.Measurements = Dta.ui.createFrame("Measurements", Measurementswindow, 10, 10, Measurementswindow:GetWidth()-20, Measurementswindow:GetHeight()-20)
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



  return Measurementswindow
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
  Dta.settings.set("MeasurementswindowPosX", Measurementswindow:GetLeft())
  Dta.settings.set("MeasurementswindowPosY", Measurementswindow:GetTop())
end
