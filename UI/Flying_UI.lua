Dta.flying_ui = {}

function Dta.flying_ui.createWindowFlying(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowFlying = UI.CreateFrame("Frame", name, parent)
		windowFlying:SetHeight(height)
		windowFlying:SetWidth(width)
		windowFlying:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowFlying:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowFlying:SetLayer(30)

  windowFlying.background = UI.CreateFrame("Texture", name .. "Background", windowFlying)
  windowFlying.background:SetPoint("TOPLEFT", windowFlying, "TOPLEFT", 0, 0)
  windowFlying.background:SetPoint("BOTTOMRIGHT", windowFlying, "TOPRIGHT", 0, height)
  windowFlying.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowFlying.background:SetLayer(3)

  local background2Position = windowFlying:GetHeight()-80
  windowFlying.background2 = UI.CreateFrame("Texture", name .. "Background2", windowFlying)
  windowFlying.background2:SetPoint("CENTERX", windowFlying, "CENTERX")
  windowFlying.background2:SetPoint("CENTERY", windowFlying, "CENTERY", nil, background2Position/2)
  windowFlying.background2:SetWidth(width)
  windowFlying.background2:SetHeight(95)
  windowFlying.background2:SetAlpha(0.3)
  windowFlying.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowFlying.background2:SetLayer(5)


  if closable then
    windowFlying.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowFlying, windowFlying:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowFlying.closeBtn:SetLayer(4)
  end

  if movable then
    windowFlying.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowFlying)
    windowFlying.moveFrame:SetPoint("TOPLEFT", windowFlying, "TOPLEFT", 0, -40)
    windowFlying.moveFrame:SetPoint("BOTTOMRIGHT", windowFlying, "TOPRIGHT", 0, 5)
    windowFlying.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowFlying.moveFrame:SetLayer(2)
    --windowFlying.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowFlying.header = UI.CreateFrame("Text", name .. "header", windowFlying.moveFrame)
    windowFlying.header:SetFontSize(20)
    windowFlying.header:SetText(title)
    windowFlying.header:SetFontColor(0,0,0,1)
    windowFlying.header:SetPoint("CENTERX", windowFlying.moveFrame, "CENTERX")
    windowFlying.header:SetPoint("CENTERY", windowFlying.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowFlying.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowFlying:GetLeft()
	    dragStartY = mouse.y - windowFlying:GetTop()
	end, "LMouseDown")

	windowFlying.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowFlying.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowFlying:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowFlying
  end
end

local FlyingWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.TribalMagic,
  WIDTH = 300,
  HEIGHT = 270,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.flying_ui.buildFlyingWindow()
  local x = Dta.settings.get("FlyingwindowPosX")
  local y = Dta.settings.get("FlyingwindowPosY")
  Flyingwindow = Dta.flying_ui.createWindowFlying("FlyingWindow",
                               Dta.ui.context,
                               FlyingWindowSettings.TITLE,
                               FlyingWindowSettings.WIDTH,
                               FlyingWindowSettings.HEIGHT,
                               x,
                               y,
                               FlyingWindowSettings.CLOSABLE,
                               FlyingWindowSettings.MOVABLE,
                               Dta.flying_ui.FlyingWindowClosed,
                               Dta.flying_ui.FlyingWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                Flyingwindow.DFlying = Dta.ui.createFrame("ImportExport", Flyingwindow, 10, 10, Flyingwindow:GetWidth()-20, Flyingwindow:GetHeight()-20)
                                Flyingwindow.DFlying:SetLayer(30)
                                --Flyingwindow.DFlying:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                Flyingwindow.DFlying.placeButton = Dta.ui.createButton("DFlyingPlaceBtn", Flyingwindow.DFlying, 0, 95, nil, nil, Lang[Dta.Language].Buttons.Place, nil, Dta.flying.PlaceFlying)
                                Flyingwindow.DFlying.placeButton:SetLayer(100)
                                if Dta.carpetId ~= "d" then
                                    Flyingwindow.DFlying.placeButton:SetEnabled(false)
                                else
                                    Flyingwindow.DFlying.placeButton:SetEnabled(true)
                                end

                                Flyingwindow.DFlying.pickupButton = Dta.ui.createButton("DFlyingPickUpBtn", Flyingwindow.DFlying, 0, 125, nil, nil, Lang[Dta.Language].Buttons.PickUp, nil, Dta.flying.PickUpFlying)
                                Flyingwindow.DFlying.pickupButton:SetLayer(100)
                                if Dta.carpetId ~= "d" then
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


  return Flyingwindow
end

-- Show the toolbox window
function Dta.flying_ui.showFlyingWindow()
  if Dta.ui.windowFlying == nil then
    Dta.ui.windowFlying = Dta.flying_ui.buildFlyingWindow()
  else
    Dta.flying_ui.windowFlying:SetVisible(true)
  end
  Dta.ui.activeFlying = true
end

-- Hide the toolbox window
function Dta.flying_ui.hideFlyingWindow()
  Dta.ui.windowFlying:SetVisible(false)
  Dta.ui.windowFlying = nil
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

--Called when the window has been moved
function Dta.flying_ui.FlyingWindowMoved()
  Dta.settings.set("FlyingwindowPosX", Flyingwindow:GetLeft())
  Dta.settings.set("FlyingwindowPosY", Flyingwindow:GetTop())
end
