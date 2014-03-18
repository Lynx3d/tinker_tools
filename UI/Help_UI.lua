Dta.help_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS HelpWINDOW
-------------------------------

function Dta.help_ui.createWindowHelp(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowHelp = UI.CreateFrame("Frame", name, parent)
		windowHelp:SetHeight(height)
		windowHelp:SetWidth(width)
		windowHelp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowHelp:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowHelp:SetLayer(41)

  windowHelp.background = UI.CreateFrame("Texture", name .. "Background", windowHelp)
  windowHelp.background:SetPoint("TOPLEFT", windowHelp, "TOPLEFT", 0, 0)
  windowHelp.background:SetPoint("BOTTOMRIGHT", windowHelp, "TOPRIGHT", 0, height)
  windowHelp.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowHelp.background:SetLayer(3)

  --windowHelp.background2 = UI.CreateFrame("Texture", name .. "Background2", windowHelp)
  --windowHelp.background2:SetPoint("CENTERX", windowHelp, "CENTERX")
  --windowHelp.background2:SetPoint("CENTERY", windowHelp, "CENTERY", nil, 30)
  --windowHelp.background2:SetWidth(width)
  --windowHelp.background2:SetHeight(95)
  --windowHelp.background2:SetAlpha(0.3)
  --windowHelp.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  --windowHelp.background2:SetLayer(5)


  if closable then
    windowHelp.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowHelp, windowHelp:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowHelp.closeBtn:SetLayer(4)
  end

  if movable then
    windowHelp.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowHelp)
    windowHelp.moveFrame:SetPoint("TOPLEFT", windowHelp, "TOPLEFT", 0, -40)
    windowHelp.moveFrame:SetPoint("BOTTOMRIGHT", windowHelp, "TOPRIGHT", 0, 5)
    windowHelp.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowHelp.moveFrame:SetLayer(2)
    --windowHelp.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowHelp.header = UI.CreateFrame("Text", name .. "header", windowHelp.moveFrame)
    windowHelp.header:SetFontSize(20)
    windowHelp.header:SetText(title)
    windowHelp.header:SetFontColor(0,0,0,1)
    windowHelp.header:SetPoint("CENTERX", windowHelp.moveFrame, "CENTERX")
    windowHelp.header:SetPoint("CENTERY", windowHelp.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowHelp.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowHelp:GetLeft()
	    dragStartY = mouse.y - windowHelp:GetTop()
	end, "LMouseDown")

	windowHelp.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowHelp.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowHelp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowHelp
  end
end

local HelpWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.Help,
  WIDTH = 800,
  HEIGHT = 600,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.help_ui.buildHelpWindow()
  local x = Dta.settings.get("HelpwindowPosX")
  local y = Dta.settings.get("HelpwindowPosY")
  Helpwindow = Dta.help_ui.createWindowHelp("HelpWindow",
                               Dta.ui.context,
                               HelpWindowSettings.TITLE,
                               HelpWindowSettings.WIDTH,
                               HelpWindowSettings.HEIGHT,
                               x,
                               y,
                               HelpWindowSettings.CLOSABLE,
                               HelpWindowSettings.MOVABLE,
                               Dta.help_ui.HelpWindowClosed,
                               Dta.help_ui.HelpWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                Helpwindow.IndexWindow = UI.CreateFrame("Texture", "IndexWindow_Background", Helpwindow)
                                Helpwindow.IndexWindow:SetPoint("TOPLEFT", Helpwindow, "TOPLEFT", 10, 55)
                                Helpwindow.IndexWindow:SetHeight(535)
                                Helpwindow.IndexWindow:SetWidth(180)
                                Helpwindow.IndexWindow:SetTexture("Rift", "dimension_window_itemlist_bg2.png.dds")
                                Helpwindow.IndexWindow:SetLayer(40)

                                Helpwindow.ScrollIndexLoad = UI.CreateFrame("SimpleScrollView", "HelpScrollIndexLoad", Helpwindow.IndexWindow)
                                Helpwindow.ScrollIndexLoad:SetPoint("TOPLEFT", Helpwindow.IndexWindow, "TOPLEFT", 10, 10)
                                Helpwindow.ScrollIndexLoad:SetLayer(50)
                                Helpwindow.ScrollIndexLoad:SetWidth(140)
                                Helpwindow.ScrollIndexLoad:SetHeight(560)
                                Helpwindow.ScrollIndexLoad:SetBackgroundColor(0, 0, 0, 0)

                                Helpwindow.HelpIndex = UI.CreateFrame("SimpleList", "HelpIndex", Helpwindow.ScrollIndexLoad)
                                Helpwindow.HelpIndex.Event.ItemSelect = function(view, item) Dta.Help.InfoHandler(item) end
                                local HelpIndex = Dta.Help.helpIndex
                                Helpwindow.HelpIndex:SetItems(HelpIndex)
                                Helpwindow.HelpIndex:SetBackgroundColor(0, 0, 0, 0)
                                Helpwindow.HelpIndex:SetFontSize(15)

                                Helpwindow.ScrollIndexLoad:SetContent(Helpwindow.HelpIndex)

                                -------------------------------------------------------------------
                                Helpwindow.InfoWindow = UI.CreateFrame("Texture", "InfoWindow_Background", Helpwindow)
                                Helpwindow.InfoWindow:SetPoint("TOPLEFT", Helpwindow, "TOPLEFT", 165, 45)
                                Helpwindow.InfoWindow:SetHeight(560)
                                Helpwindow.InfoWindow:SetWidth(650)
                                Helpwindow.InfoWindow:SetTexture("Rift", "dimensions_itemlist_window_bottom.png.dds")
                                Helpwindow.InfoWindow:SetLayer(40)

                                Helpwindow.ScrollInfoLoad = UI.CreateFrame("SimpleScrollView", "HelpScrollInfoLoad", Helpwindow.InfoWindow)
                                Helpwindow.ScrollInfoLoad:SetPoint("TOPLEFT", Helpwindow.InfoWindow, "TOPLEFT", 40, 20)
                                Helpwindow.ScrollInfoLoad:SetLayer(50)
                                Helpwindow.ScrollInfoLoad:SetWidth(570)
                                Helpwindow.ScrollInfoLoad:SetHeight(520)
                                Helpwindow.ScrollInfoLoad:SetBackgroundColor(0, 0, 0, 0)

                                Helpwindow.HelpInfo = UI.CreateFrame("Frame", "HelpInfo", Helpwindow.ScrollInfoLoad)

                                Helpwindow.HeaderInfo = UI.CreateFrame("Text", "HeaderInfo", Helpwindow.HelpInfo)
                                Helpwindow.TextInfo01 = UI.CreateFrame("Text", "TextInfo01", Helpwindow.HelpInfo)
                                Helpwindow.TextInfo02 = UI.CreateFrame("Text", "TextInfo02", Helpwindow.HelpInfo)
                                Helpwindow.TextInfo03 = UI.CreateFrame("Text", "TextInfo03", Helpwindow.HelpInfo)
                                Helpwindow.PicInfo01 = UI.CreateFrame("Texture", "PicInfo01", Helpwindow.HelpInfo)
                                Helpwindow.PicInfo02 = UI.CreateFrame("Texture", "PicInfo02", Helpwindow.HelpInfo)
                                Helpwindow.PicInfo03 = UI.CreateFrame("Texture", "PicInfo03", Helpwindow.HelpInfo)


                                Helpwindow.ScrollInfoLoad:SetContent(Helpwindow.HelpInfo)


  return Helpwindow
end

-- Show the toolbox window
function Dta.help_ui.showHelpWindow()
  if Dta.ui.windowHelp == nil then
    Dta.ui.windowHelp = Dta.help_ui.buildHelpWindow()
  else
    Dta.help_ui.windowHelp:SetVisible(true)
  end
  Dta.ui.windowHelp.HelpIndex:SetSelectedItem("Intro", false)
  Dta.ui.activeHelp = true
end

-- Hide the toolbox window
function Dta.help_ui.hideHelpWindow()
  Dta.ui.windowHelp:SetVisible(false)
  Dta.ui.windowHelp = nil
  Dta.ui.activeHelp = false

end

-- Toggle the toolbox window
function Dta.help_ui.toggleHelpWindow(hEvent)
  if Dta.ui.activeHelp then Dta.help_ui.hideHelpWindow()
  else Dta.help_ui.showHelpWindow() end
end

--Called when the window has been closed
function Dta.help_ui.HelpWindowClosed()
  Dta.help_ui.hideHelpWindow()
end

--Called when the window has been moved
function Dta.help_ui.HelpWindowMoved()
  Dta.settings.set("HelpwindowPosX", Helpwindow:GetLeft())
  Dta.settings.set("HelpwindowPosY", Helpwindow:GetTop())
end
