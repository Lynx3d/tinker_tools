local Dta = select(2, ...)

Dta.losa_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS LoSaWINDOW
-------------------------------

local LoSaWindowSettings = {
	WIDTH = 325,
	HEIGHT = 330,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "LoSawindowPosX",
	POS_Y = "LoSawindowPosY"
}

function Dta.losa_ui.buildLoSaWindow()
	local x = Dta.settings.get("LoSawindowPosX")
	local y = Dta.settings.get("LoSawindowPosY")
	local newWindow = Dta.ui.Window.Create("LoSaWindow",
							Dta.ui.context,
							Dta.Locale.Titles.LoadSave,
							LoSaWindowSettings.WIDTH,
							LoSaWindowSettings.HEIGHT,
							x,
							y,
							LoSaWindowSettings.CLOSABLE,
							LoSaWindowSettings.MOVABLE,
							Dta.losa_ui.hideLoSaWindow,
							Dta.ui.WindowMoved
							)
	newWindow.settings = LoSaWindowSettings
	local LoSawindow = newWindow.content

	LoSawindow.background2 = UI.CreateFrame("Texture", "LoSaWindowBackground2", LoSawindow)
	LoSawindow.background2:SetPoint("BOTTOMCENTER", LoSawindow, "BOTTOMCENTER")
	LoSawindow.background2:SetWidth(LoSaWindowSettings.WIDTH)
	LoSawindow.background2:SetHeight(80)
	LoSawindow.background2:SetAlpha(0.3)
	LoSawindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	LoSawindow.background2:SetLayer(5)

	-------------------------------
	--ITEM DETAILS
	-------------------------------
	local loadSave = Dta.ui.createFrame("constructions", LoSawindow, 10, 5, LoSawindow:GetWidth()-20, LoSawindow:GetHeight()-20)
	loadSave:SetLayer(30)
	--loadSave:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	loadSave.nameLabel = Dta.ui.createText("constructionsNameLabel", loadSave, 0, 0, Dta.Locale.Text.Name, 14)
	loadSave.name = Dta.ui.createTextfield("constructionsName", loadSave, 55, 0, 245)
	loadSave.save = Dta.ui.createButton("constructionsSave", loadSave, 0, 25, nil, nil, Dta.Locale.Buttons.SaveSet, nil, Dta.losa.constructionSaveClicked)
	loadSave.ImpExpBtn = Dta.ui.createButton("constructionsImpExpBtn", loadSave, 145, 25, 160, nil, Dta.Locale.Buttons.ImportExport, nil, Dta.Tools.ExpImp.Toggle)

	loadSave.divider1 = Dta.ui.createTexture("LoSa_divider1", loadSave, "Rift", "divider_06.png.dds", 0, 55, loadSave:GetWidth())

	loadSave.loadDeafaultSets = Dta.ui.createCheckbox("constructionLoadDeafaultSets", loadSave, 0, 75, Dta.Locale.Text.DefaultSets, true, nil, Dta.losa.constructionLoadDeafaultSetsChanged)
	loadSave.loadSavedSets = Dta.ui.createCheckbox("constructionLoadSavedSets", loadSave, 100, 75, Dta.Locale.Text.SavedSets, false, nil, Dta.losa.constructionLoadSavedSetsChanged)
	loadSave.loadTbxSets = Dta.ui.createCheckbox("constructionLoadTbxSets", loadSave, 210, 75, Dta.Locale.Text.TbxSets, false, nil, Dta.losa.constructionLoadTbxSetsChanged)

	loadSave.searchLabel = Dta.ui.createText("constructionsSearchLabel", loadSave, 0, 105, Dta.Locale.Text.Search, 14)
	loadSave.search = Dta.ui.createTextfield("constructionsSearch", loadSave, 55, 105, 245)
	loadSave.search:EventAttach(Event.UI.Input.Key.Up, Dta.losa.constructionSearchKeyUp, "LoSa_SearchApply")

	loadSave.nameLabel2 = Dta.ui.createText("constructionsNameLabel2", loadSave, 0, 130, Dta.Locale.Text.Name, 14)
	loadSave.nameLoad = Dta.ui.createDropdown("constructionsNameSelect", loadSave, 55, 130, 245)
	loadSave.nameLoad:SetItems(Dta.losa.loadConstructions())

	loadSave.load = Dta.ui.createButton("constructionsLoad", loadSave, 0, 185, nil, nil, Dta.Locale.Buttons.LoadSet, nil, Dta.losa.constructionLoadClicked)
	loadSave.remove = Dta.ui.createButton("constructionsRemove", loadSave, 0, 220, nil, nil, Dta.Locale.Buttons.RemoveSet, nil, Dta.losa.constructionRemoveClicked)
	loadSave.remove:SetVisible(false)
	loadSave.printReqs = Dta.ui.createButton("constructionsPrintReqs", loadSave, 165, 185, nil, nil, Dta.Locale.Buttons.PrintMaterials, nil, Dta.losa.constructionPrintMaterials)
	loadSave.toClipboard = Dta.ui.createButton("constructionsToClipboard", loadSave, 165, 220, nil, nil, Dta.Locale.Buttons.ToClipboard, nil, Dta.losa.constructionToClipboard)

	loadSave.loadAtOriginalLoc = Dta.ui.createCheckbox("constructionLoadAtOriginalLoc", loadSave, 135, 160, Dta.Locale.Text.LoadOrigionalLocation, false)
	loadSave.loadAtOriginalLoc:SetVisible(false)
	loadSave.LoadNewItems = Dta.ui.createCheckbox("constructionLoadNewItems", loadSave, 0, 160, Dta.Locale.Text.UseNewItems, false, nil)
	loadSave.LoadNewItems:SetVisible(true)

	loadSave.divider2 = Dta.ui.createTexture("LoSa_divider2", loadSave, "Rift", "divider_06.png.dds", 0, 250, loadSave:GetWidth())

	loadSave.useReferencePoint = Dta.ui.createCheckbox("LoSaUseReference", loadSave, 0, 270, Dta.Locale.Text.UseRefPoint, false, nil, Dta.losa.useReferencePointChanged)

	loadSave.referencePick = Dta.ui.createButton("pickRefPointBtn", loadSave, 165, 262, nil, nil, Dta.Locale.Buttons.Pick, nil, Dta.losa.pickButtonClicked)
	loadSave.referencePick:SetVisible(false)

	loadSave.refPointCoords = Dta.ui.createText("constructionsNameLabel", loadSave, 15, 295, "x: - y: - z: -", 14)
	loadSave.refPointCoords:SetAlpha(0.5)

	-- "abuse" cycle function for clearing input focus on 'return' key
	loadSave.name:EventAttach(Event.UI.Input.Key.Down, Dta.ui.FocusCycleCallback, "Losa_TabFocusCycle")
	-- TODO: temp fix for new window hierarchy
	newWindow.constructions = loadSave
	return newWindow
end

-- Show the toolbox window
function Dta.losa_ui.showLoSaWindow(losa_window)
	losa_window:SetVisible(true)
	losa_window.constructions.nameLoad:SetEnabled(true)
end

-- Hide the toolbox window
function Dta.losa_ui.hideLoSaWindow(losa_window)
	losa_window:SetVisible(false)
	losa_window:ClearKeyFocus()
	losa_window.constructions.nameLoad:SetEnabled(false)
end

Dta.RegisterTool("LoSa", Dta.losa_ui.buildLoSaWindow, Dta.losa_ui.showLoSaWindow, Dta.losa_ui.hideLoSaWindow)
