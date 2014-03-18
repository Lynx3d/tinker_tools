Dta.move_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS MOVEWINDOW
-------------------------------

function Dta.move_ui.createWindowMove(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowMove = UI.CreateFrame("Frame", name, parent)
		windowMove:SetHeight(height)
		windowMove:SetWidth(width)
		windowMove:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowMove:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowMove:SetLayer(11)

  windowMove.background = UI.CreateFrame("Texture", name .. "Background", windowMove)
  windowMove.background:SetPoint("TOPLEFT", windowMove, "TOPLEFT", 0, 0)
  windowMove.background:SetPoint("BOTTOMRIGHT", windowMove, "TOPRIGHT", 0, height)
  windowMove.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowMove.background:SetLayer(3)

  local background2Position = windowMove:GetHeight()-80
  windowMove.background2 = UI.CreateFrame("Texture", name .. "Background2", windowMove)
  windowMove.background2:SetPoint("CENTERX", windowMove, "CENTERX")
  windowMove.background2:SetPoint("CENTERY", windowMove, "CENTERY", nil, background2Position/2)
  windowMove.background2:SetWidth(width)
  windowMove.background2:SetHeight(95)
  windowMove.background2:SetAlpha(0.3)
  windowMove.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowMove.background2:SetLayer(5)


  if closable then
    windowMove.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowMove, windowMove:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowMove.closeBtn:SetLayer(4)
  end

  if movable then
    windowMove.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowMove)
    windowMove.moveFrame:SetPoint("TOPLEFT", windowMove, "TOPLEFT", 0, -40)
    windowMove.moveFrame:SetPoint("BOTTOMRIGHT", windowMove, "TOPRIGHT", 0, 5)
    windowMove.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowMove.moveFrame:SetLayer(2)
    --windowMove.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowMove.header = UI.CreateFrame("Text", name .. "header", windowMove.moveFrame)
    windowMove.header:SetFontSize(20)
    windowMove.header:SetText(title)
    windowMove.header:SetFontColor(0,0,0,1)
    windowMove.header:SetPoint("CENTERX", windowMove.moveFrame, "CENTERX")
    windowMove.header:SetPoint("CENTERY", windowMove.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowMove.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowMove:GetLeft()
	    dragStartY = mouse.y - windowMove:GetTop()
	end, "LMouseDown")

	windowMove.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowMove.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowMove:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowMove
  end
end

local MoveWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.Move,
  WIDTH = 315,
  HEIGHT = 140,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.move_ui.buildMoveWindow()
  local x = Dta.settings.get("MovewindowPosX")
  local y = Dta.settings.get("MovewindowPosY")
  Movewindow = Dta.move_ui.createWindowMove("MoveWindow",
                               Dta.ui.context,
                               MoveWindowSettings.TITLE,
                               MoveWindowSettings.WIDTH,
                               MoveWindowSettings.HEIGHT,
                               x,
                               y,
                               MoveWindowSettings.CLOSABLE,
                               MoveWindowSettings.MOVABLE,
                               Dta.move_ui.MoveWindowClosed,
                               Dta.move_ui.MoveWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------

                                Movewindow.modifyPosition = Dta.ui.createFrame("modifyPosition", Movewindow, 10, 10, Movewindow:GetWidth()-20, Movewindow:GetHeight()-20)
                                Movewindow.modifyPosition:SetLayer(30)
                                --Movewindow.modifyPosition:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                Movewindow.modifyPosition.xLabel = Dta.ui.createText("modifyPositionXLabel", Movewindow.modifyPosition, 0, 0, "X", 14, {1, 0, 0, 1})
                                Movewindow.modifyPosition.yLabel = Dta.ui.createText("modifyPositionYLabel", Movewindow.modifyPosition, 110, 0, "Y", 14, {0, 1, 0, 1})
                                Movewindow.modifyPosition.zLabel = Dta.ui.createText("modifyPositionZLabel", Movewindow.modifyPosition, 220, 0, "Z", 14, {0, 1, 1, 1})

                                Movewindow.modifyPosition.x = Dta.ui.createTextfield("modifyPositionX", Movewindow.modifyPosition, 20, 0, 50)
                                Movewindow.modifyPosition.y = Dta.ui.createTextfield("modifyPositionY", Movewindow.modifyPosition, 130, 0, 50)
                                Movewindow.modifyPosition.z = Dta.ui.createTextfield("modifyPositionZ", Movewindow.modifyPosition, 240, 0, 50)

                                Movewindow.modifyPosition.modeAbs = Dta.ui.createCheckbox("modifyPositionModeAbs", Movewindow.modifyPosition, 45, 30, Lang[Dta.Language].Text.Absolute, true, nil, Dta.move.modifyPositionModeAbsChanged)
                                Movewindow.modifyPosition.modeRel = Dta.ui.createCheckbox("modifyPositionModeRel", Movewindow.modifyPosition, 175, 30, Lang[Dta.Language].Text.Relative, false, nil, Dta.move.modifyPositionModeRelChanged)

                                Movewindow.modifyPosition.moveAsGrp = Dta.ui.createCheckbox("modifyPositionMoveAsGrp", Movewindow.modifyPosition, 95, 60, Lang[Dta.Language].Text.MoveAsGroup, true)
                                Movewindow.modifyPosition.moveAsGrp:SetVisible(false)

                                Movewindow.modifyPosition.changeBtn = Dta.ui.createButton("modifyPositionBtn", Movewindow.modifyPosition, 0, 90, nil, nil, Lang[Dta.Language].Buttons.Move, nil, Dta.move.modifyPositionButtonClicked)
                                Movewindow.modifyPosition.resetBtn = Dta.ui.createButton("modifyPositionResetBtn", Movewindow.modifyPosition, 160, 90, nil, nil, Lang[Dta.Language].Buttons.Reset, nil, Dta.move.modifyPositionResetButtonClicked)




-- insert buttons and textboxes here
  return Movewindow
end

-- Show the toolbox window
function Dta.move_ui.showMoveWindow()
  if Dta.ui.windowMove == nil then
    Dta.ui.windowMove = Dta.move_ui.buildMoveWindow()
  else
    Dta.move_ui.windowMove:SetVisible(true)
  end
  Dta.ui.activeMove = true
end

-- Hide the toolbox window
function Dta.move_ui.hideMoveWindow()
  Dta.ui.windowMove:SetVisible(false)
  Dta.ui.windowMove = nil
  Dta.ui.activeMove = false

end

-- Toggle the toolbox window
function Dta.move_ui.toggleMoveWindow()
  if Dta.ui.activeMove then Dta.move_ui.hideMoveWindow()
  else Dta.move_ui.showMoveWindow() end
end

--Called when the window has been closed
function Dta.move_ui.MoveWindowClosed()
  Dta.move_ui.hideMoveWindow()
end

--Called when the window has been moved
function Dta.move_ui.MoveWindowMoved()
  Dta.settings.set("MovewindowPosX", Movewindow:GetLeft())
  Dta.settings.set("MovewindowPosY", Movewindow:GetTop())
end
