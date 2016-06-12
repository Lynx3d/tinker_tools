local Dta = select(2, ...)

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
	POS_X = "AlphabetwindowPosX",
	POS_Y = "AlphabetwindowPosY"
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
							Dta.ui.WindowMoved
							)
	newWindow.settings = AlphabetWindowSettings
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

	Alphabetwindow.Alphabet.WordLabel2 = Dta.ui.createText("AlphabetWordLabel", Alphabetwindow.Alphabet, 0, 0, Dta.Locale.Text.Word, 14)
	Alphabetwindow.Alphabet.Word = Dta.ui.createTextfield("AlphabetWord", Alphabetwindow.Alphabet, 70, 0, 220)

	Alphabetwindow.Alphabet.FontLabel = Dta.ui.createText("AlphabetFontLabel", Alphabetwindow.Alphabet, 0, 30, Dta.Locale.Text.Font, 14)
	Alphabetwindow.Alphabet.FontLoad = UI.CreateFrame("SimpleSelect", "AlphabetFontLoad", Alphabetwindow.Alphabet)
	Alphabetwindow.Alphabet.FontLoad:SetPoint("TOPLEFT", Alphabetwindow.Alphabet, "TOPLEFT", 70, 30)
	Alphabetwindow.Alphabet.FontLoad:SetLayer(100)
	Alphabetwindow.Alphabet.FontLoad:SetItems(Dta.alphabet.loadFonts())
	Alphabetwindow.Alphabet.FontLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end
	Alphabetwindow.Alphabet.FontLoad:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	Alphabetwindow.Alphabet.FontLoad:SetWidth(220)

	Alphabetwindow.Alphabet.SizeLabel = Dta.ui.createText("AlphabetFontLabel", Alphabetwindow.Alphabet, 0, 60, Dta.Locale.Text.Size, 14)
	Alphabetwindow.Alphabet.SizeLoad = UI.CreateFrame("SimpleSelect", "AlphabetFontLoad", Alphabetwindow.Alphabet)
	Alphabetwindow.Alphabet.SizeLoad:SetPoint("TOPLEFT", Alphabetwindow.Alphabet, "TOPLEFT", 70, 60)
	Alphabetwindow.Alphabet.SizeLoad:SetLayer(100)
	Alphabetwindow.Alphabet.SizeLoad:SetItems(Dta.alphabet.loadSize())
	--Alphabetwindow.Alphabet.SizeLoad.Event.ItemSelect = function(view, item) Dta.alphabet.SizeSelected(item) end
	Alphabetwindow.Alphabet.SizeLoad:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	Alphabetwindow.Alphabet.SizeLoad:SetWidth(100)

	Alphabetwindow.Alphabet.TypeLabel = Dta.ui.createText("AlphabetTypeLabel", Alphabetwindow.Alphabet, 0, 90, Dta.Locale.Text.Skin, 14)
	Alphabetwindow.Alphabet.TypeLoad = UI.CreateFrame("SimpleSelect", "AlphabetTypeLoad", Alphabetwindow.Alphabet)
	Alphabetwindow.Alphabet.TypeLoad:SetPoint("TOPLEFT", Alphabetwindow.Alphabet, "TOPLEFT", 70, 90)
	Alphabetwindow.Alphabet.TypeLoad:SetLayer(100)
	Alphabetwindow.Alphabet.TypeLoad:SetItems(Dta.Replacement.loadAlphabetSkins())
	--Alphabetwindow.Alphabet.TypeLoad.Event.ItemSelect = function(view, item) Dta.alphabet.SkinSelected(item) end
	Alphabetwindow.Alphabet.TypeLoad:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	Alphabetwindow.Alphabet.TypeLoad:SetWidth(220)

	Alphabetwindow.Alphabet.modeHorizontal = Dta.ui.createCheckbox("AlphabetmodeHorizontal", Alphabetwindow.Alphabet, 10, 120, Dta.Locale.Text.Horizontal, true, nil, Dta.alphabet.AlphabetmodeHorizontalChanged)
	Alphabetwindow.Alphabet.modeVertical = Dta.ui.createCheckbox("AlphabetmodeVertical", Alphabetwindow.Alphabet, 170, 120, Dta.Locale.Text.Vertical, false, nil, Dta.alphabet.AlphabetmodeVerticalChanged)

	Alphabetwindow.Alphabet.load = Dta.ui.createButton("AlphabetLoad", Alphabetwindow.Alphabet, 0, 150, nil, nil, Dta.Locale.Buttons.LoadWord, nil, Dta.alphabet.AlphabetLoadClicked)
	Alphabetwindow.Alphabet.printReqs = Dta.ui.createButton("AlphabetPrintReqs", Alphabetwindow.Alphabet, 165, 150, nil, nil, Dta.Locale.Buttons.PrintMaterials, nil, Dta.alphabet.AlphabetPrintMaterials)

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
		Dta.ui.windowAlphabet.Alphabet.FontLoad:SetEnabled(true)
		Dta.ui.windowAlphabet.Alphabet.SizeLoad:SetEnabled(true)
		Dta.ui.windowAlphabet.Alphabet.TypeLoad:SetEnabled(true)
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
