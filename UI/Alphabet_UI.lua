local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.alphabet_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS AlphabetWINDOW
-------------------------------

local AlphabetWindowSettings = {
	TITLE = "Alfiebet",
	WIDTH = 315,
	HEIGHT = 195,
	CLOSABLE = true,
	MOVABLE = true,
}

function Dta.alphabet_ui.buildAlphabetWindow()
	local x = Dta.settings.get("AlphabetwindowPosX")
	local y = Dta.settings.get("AlphabetwindowPosY")
	local newWindow = Dta.ui.Window.Create("AlphabetWindow",
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
	local Alphabetwindow = newWindow.content

	Alphabetwindow.background2 = UI.CreateFrame("Texture", "AlphabetWindowBackground2", Alphabetwindow)
	Alphabetwindow.background2:SetPoint("BOTTOMCENTER", Alphabetwindow, "BOTTOMCENTER")
	Alphabetwindow.background2:SetWidth(AlphabetWindowSettings.WIDTH)
	Alphabetwindow.background2:SetHeight(80)
	Alphabetwindow.background2:SetAlpha(0.3)
	Alphabetwindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	Alphabetwindow.background2:SetLayer(5)

	-------------------------------
	--ITEM DETAILS
	-------------------------------
	Alphabetwindow.Alphabet = Dta.ui.createFrame("Alphabet", Alphabetwindow, 10, 5, Alphabetwindow:GetWidth()-20, Alphabetwindow:GetHeight()-20)
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

	-- TODO: temp fix for new window hierarchy
	newWindow.Alphabet = Alphabetwindow.Alphabet
	return newWindow
end

-- Show the toolbox window
function Dta.alphabet_ui.showAlphabetWindow()
	if Dta.ui.windowAlphabet == nil then
		Dta.ui.windowAlphabet = Dta.alphabet_ui.buildAlphabetWindow()
	else
		Dta.ui.windowAlphabet:SetVisible(true)
	end
	Dta.ui.activeAlphabet = true
end

-- Hide the toolbox window
function Dta.alphabet_ui.hideAlphabetWindow()
	Dta.ui.windowAlphabet:SetVisible(false)
	Dta.ui.windowAlphabet.Alphabet.FontLoad:SetEnabled(false)
	Dta.ui.windowAlphabet.Alphabet.SizeLoad:SetEnabled(false)
	Dta.ui.windowAlphabet.Alphabet.TypeLoad:SetEnabled(false)
--	Dta.ui.windowAlphabet = nil
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
	Dta.settings.set("AlphabetwindowPosX", Dta.ui.windowAlphabet:GetLeft())
	Dta.settings.set("AlphabetwindowPosY", Dta.ui.windowAlphabet:GetTop())
end
