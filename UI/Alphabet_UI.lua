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

function Dta.alphabet_ui.buildWindow()
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
							Dta.alphabet_ui.hideWindow,
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
	Alphabetwindow.Alphabet.FontLoad = Dta.ui.createDropdown("AlphabetFontLoad", Alphabetwindow.Alphabet, 70, 30, 220)
	Alphabetwindow.Alphabet.FontLoad:SetItems(Dta.alphabet.loadFonts())
	Alphabetwindow.Alphabet.FontLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end

	Alphabetwindow.Alphabet.SizeLabel = Dta.ui.createText("AlphabetSizeLabel", Alphabetwindow.Alphabet, 0, 60, Dta.Locale.Text.Size, 14)
	Alphabetwindow.Alphabet.SizeLoad = Dta.ui.createDropdown("AlphabetSizeLoad", Alphabetwindow.Alphabet, 70, 60, 100)
	Alphabetwindow.Alphabet.SizeLoad:SetItems(Dta.alphabet.loadSize())

	Alphabetwindow.Alphabet.TypeLabel = Dta.ui.createText("AlphabetTypeLabel", Alphabetwindow.Alphabet, 0, 90, Dta.Locale.Text.Skin, 14)
	Alphabetwindow.Alphabet.TypeLoad = Dta.ui.createDropdown("AlphabetTypeLoad", Alphabetwindow.Alphabet, 70, 90, 220)
	Alphabetwindow.Alphabet.TypeLoad:SetItems(Dta.Replacement.loadAlphabetSkins())

	Alphabetwindow.Alphabet.modeHorizontal = Dta.ui.createCheckbox("AlphabetmodeHorizontal", Alphabetwindow.Alphabet, 10, 120, Dta.Locale.Text.Horizontal, true, nil, Dta.alphabet.AlphabetmodeHorizontalChanged)
	Alphabetwindow.Alphabet.modeVertical = Dta.ui.createCheckbox("AlphabetmodeVertical", Alphabetwindow.Alphabet, 170, 120, Dta.Locale.Text.Vertical, false, nil, Dta.alphabet.AlphabetmodeVerticalChanged)

	Alphabetwindow.Alphabet.load = Dta.ui.createButton("AlphabetLoad", Alphabetwindow.Alphabet, 0, 150, nil, nil, Dta.Locale.Buttons.LoadWord, nil, Dta.alphabet.AlphabetLoadClicked)
	Alphabetwindow.Alphabet.printReqs = Dta.ui.createButton("AlphabetPrintReqs", Alphabetwindow.Alphabet, 165, 150, nil, nil, Dta.Locale.Buttons.PrintMaterials, nil, Dta.alphabet.AlphabetPrintMaterials)

	-- TODO: temp fix for new window hierarchy
	newWindow.Alphabet = Alphabetwindow.Alphabet
	return newWindow
end

-- Show the toolbox window
function Dta.alphabet_ui.showWindow(ab_window)
	ab_window:SetVisible(true)
	ab_window.Alphabet.FontLoad:SetEnabled(true)
	ab_window.Alphabet.SizeLoad:SetEnabled(true)
	ab_window.Alphabet.TypeLoad:SetEnabled(true)
end

-- Hide the toolbox window
function Dta.alphabet_ui.hideWindow(ab_window)
	ab_window:SetVisible(false)
	ab_window.Alphabet.FontLoad:SetEnabled(false)
	ab_window.Alphabet.SizeLoad:SetEnabled(false)
	ab_window.Alphabet.TypeLoad:SetEnabled(false)
end

Dta.RegisterTool("Alfiebet", Dta.alphabet_ui.buildWindow, Dta.alphabet_ui.showWindow, Dta.alphabet_ui.hideWindow)
