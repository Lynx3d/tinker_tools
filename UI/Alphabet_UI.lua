Dta.alphabet_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS AlphabetWINDOW
-------------------------------

function Dta.alphabet_ui.createWindowAlphabet(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowAlphabet = UI.CreateFrame("Frame", name, parent)
		windowAlphabet:SetHeight(height)
		windowAlphabet:SetWidth(width)
		windowAlphabet:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowAlphabet:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowAlphabet:SetLayer(15)

  windowAlphabet.background = UI.CreateFrame("Texture", name .. "Background", windowAlphabet)
  windowAlphabet.background:SetPoint("TOPLEFT", windowAlphabet, "TOPLEFT", 0, 0)
  windowAlphabet.background:SetPoint("BOTTOMRIGHT", windowAlphabet, "TOPRIGHT", 0, height)
  windowAlphabet.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowAlphabet.background:SetLayer(3)

  local background2Position = windowAlphabet:GetHeight()-80
  windowAlphabet.background2 = UI.CreateFrame("Texture", name .. "Background2", windowAlphabet)
  windowAlphabet.background2:SetPoint("CENTERX", windowAlphabet, "CENTERX")
  windowAlphabet.background2:SetPoint("CENTERY", windowAlphabet, "CENTERY", nil, background2Position/2)
  windowAlphabet.background2:SetWidth(width)
  windowAlphabet.background2:SetHeight(95)
  windowAlphabet.background2:SetAlpha(0.3)
  windowAlphabet.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowAlphabet.background2:SetLayer(5)


  if closable then
    windowAlphabet.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowAlphabet, windowAlphabet:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowAlphabet.closeBtn:SetLayer(4)
  end

  if movable then
    windowAlphabet.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowAlphabet)
    windowAlphabet.moveFrame:SetPoint("TOPLEFT", windowAlphabet, "TOPLEFT", 0, -40)
    windowAlphabet.moveFrame:SetPoint("BOTTOMRIGHT", windowAlphabet, "TOPRIGHT", 0, 5)
    windowAlphabet.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowAlphabet.moveFrame:SetLayer(2)
    --windowAlphabet.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowAlphabet.header = UI.CreateFrame("Text", name .. "header", windowAlphabet.moveFrame)
    windowAlphabet.header:SetFontSize(20)
    windowAlphabet.header:SetText(title)
    windowAlphabet.header:SetFontColor(0,0,0,1)
    windowAlphabet.header:SetPoint("CENTERX", windowAlphabet.moveFrame, "CENTERX")
    windowAlphabet.header:SetPoint("CENTERY", windowAlphabet.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowAlphabet.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowAlphabet:GetLeft()
	    dragStartY = mouse.y - windowAlphabet:GetTop()
	end, "LMouseDown")

	windowAlphabet.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowAlphabet.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowAlphabet:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowAlphabet
  end
end

local AlphabetWindowSettings = {
  TITLE = "Alfiebet",
  WIDTH = 315,
  HEIGHT = 200,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.alphabet_ui.buildAlphabetWindow()
  local x = Dta.settings.get("AlphabetwindowPosX")
  local y = Dta.settings.get("AlphabetwindowPosY")
  Alphabetwindow = Dta.alphabet_ui.createWindowAlphabet("AlphabetWindow",
                               Dta.ui.context,
                               AlphabetWindowSettings.TITLE,
                               AlphabetWindowSettings.WIDTH,
                               AlphabetWindowSettings.HEIGHT,
                               x,
                               y,
                               AlphabetWindowSettings.CLOSABLE,
                               AlphabetWindowSettings.MOVABLE,
                               Dta.alphabet_ui.AlphabetWindowClosed,
                               Dta.alphabet_ui.AlphabetWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                Alphabetwindow.Alphabet = Dta.ui.createFrame("Alphabet", Alphabetwindow, 10, 10, Alphabetwindow:GetWidth()-20, Alphabetwindow:GetHeight()-20)
                                Alphabetwindow.Alphabet:SetLayer(30)
                                --Alphabetwindow.modifyRotation:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                Alphabetwindow.Alphabet.WordLabel2 = Dta.ui.createText("AlphabetWordLabel", Alphabetwindow.Alphabet, 0, 0, Lang[Dta.Language].Text.Word, 14)
                                Alphabetwindow.Alphabet.Word = Dta.ui.createTextfield("AlphabetWord", Alphabetwindow.Alphabet, 55, 0, 235)

                                Alphabetwindow.Alphabet.FontLabel = Dta.ui.createText("AlphabetFontLabel", Alphabetwindow.Alphabet, 0, 30, Lang[Dta.Language].Text.Font, 14)
                                Alphabetwindow.Alphabet.FontLoad = UI.CreateFrame("SimpleSelect", "AlphabetFontLoad", Alphabetwindow.Alphabet)
                                Alphabetwindow.Alphabet.FontLoad:SetPoint("TOPLEFT", Alphabetwindow.Alphabet, "TOPLEFT", 55, 30)
                                Alphabetwindow.Alphabet.FontLoad:SetLayer(100)
                                Alphabetwindow.Alphabet.FontLoad:SetItems(Dta.alphabet.loadFonts())
                                Alphabetwindow.Alphabet.FontLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end
                                Alphabetwindow.Alphabet.FontLoad:ResizeToFit()
                                Alphabetwindow.Alphabet.FontLoad:SetWidth(235)
                                Alphabetwindow.Alphabet.FontLoad:SetEnabled(true)

                                Alphabetwindow.Alphabet.SizeLabel = Dta.ui.createText("AlphabetFontLabel", Alphabetwindow.Alphabet, 0, 60, Lang[Dta.Language].Text.Size, 14)
                                Alphabetwindow.Alphabet.SizeLoad = UI.CreateFrame("SimpleSelect", "AlphabetFontLoad", Alphabetwindow.Alphabet)
                                Alphabetwindow.Alphabet.SizeLoad:SetPoint("TOPLEFT", Alphabetwindow.Alphabet, "TOPLEFT", 55, 60)
                                Alphabetwindow.Alphabet.SizeLoad:SetLayer(100)
                                Alphabetwindow.Alphabet.SizeLoad:SetItems(Dta.alphabet.loadSize())
                                Alphabetwindow.Alphabet.SizeLoad.Event.ItemSelect = function(view, item) Dta.alphabet.SizeSelected(item) end
                                Alphabetwindow.Alphabet.SizeLoad:ResizeToFit()
                                Alphabetwindow.Alphabet.SizeLoad:SetWidth(100)
                                Alphabetwindow.Alphabet.SizeLoad:SetEnabled(true)

                                Alphabetwindow.Alphabet.TypeLabel = Dta.ui.createText("AlphabetTypeLabel", Alphabetwindow.Alphabet, 0, 90, Lang[Dta.Language].Text.Skin, 14)
                                Alphabetwindow.Alphabet.TypeLoad = UI.CreateFrame("SimpleSelect", "AlphabetTypeLoad", Alphabetwindow.Alphabet)
                                Alphabetwindow.Alphabet.TypeLoad:SetPoint("TOPLEFT", Alphabetwindow.Alphabet, "TOPLEFT", 55, 90)
                                Alphabetwindow.Alphabet.TypeLoad:SetLayer(100)
                                Alphabetwindow.Alphabet.TypeLoad:SetItems(Dta.Replacement.loadSkins())
                                Alphabetwindow.Alphabet.TypeLoad.Event.ItemSelect = function(view, item) Dta.alphabet.SkinSelected(item) end
                                Alphabetwindow.Alphabet.TypeLoad:ResizeToFit()
                                Alphabetwindow.Alphabet.TypeLoad:SetWidth(235)
                                Alphabetwindow.Alphabet.TypeLoad:SetEnabled(true)

                                Alphabetwindow.Alphabet.modeHorizontal = Dta.ui.createCheckbox("AlphabetmodeHorizontal", Alphabetwindow.Alphabet, 45, 120, Lang[Dta.Language].Text.Horizontal, true, nil, Dta.alphabet.AlphabetmodeHorizontalChanged)
                                Alphabetwindow.Alphabet.modeVertical = Dta.ui.createCheckbox("AlphabetmodeVertical", Alphabetwindow.Alphabet, 175, 120, Lang[Dta.Language].Text.Vertical, false, nil, Dta.alphabet.AlphabetmodeVerticalChanged)


                                Alphabetwindow.Alphabet.load = Dta.ui.createButton("AlphabetLoad", Alphabetwindow.Alphabet, 0, 150, nil, nil, Lang[Dta.Language].Buttons.LoadWord, nil, Dta.alphabet.alphabetLoadClicked)
                                Alphabetwindow.Alphabet.printReqs = Dta.ui.createButton("AlphabetPrintReqs", Alphabetwindow.Alphabet, 165, 150, nil, nil, Lang[Dta.Language].Buttons.PrintMaterials, nil, Dta.alphabet.alphabetPrintMaterials)



  return Alphabetwindow
end

-- Show the toolbox window
function Dta.alphabet_ui.showAlphabetWindow()
  if Dta.ui.windowAlphabet == nil then
    Dta.ui.windowAlphabet = Dta.alphabet_ui.buildAlphabetWindow()
  else
    Dta.alphabet_ui.windowAlphabet:SetVisible(true)
  end
  Dta.ui.activeAlphabet = true
end

-- Hide the toolbox window
function Dta.alphabet_ui.hideAlphabetWindow()
  Dta.ui.windowAlphabet:SetVisible(false)
  Dta.ui.windowAlphabet.Alphabet.FontLoad:SetEnabled(false)
  Dta.ui.windowAlphabet.Alphabet.SizeLoad:SetEnabled(false)
  Dta.ui.windowAlphabet.Alphabet.TypeLoad:SetEnabled(false)
  Dta.ui.windowAlphabet = nil
  Dta.ui.activeAlphabet = false

end

-- Toggle the toolbox window
function Dta.alphabet_ui.toggleAlphabetWindow()
  if Dta.ui.activeAlphabet then Dta.alphabet_ui.hideAlphabetWindow()
  else Dta.alphabet_ui.showAlphabetWindow() end
end

--Called when the window has been closed
function Dta.alphabet_ui.AlphabetWindowClosed()
  Dta.alphabet_ui.hideAlphabetWindow()
end

--Called when the window has been moved
function Dta.alphabet_ui.AlphabetWindowMoved()
  Dta.settings.set("AlphabetwindowPosX", Alphabetwindow:GetLeft())
  Dta.settings.set("AlphabetwindowPosY", Alphabetwindow:GetTop())
end
