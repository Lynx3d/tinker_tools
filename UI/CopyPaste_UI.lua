Dta.copa_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS COPY/PASTE WINDOW
-------------------------------

function Dta.copa_ui.createWindowCopyPaste(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowCopyPaste = UI.CreateFrame("Frame", name, parent)
		windowCopyPaste:SetHeight(height)
		windowCopyPaste:SetWidth(width)
		windowCopyPaste:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowCopyPaste:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowCopyPaste:SetLayer(21)

  windowCopyPaste.background = UI.CreateFrame("Texture", name .. "Background", windowCopyPaste)
  windowCopyPaste.background:SetPoint("TOPLEFT", windowCopyPaste, "TOPLEFT", 0, 0)
  windowCopyPaste.background:SetPoint("BOTTOMRIGHT", windowCopyPaste, "TOPRIGHT", 0, height)
  windowCopyPaste.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowCopyPaste.background:SetLayer(3)

  local background2Position = windowCopyPaste:GetHeight()-80
  windowCopyPaste.background2 = UI.CreateFrame("Texture", name .. "Background2", windowCopyPaste)
  windowCopyPaste.background2:SetPoint("CENTERX", windowCopyPaste, "CENTERX")
  windowCopyPaste.background2:SetPoint("CENTERY", windowCopyPaste, "CENTERY", nil, background2Position/2)
  windowCopyPaste.background2:SetWidth(width)
  windowCopyPaste.background2:SetHeight(95)
  windowCopyPaste.background2:SetAlpha(0.3)
  windowCopyPaste.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowCopyPaste.background2:SetLayer(5)


  if closable then
    windowCopyPaste.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowCopyPaste, windowCopyPaste:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowCopyPaste.closeBtn:SetLayer(4)
  end

  if movable then
    windowCopyPaste.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowCopyPaste)
    windowCopyPaste.moveFrame:SetPoint("TOPLEFT", windowCopyPaste, "TOPLEFT", 0, -40)
    windowCopyPaste.moveFrame:SetPoint("BOTTOMRIGHT", windowCopyPaste, "TOPRIGHT", 0, 5)
    windowCopyPaste.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowCopyPaste.moveFrame:SetLayer(2)
    --windowCopyPaste.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowCopyPaste.header = UI.CreateFrame("Text", name .. "header", windowCopyPaste.moveFrame)
    windowCopyPaste.header:SetFontSize(20)
    windowCopyPaste.header:SetText(title)
    windowCopyPaste.header:SetFontColor(0,0,0,1)
    windowCopyPaste.header:SetPoint("CENTERX", windowCopyPaste.moveFrame, "CENTERX")
    windowCopyPaste.header:SetPoint("CENTERY", windowCopyPaste.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowCopyPaste.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowCopyPaste:GetLeft()
	    dragStartY = mouse.y - windowCopyPaste:GetTop()
	end, "LMouseDown")

	windowCopyPaste.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowCopyPaste.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowCopyPaste:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowCopyPaste
  end
end

local CopyPasteWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.CopyPaste,
  WIDTH = 325,
  HEIGHT = 260,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.copa_ui.buildCopyPasteWindow()
  local x = Dta.settings.get("CopyPastewindowPosX")
  local y = Dta.settings.get("CopyPastewindowPosY")
  CopyPastewindow = Dta.copa_ui.createWindowCopyPaste("CopyPastewindow",
                               Dta.ui.context,
                               CopyPasteWindowSettings.TITLE,
                               CopyPasteWindowSettings.WIDTH,
                               CopyPasteWindowSettings.HEIGHT,
                               x,
                               y,
                               CopyPasteWindowSettings.CLOSABLE,
                               CopyPasteWindowSettings.MOVABLE,
                               Dta.copa_ui.CopyPastewindowClosed,
                               Dta.copa_ui.CopyPastewindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                CopyPastewindow.copyPaste = Dta.ui.createFrame("copyPaste", CopyPastewindow, 10, 10, CopyPastewindow:GetWidth()-20, CopyPastewindow:GetHeight()-20)
                                CopyPastewindow.copyPaste:SetLayer(30)
                                --CopyPastewindow.copyPaste:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                CopyPastewindow.copyPaste.copyBtn = Dta.ui.createButton("copyBtn", CopyPastewindow.copyPaste, 0, 110, nil, nil, Lang[Dta.Language].Buttons.Copy, nil, Dta.copa.copyButtonClicked)
                                CopyPastewindow.copyPaste.pasteBtn = Dta.ui.createButton("pasteBtn", CopyPastewindow.copyPaste, 165, 110, nil, nil, Lang[Dta.Language].Buttons.Paste, nil, Dta.copa.pasteButtonClicked)

                                CopyPastewindow.copyPaste.offsetLabel1 = Dta.ui.createText("copyPasteOffsetLabel1", CopyPastewindow.copyPaste, 45, 0, Lang[Dta.Language].Text.Offset, 11)
                                CopyPastewindow.copyPaste.offsetLabel2 = Dta.ui.createText("copyPasteOffsetLabel3", CopyPastewindow.copyPaste, 155, 0, Lang[Dta.Language].Text.Offset, 11)
                                CopyPastewindow.copyPaste.offsetLabel3 = Dta.ui.createText("copyPasteOffsetLabel4", CopyPastewindow.copyPaste, 260, 0, Lang[Dta.Language].Text.Offset, 11)

                                CopyPastewindow.copyPaste.x = Dta.ui.createCheckbox("copyPasteX", CopyPastewindow.copyPaste, 0, 15, "X", true, {1, 0, 0, 1})
                                CopyPastewindow.copyPaste.y = Dta.ui.createCheckbox("copyPasteY", CopyPastewindow.copyPaste, 0, 40, "Y", true, {0, 1, 0, 1})
                                CopyPastewindow.copyPaste.z = Dta.ui.createCheckbox("copyPasteZ", CopyPastewindow.copyPaste, 0, 65, "Z", true, {0, 1, 1, 1})

                                CopyPastewindow.copyPaste.yaw = Dta.ui.createCheckbox("copyPasteYaw", CopyPastewindow.copyPaste, 105, 15, Lang[Dta.Language].Text.Yaw, true, {0, 1, 0, 1})
                                CopyPastewindow.copyPaste.pitch = Dta.ui.createCheckbox("copyPastePitch", CopyPastewindow.copyPaste, 105, 40, Lang[Dta.Language].Text.Pitch, true, {1, 0, 0, 1})
                                CopyPastewindow.copyPaste.roll = Dta.ui.createCheckbox("copyPasteRoll", CopyPastewindow.copyPaste, 105, 65, Lang[Dta.Language].Text.Roll, true, {0, 1, 1, 1})

                                CopyPastewindow.copyPaste.scale = Dta.ui.createCheckbox("copyPasteScale", CopyPastewindow.copyPaste, 210, 15, Lang[Dta.Language].Text.Scale, true)

                                CopyPastewindow.copyPaste.xOffset = Dta.ui.createTextfield("copyPasteXOffset", CopyPastewindow.copyPaste, 45, 15, 40)
                                CopyPastewindow.copyPaste.yOffset = Dta.ui.createTextfield("copyPasteYOffset", CopyPastewindow.copyPaste, 45, 40, 40)
                                CopyPastewindow.copyPaste.zOffset = Dta.ui.createTextfield("copyPasteZOffset", CopyPastewindow.copyPaste, 45, 65, 40)

                                CopyPastewindow.copyPaste.yawOffset = Dta.ui.createTextfield("copyPasteYawOffset", CopyPastewindow.copyPaste, 155, 15, 40)
                                CopyPastewindow.copyPaste.pitchOffset = Dta.ui.createTextfield("copyPastePitchOffset", CopyPastewindow.copyPaste, 155, 40, 40)
                                CopyPastewindow.copyPaste.rollOffset = Dta.ui.createTextfield("copyPasteRollOffset", CopyPastewindow.copyPaste, 155, 65, 40)

                                CopyPastewindow.copyPaste.scaleOffset = Dta.ui.createTextfield("copyPasteScaleOffset", CopyPastewindow.copyPaste, 260, 15, 40)

                                CopyPastewindow.copyPaste.multiplyOffsets = Dta.ui.createCheckbox("copyPasteMultiplyOffsets", CopyPastewindow.copyPaste, 0, 95, Lang[Dta.Language].Text.OffsetMultiItems, false, nil, Dta.copa.CopaOffsetChanged)
                                CopyPastewindow.copyPaste.multiplyOffsets:SetVisible(true)

                                CopyPastewindow.copyPaste.divider1 = Dta.ui.createTexture("dividerCopa", CopyPastewindow, "Dimtools", "textures/divider.png", 10, 155, CopyPastewindow:GetWidth()-10)
                                CopyPastewindow.copyPaste.divider1:SetLayer(29)

                                CopyPastewindow.copyPaste.NewItem = Dta.ui.createCheckbox("copyPasteNewItem", CopyPastewindow.copyPaste, 0, 165, Lang[Dta.Language].Text.UseNewItems, false, nil, Dta.copa.CopaNewItemChanged)

                                CopyPastewindow.copyPaste.NewItemLabel = Dta.ui.createText("copyPasteNewItemLabel", CopyPastewindow.copyPaste, 0, 190, Lang[Dta.Language].Text.NrItems, 15)
                                CopyPastewindow.copyPaste.NewItemLabel:SetVisible(false)

                                CopyPastewindow.copyPaste.NewItemNr = Dta.ui.createTextfield("copyPasteNewItemNr", CopyPastewindow.copyPaste, 85, 190, 40)
                                CopyPastewindow.copyPaste.NewItemNr:SetVisible(false)

                                CopyPastewindow.copyPaste.Bags = Dta.ui.createCheckbox("copyPasteBags", CopyPastewindow.copyPaste, 0, 220, Lang[Dta.Language].Text.Bags, true, nil, Dta.copa.CopaBagsChanged)
                                CopyPastewindow.copyPaste.Bags:SetVisible(false)
                                CopyPastewindow.copyPaste.Bank = Dta.ui.createCheckbox("copyPasteBank", CopyPastewindow.copyPaste, 110, 220, Lang[Dta.Language].Text.BankBags, false, nil, Dta.copa.CopaBankChanged)
                                CopyPastewindow.copyPaste.Bank:SetVisible(false)
                                CopyPastewindow.copyPaste.Both = Dta.ui.createCheckbox("copyPasteBoth", CopyPastewindow.copyPaste, 235, 220, Lang[Dta.Language].Text.Vaults, false, nil, Dta.copa.CopaBothChanged)
                                CopyPastewindow.copyPaste.Both:SetVisible(false)

  return CopyPastewindow
end

-- Show the toolbox window
function Dta.copa_ui.showCopyPastewindow()
  if Dta.ui.windowCopyPaste == nil then
    Dta.ui.windowCopyPaste = Dta.copa_ui.buildCopyPasteWindow()
  else
    Dta.copa_ui.windowCopyPaste:SetVisible(true)
  end
  Dta.ui.activeCopyPaste = true
end

-- Hide the toolbox window
function Dta.copa_ui.hideCopyPastewindow()
  Dta.ui.windowCopyPaste:SetVisible(false)
  Dta.ui.windowCopyPaste = nil
  Dta.ui.activeCopyPaste = false
  Dta.clipboard = {}
end

-- Toggle the toolbox window
function Dta.copa_ui.toggleCopyPastewindow()
  if Dta.ui.windowCopyPaste then Dta.copa_ui.hideCopyPastewindow()
  else Dta.copa_ui.showCopyPastewindow() end
end

--Called when the window has been closed
function Dta.copa_ui.CopyPastewindowClosed()
  Dta.copa_ui.hideCopyPastewindow()
end

--Called when the window has been moved
function Dta.copa_ui.CopyPastewindowMoved()
  Dta.settings.set("CopyPastewindowPosX", CopyPastewindow:GetLeft())
  Dta.settings.set("CopyPastewindowPosY", CopyPastewindow:GetTop())
end
