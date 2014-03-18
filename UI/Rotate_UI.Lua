Dta.rotate_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS RotateWINDOW
-------------------------------

function Dta.rotate_ui.createWindowRotate(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowRotate = UI.CreateFrame("Frame", name, parent)
		windowRotate:SetHeight(height)
		windowRotate:SetWidth(width)
		windowRotate:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowRotate:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowRotate:SetLayer(12)

  windowRotate.background = UI.CreateFrame("Texture", name .. "Background", windowRotate)
  windowRotate.background:SetPoint("TOPLEFT", windowRotate, "TOPLEFT", 0, 0)
  windowRotate.background:SetPoint("BOTTOMRIGHT", windowRotate, "TOPRIGHT", 0, height)
  windowRotate.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowRotate.background:SetLayer(3)

  local background2Position = windowRotate:GetHeight()-80
  windowRotate.background2 = UI.CreateFrame("Texture", name .. "Background2", windowRotate)
  windowRotate.background2:SetPoint("CENTERX", windowRotate, "CENTERX")
  windowRotate.background2:SetPoint("CENTERY", windowRotate, "CENTERY", nil, background2Position/2)
  windowRotate.background2:SetWidth(width)
  windowRotate.background2:SetHeight(95)
  windowRotate.background2:SetAlpha(0.3)
  windowRotate.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowRotate.background2:SetLayer(5)


  if closable then
    windowRotate.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowRotate, windowRotate:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowRotate.closeBtn:SetLayer(4)
  end

  if movable then
    windowRotate.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowRotate)
    windowRotate.moveFrame:SetPoint("TOPLEFT", windowRotate, "TOPLEFT", 0, -40)
    windowRotate.moveFrame:SetPoint("BOTTOMRIGHT", windowRotate, "TOPRIGHT", 0, 5)
    windowRotate.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowRotate.moveFrame:SetLayer(2)
    --windowRotate.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowRotate.header = UI.CreateFrame("Text", name .. "header", windowRotate.moveFrame)
    windowRotate.header:SetFontSize(20)
    windowRotate.header:SetText(title)
    windowRotate.header:SetFontColor(0,0,0,1)
    windowRotate.header:SetPoint("CENTERX", windowRotate.moveFrame, "CENTERX")
    windowRotate.header:SetPoint("CENTERY", windowRotate.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowRotate.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowRotate:GetLeft()
	    dragStartY = mouse.y - windowRotate:GetTop()
	end, "LMouseDown")

	windowRotate.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowRotate.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowRotate:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowRotate
  end
end

local RotateWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.Rotate,
  WIDTH = 315,
  HEIGHT = 140,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.rotate_ui.buildRotateWindow()
  local x = Dta.settings.get("RotatewindowPosX")
  local y = Dta.settings.get("RotatewindowPosY")
  Rotatewindow = Dta.rotate_ui.createWindowRotate("RotateWindow",
                               Dta.ui.context,
                               RotateWindowSettings.TITLE,
                               RotateWindowSettings.WIDTH,
                               RotateWindowSettings.HEIGHT,
                               x,
                               y,
                               RotateWindowSettings.CLOSABLE,
                               RotateWindowSettings.MOVABLE,
                               Dta.rotate_ui.RotateWindowClosed,
                               Dta.rotate_ui.RotateWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                Rotatewindow.modifyRotation = Dta.ui.createFrame("modifyRotation", Rotatewindow, 10, 10, Rotatewindow:GetWidth()-20, Rotatewindow:GetHeight()-20)
                                Rotatewindow.modifyRotation:SetLayer(30)
                                --Rotatewindow.modifyRotation:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                Rotatewindow.modifyRotation.yawLabel = Dta.ui.createText("modifyRotationYawLabel", Rotatewindow.modifyRotation, 0, 0, Lang[Dta.Language].Text.Yaw, 14, {0, 1, 0, 1})
                                Rotatewindow.modifyRotation.pitchLabel = Dta.ui.createText("modifyRotationPitchLabel", Rotatewindow.modifyRotation, 100, 0, Lang[Dta.Language].Text.Pitch, 14, {1, 0, 0, 1})
                                Rotatewindow.modifyRotation.rollLabel = Dta.ui.createText("modifyRotationRollLabel", Rotatewindow.modifyRotation, 205, 0, Lang[Dta.Language].Text.Roll, 14, {0, 1, 1, 1})

                                Rotatewindow.modifyRotation.yaw = Dta.ui.createTextfield("modifyRotationYaw", Rotatewindow.modifyRotation, 35, 0, 50)
                                Rotatewindow.modifyRotation.pitch = Dta.ui.createTextfield("modifyRotationPitch", Rotatewindow.modifyRotation, 140, 0, 50)
                                Rotatewindow.modifyRotation.roll = Dta.ui.createTextfield("modifyRotationRoll", Rotatewindow.modifyRotation, 240, 0, 50)

                                Rotatewindow.modifyRotation.modeAbs = Dta.ui.createCheckbox("modifyRotationModeAbs", Rotatewindow.modifyRotation, 45, 30, Lang[Dta.Language].Text.Absolute, true, nil, Dta.rotate.modifyRotationModeAbsChanged)
                                Rotatewindow.modifyRotation.modeRel = Dta.ui.createCheckbox("modifyRotationModeRel", Rotatewindow.modifyRotation, 175, 30, Lang[Dta.Language].Text.Relative, false, nil, Dta.rotate.modifyRotationModeRelChanged)

                                Rotatewindow.modifyRotation.changeBtn = Dta.ui.createButton("modifyRotationBtn", Rotatewindow.modifyRotation, 0, 90, nil, nil, Lang[Dta.Language].Buttons.Rotate, nil, Dta.rotate.modifyRotationButtonClicked)
                                Rotatewindow.modifyRotation.resetBtn = Dta.ui.createButton("modifyRotationResetBtn", Rotatewindow.modifyRotation, 160, 90, nil, nil, Lang[Dta.Language].Buttons.Reset, nil, Dta.rotate.modifyRotationResetButtonClicked)

  return Rotatewindow
end

-- Show the toolbox window
function Dta.rotate_ui.showRotateWindow()
  if Dta.ui.windowRotate == nil then
    Dta.ui.windowRotate = Dta.rotate_ui.buildRotateWindow()
  else
    Dta.rotate_ui.windowRotate:SetVisible(true)
  end
  Dta.ui.activeRotate = true
end

-- Hide the toolbox window
function Dta.rotate_ui.hideRotateWindow()
  Dta.ui.windowRotate:SetVisible(false)
  Dta.ui.windowRotate = nil
  Dta.ui.activeRotate = false

end

-- Toggle the toolbox window
function Dta.rotate_ui.toggleRotateWindow()
  if Dta.ui.activeRotate then Dta.rotate_ui.hideRotateWindow()
  else Dta.rotate_ui.showRotateWindow() end
end

--Called when the window has been closed
function Dta.rotate_ui.RotateWindowClosed()
  Dta.rotate_ui.hideRotateWindow()
end

--Called when the window has been moved
function Dta.rotate_ui.RotateWindowMoved()
  Dta.settings.set("RotatewindowPosX", Rotatewindow:GetLeft())
  Dta.settings.set("RotatewindowPosY", Rotatewindow:GetTop())
end
