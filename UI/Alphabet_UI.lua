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
	local alphabet = Dta.ui.createFrame("Alphabet", Alphabetwindow, 10, 5, Alphabetwindow:GetWidth()-20, Alphabetwindow:GetHeight()-20)
	alphabet:SetLayer(30)
	--Alphabetwindow.modifyRotation:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	alphabet.WordLabel2 = Dta.ui.createText("AlphabetWordLabel", alphabet, 0, 0, Dta.Locale.Text.Word, 14)
	alphabet.Word = Dta.ui.createTextfield("AlphabetWord", alphabet, 70, 0, 220)

	alphabet.FontLabel = Dta.ui.createText("AlphabetFontLabel", alphabet, 0, 25, Dta.Locale.Text.Font, 14)
	alphabet.FontLoad = Dta.ui.createDropdown("AlphabetFontLoad", alphabet, 70, 25, 220)
	alphabet.FontLoad:SetItems(Dta.alphabet.loadFonts())
	alphabet.FontLoad.Event.ItemSelect = function(view, item) Dta.alphabet.FontSelected(item) end

	alphabet.SizeLabel = Dta.ui.createText("AlphabetSizeLabel", alphabet, 0, 50, Dta.Locale.Text.Size, 14)
	alphabet.SizeLoad = Dta.ui.createDropdown("AlphabetSizeLoad", alphabet, 70, 50, 100)
	alphabet.SizeLoad:SetItems(Dta.alphabet.loadSize())

	alphabet.FilterLabel = Dta.ui.createText("AlphabetSkinFilter", alphabet, 0, 75, Dta.Locale.Text.Category, 14)
	alphabet.FilterSelect = Dta.ui.createDropdown("AlphabetCategorySelect", alphabet, 70, 75, 220)
	alphabet.FilterSelect:SetItems(Dta.Replacement.loadSkinCategories())
	alphabet.FilterSelect:SetSelectedIndex(1)
	alphabet.FilterSelect.Event.ItemSelect = Dta.alphabet.FilterChanged
	alphabet.TypeLabel = Dta.ui.createText("AlphabetTypeLabel", alphabet, 0, 100, Dta.Locale.Text.Skin, 14)
	alphabet.TypeLoad = Dta.ui.createDropdown("AlphabetTypeLoad", alphabet, 70, 100, 220)
	alphabet.TypeLoad:SetItems(Dta.Replacement.loadAlphabetSkins())

	alphabet.modeHorizontal = Dta.ui.createCheckbox("AlphabetmodeHorizontal", alphabet, 10, 125, Dta.Locale.Text.Horizontal, true, nil, Dta.alphabet.AlphabetmodeHorizontalChanged)
	alphabet.modeVertical = Dta.ui.createCheckbox("AlphabetmodeVertical", alphabet, 170, 125, Dta.Locale.Text.Vertical, false, nil, Dta.alphabet.AlphabetmodeVerticalChanged)

	alphabet.load = Dta.ui.createButton("AlphabetLoad", alphabet, 0, 150, nil, nil, Dta.Locale.Buttons.LoadWord, nil, Dta.alphabet.AlphabetLoadClicked)
	alphabet.printReqs = Dta.ui.createButton("AlphabetPrintReqs", alphabet, 165, 150, nil, nil, Dta.Locale.Buttons.PrintMaterials, nil, Dta.alphabet.AlphabetPrintMaterials)

	newWindow.Alphabet = alphabet
	return newWindow
end

-- Show the toolbox window
function Dta.alphabet_ui.showWindow(ab_window)
	ab_window:SetVisible(true)
	ab_window.Alphabet.FontLoad:SetEnabled(true)
	ab_window.Alphabet.SizeLoad:SetEnabled(true)
	ab_window.Alphabet.FilterSelect:SetEnabled(true)
	ab_window.Alphabet.TypeLoad:SetEnabled(true)
end

-- Hide the toolbox window
function Dta.alphabet_ui.hideWindow(ab_window)
	ab_window:SetVisible(false)
	ab_window.Alphabet.FontLoad:SetEnabled(false)
	ab_window.Alphabet.SizeLoad:SetEnabled(false)
	ab_window.Alphabet.FilterSelect:SetEnabled(false)
	ab_window.Alphabet.TypeLoad:SetEnabled(false)
end

Dta.RegisterTool("Alfiebet", Dta.alphabet_ui.buildWindow, Dta.alphabet_ui.showWindow, Dta.alphabet_ui.hideWindow)
