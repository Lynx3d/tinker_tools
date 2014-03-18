Dta.scale_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS SCALEWINDOW
-------------------------------

function Dta.scale_ui.createWindowScale(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowScale = UI.CreateFrame("Frame", name, parent)
		windowScale:SetHeight(height)
		windowScale:SetWidth(width)
		windowScale:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowScale:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowScale:SetLayer(13)

  windowScale.background = UI.CreateFrame("Texture", name .. "Background", windowScale)
  windowScale.background:SetPoint("TOPLEFT", windowScale, "TOPLEFT", 0, 0)
  windowScale.background:SetPoint("BOTTOMRIGHT", windowScale, "TOPRIGHT", 0, height)
  windowScale.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowScale.background:SetLayer(3)

  local background2Position = windowScale:GetHeight()-80
  windowScale.background2 = UI.CreateFrame("Texture", name .. "Background2", windowScale)
  windowScale.background2:SetPoint("CENTERX", windowScale, "CENTERX")
  windowScale.background2:SetPoint("CENTERY", windowScale, "CENTERY", nil, background2Position/2)
  windowScale.background2:SetWidth(width)
  windowScale.background2:SetHeight(95)
  windowScale.background2:SetAlpha(0.3)
  windowScale.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowScale.background2:SetLayer(5)


  if closable then
    windowScale.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowScale, windowScale:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowScale.closeBtn:SetLayer(4)
  end

  if movable then
    windowScale.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowScale)
    windowScale.moveFrame:SetPoint("TOPLEFT", windowScale, "TOPLEFT", 0, -40)
    windowScale.moveFrame:SetPoint("BOTTOMRIGHT", windowScale, "TOPRIGHT", 0, 5)
    windowScale.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowScale.moveFrame:SetLayer(2)
    --windowScale.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowScale.header = UI.CreateFrame("Text", name .. "header", windowScale.moveFrame)
    windowScale.header:SetFontSize(20)
    windowScale.header:SetText(title)
    windowScale.header:SetFontColor(0,0,0,1)
    windowScale.header:SetPoint("CENTERX", windowScale.moveFrame, "CENTERX")
    windowScale.header:SetPoint("CENTERY", windowScale.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowScale.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowScale:GetLeft()
	    dragStartY = mouse.y - windowScale:GetTop()
	end, "LMouseDown")

	windowScale.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowScale.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowScale:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowScale
  end
end

local ScaleWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.Scale,
  WIDTH = 315,
  HEIGHT = 140,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.scale_ui.buildScaleWindow()
  local x = Dta.settings.get("ScalewindowPosX")
  local y = Dta.settings.get("ScalewindowPosY")
  Scalewindow = Dta.scale_ui.createWindowScale("Scalewindow",
                               Dta.ui.context,
                               ScaleWindowSettings.TITLE,
                               ScaleWindowSettings.WIDTH,
                               ScaleWindowSettings.HEIGHT,
                               x,
                               y,
                               ScaleWindowSettings.CLOSABLE,
                               ScaleWindowSettings.MOVABLE,
                               Dta.scale_ui.ScaleWindowClosed,
                               Dta.scale_ui.ScaleWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------

                                Scalewindow.modifyScale = Dta.ui.createFrame("modifyScale", Scalewindow, 10, 10, Scalewindow:GetWidth()-20, Scalewindow:GetHeight()-20)
                                Scalewindow.modifyScale:SetLayer(30)
                                --Scalewindow.modifyScale:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                Scalewindow.modifyScale.label = Dta.ui.createText("modifyScaleLabel", Scalewindow.modifyScale, 75, 0, Lang[Dta.Language].Text.Scale, 14)

                                Scalewindow.modifyScale.scale = Dta.ui.createTextfield("modifyScaleScale", Scalewindow.modifyScale, 120, 0, 100)

                                Scalewindow.modifyScale.modeAbs = Dta.ui.createCheckbox("modifyScaleModeAbs", Scalewindow.modifyScale, 45, 30, Lang[Dta.Language].Text.Absolute, true, nil, Dta.scale.modifyScaleModeAbsChanged)
                                Scalewindow.modifyScale.modeRel = Dta.ui.createCheckbox("modifyScaleModeRel", Scalewindow.modifyScale, 175, 30, Lang[Dta.Language].Text.Relative, false, nil, Dta.scale.modifyScaleModeRelChanged)

                                Scalewindow.modifyScale.changeBtn = Dta.ui.createButton("modifyScaleBtn", Scalewindow.modifyScale, 0, 90, nil, nil, Lang[Dta.Language].Buttons.Scale, nil, Dta.scale.modifyScaleButtonClicked)
                                Scalewindow.modifyScale.resetBtn = Dta.ui.createButton("modifyScaleResetBtn", Scalewindow.modifyScale, 160, 90, nil, nil, Lang[Dta.Language].Buttons.Reset, nil, Dta.scale.modifyScaleResetButtonClicked)

  return Scalewindow
end

-- Show the toolbox window
function Dta.scale_ui.showScaleWindow()
  if Dta.ui.windowScale == nil then
    Dta.ui.windowScale = Dta.scale_ui.buildScaleWindow()
  else
    Dta.scale_ui.windowScale:SetVisible(true)
  end
  Dta.ui.activeScale = true
end

-- Hide the toolbox window
function Dta.scale_ui.hideScaleWindow()
  Dta.ui.windowScale:SetVisible(false)
  Dta.ui.windowScale = nil
  Dta.ui.activeScale = false

end

-- Toggle the toolbox window
function Dta.scale_ui.toggleScaleWindow()
  if Dta.ui.windowScale then Dta.scale_ui.hideScaleWindow()
  else Dta.scale_ui.showScaleWindow() end
end

--Called when the window has been closed
function Dta.scale_ui.ScaleWindowClosed()
  Dta.scale_ui.hideScaleWindow()
end

--Called when the window has been moved
function Dta.scale_ui.ScaleWindowMoved()
  Dta.settings.set("ScalewindowPosX", Scalewindow:GetLeft())
  Dta.settings.set("ScalewindowPosY", Scalewindow:GetTop())
end
