local Dta = select(2, ...)

Dta.losa_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS LoSaWINDOW
-------------------------------

local LoSaWindowSettings = {
	WIDTH = 325,
	HEIGHT = 345,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "LoSawindowPosX",
	POS_Y = "LoSawindowPosY"
}

function Dta.losa_ui.buildLoSaWindow()
	local x = Dta.settings.get("LoSawindowPosX")
	local y = Dta.settings.get("LoSawindowPosY")
	newWindow = Dta.ui.Window.Create("LoSaWindow",
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

	loadSave.divider1 = Dta.ui.createTexture("LoSa_divider1", loadSave, "Rift", "divider_06.png.dds", 0, 55, LoSawindow:GetWidth())

	loadSave.loadDeafaultSets = Dta.ui.createCheckbox("constructionLoadDeafaultSets", loadSave, 0, 85, Dta.Locale.Text.DefaultSets, true, nil, Dta.losa.constructionLoadDeafaultSetsChanged)
	loadSave.loadSavedSets = Dta.ui.createCheckbox("constructionLoadSavedSets", loadSave, 100, 85, Dta.Locale.Text.SavedSets, false, nil, Dta.losa.constructionLoadSavedSetsChanged)
	loadSave.loadTbxSets = Dta.ui.createCheckbox("constructionLoadTbxSets", loadSave, 210, 85, Dta.Locale.Text.TbxSets, false, nil, Dta.losa.constructionLoadTbxSetsChanged)

	loadSave.searchLabel = Dta.ui.createText("constructionsSearchLabel", loadSave, 0, 115, Dta.Locale.Text.Search, 14)
	loadSave.search = Dta.ui.createTextfield("constructionsSearch", loadSave, 55, 115, 245)
	loadSave.search:EventAttach(Event.UI.Input.Key.Up, Dta.losa.constructionSearchKeyUp, "LoSa_SearchApply")

	loadSave.nameLabel2 = Dta.ui.createText("constructionsNameLabel2", loadSave, 0, 140, Dta.Locale.Text.Name, 14)
	loadSave.nameLoad = Dta.ui.createDropdown("constructionsNameSelect", loadSave, 55, 140, 245)
	loadSave.nameLoad:SetItems(Dta.losa.loadConstructions())

	loadSave.load = Dta.ui.createButton("constructionsLoad", loadSave, 0, 195, nil, nil, Dta.Locale.Buttons.LoadSet, nil, Dta.losa.constructionLoadClicked)
	loadSave.remove = Dta.ui.createButton("constructionsRemove", loadSave, 0, 230, nil, nil, Dta.Locale.Buttons.RemoveSet, nil, Dta.losa.constructionRemoveClicked)
	loadSave.remove:SetVisible(false)
	loadSave.printReqs = Dta.ui.createButton("constructionsPrintReqs", loadSave, 165, 195, nil, nil, Dta.Locale.Buttons.PrintMaterials, nil, Dta.losa.constructionPrintMaterials)
	loadSave.toClipboard = Dta.ui.createButton("constructionsToClipboard", loadSave, 165, 230, nil, nil, Dta.Locale.Buttons.ToClipboard, nil, Dta.losa.constructionToClipboard)

	loadSave.loadAtOriginalLoc = Dta.ui.createCheckbox("constructionLoadAtOriginalLoc", loadSave, 135, 170, Dta.Locale.Text.LoadOrigionalLocation, false)
	loadSave.loadAtOriginalLoc:SetVisible(false)
	loadSave.LoadNewItems = Dta.ui.createCheckbox("constructionLoadNewItems", loadSave, 0, 170, Dta.Locale.Text.UseNewItems, false, nil, Dta.losa.constructionLoadNewItemsChanged)
	loadSave.LoadNewItems:SetVisible(true)

	loadSave.LoadMultipleSets = Dta.ui.createCheckbox("constructionLoadMultipleSets", loadSave, 0, 265, Dta.Locale.Text.MultiCopies, false, nil, Dta.losa.constructionLoadMultipleSetsChanged)
	loadSave.LoadMultipleSets:SetVisible(false)

	loadSave.NrCopiesLabel = Dta.ui.createText("constructionsNrCopiesLabel", loadSave, 0, 290, Dta.Locale.Text.NrCopies, 14)
	loadSave.NrCopiesLabel:SetVisible(false)
	loadSave.OffsetLabel = Dta.ui.createText("constructionsOffsetLabel", loadSave, 0, 315, Dta.Locale.Text.Offset, 14)
	loadSave.OffsetLabel:SetVisible(false)
	loadSave.xLabel = Dta.ui.createText("constructionsXLabel", loadSave, 70, 315, "X", 14, {1, 0, 0, 1})
	loadSave.xLabel:SetVisible(false)
	loadSave.yLabel = Dta.ui.createText("constructionsYLabel", loadSave, 155, 315, "Y", 14, {0, 1, 0, 1})
	loadSave.yLabel:SetVisible(false)
	loadSave.zLabel = Dta.ui.createText("constructionsZLabel", loadSave, 240, 315, "Z", 14, {0, 1, 1, 1})
	loadSave.zLabel:SetVisible(false)

	loadSave.NrCopies = Dta.ui.createTextfield("constructionsNrCopies", loadSave, 90, 290, 40)
	loadSave.NrCopies:SetVisible(false)
	loadSave.x = Dta.ui.createTextfield("constructionsX", loadSave, 90, 315, 40)
	loadSave.x:SetVisible(false)
	loadSave.y = Dta.ui.createTextfield("constructionsY", loadSave, 175, 315, 40)
	loadSave.y:SetVisible(false)
	loadSave.z = Dta.ui.createTextfield("mconstructionsZ", loadSave, 260, 315, 40)
	loadSave.z:SetVisible(false)

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
