local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.losa_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS LoSaWINDOW
-------------------------------

local LoSaWindowSettings = {
	WIDTH = 325,
	HEIGHT = 345,
	CLOSABLE = true,
	MOVABLE = true,
}

function Dta.losa_ui.buildLoSaWindow()
	local x = Dta.settings.get("LoSawindowPosX")
	local y = Dta.settings.get("LoSawindowPosY")
	newWindow = Dta.ui.Window.Create("LoSaWindow",
							Dta.ui.context,
							Lang[Dta.Language].Titles.LoadSave,
							LoSaWindowSettings.WIDTH,
							LoSaWindowSettings.HEIGHT,
							x,
							y,
							LoSaWindowSettings.CLOSABLE,
							LoSaWindowSettings.MOVABLE,
							Dta.losa_ui.LoSaWindowClosed,
							Dta.losa_ui.LoSaWindowMoved
							)
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
	LoSawindow.constructions = Dta.ui.createFrame("constructions", LoSawindow, 10, 5, LoSawindow:GetWidth()-20, LoSawindow:GetHeight()-20)
	LoSawindow.constructions:SetLayer(30)
	--LoSawindow.constructions:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	LoSawindow.constructions.nameLabel = Dta.ui.createText("constructionsNameLabel", LoSawindow.constructions, 0, 0, Lang[Dta.Language].Text.Name, 14)
	LoSawindow.constructions.name = Dta.ui.createTextfield("constructionsName", LoSawindow.constructions, 55, 0, 245)
	LoSawindow.constructions.save = Dta.ui.createButton("constructionsSave", LoSawindow.constructions, 0, 25, nil, nil, Lang[Dta.Language].Buttons.SaveSet, nil, Dta.losa.constructionSaveClicked)
	LoSawindow.constructions.ImpExpBtn = Dta.ui.createButton("constructionsImpExpBtn", LoSawindow.constructions, 145, 25, 160, nil, Lang[Dta.Language].Buttons.ImportExport, nil, Dta.ui.modifyImpExpButtonClicked)

	LoSawindow.divider5 = Dta.ui.createTexture("divider5", LoSawindow, Dta.AddonID, "textures/divider.png", 10, 70, LoSawindow:GetWidth()-10)
	LoSawindow.divider5:SetLayer(29)

	LoSawindow.constructions.loadDeafaultSets = Dta.ui.createCheckbox("constructionLoadDeafaultSets", LoSawindow.constructions, 0, 85, Lang[Dta.Language].Text.DefaultSets, true, nil, Dta.losa.constructionLoadDeafaultSetsChanged)
	LoSawindow.constructions.loadSavedSets = Dta.ui.createCheckbox("constructionLoadSavedSets", LoSawindow.constructions, 100, 85, Lang[Dta.Language].Text.SavedSets, false, nil, Dta.losa.constructionLoadSavedSetsChanged)
	LoSawindow.constructions.loadTbxSets = Dta.ui.createCheckbox("constructionLoadTbxSets", LoSawindow.constructions, 210, 85, Lang[Dta.Language].Text.TbxSets, false, nil, Dta.losa.constructionLoadTbxSetsChanged)

	LoSawindow.constructions.searchLabel = Dta.ui.createText("constructionsSearchLabel", LoSawindow.constructions, 0, 115, Lang[Dta.Language].Text.Search, 14)
	LoSawindow.constructions.search = Dta.ui.createTextfield("constructionsSearch", LoSawindow.constructions, 55, 115, 245)
	LoSawindow.constructions.search:EventAttach(Event.UI.Input.Key.Up, Dta.losa.constructionSearchKeyUp, "LoSa_SearchApply")

	LoSawindow.constructions.nameLabel2 = Dta.ui.createText("constructionsNameLabel2", LoSawindow.constructions, 0, 140, Lang[Dta.Language].Text.Name, 14)
	LoSawindow.constructions.nameLoad = UI.CreateFrame("SimpleSelect", "constructionsNameSelect", LoSawindow.constructions)
	LoSawindow.constructions.nameLoad:SetPoint("TOPLEFT", LoSawindow.constructions, "TOPLEFT", 55, 140)
	LoSawindow.constructions.nameLoad:SetLayer(100)
	LoSawindow.constructions.nameLoad:SetItems(Dta.losa.loadConstructions())
	LoSawindow.constructions.nameLoad:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	LoSawindow.constructions.nameLoad:SetWidth(245)
	LoSawindow.constructions.nameLoad:SetEnabled(true)

	LoSawindow.constructions.load = Dta.ui.createButton("constructionsLoad", LoSawindow.constructions, 0, 195, nil, nil, Lang[Dta.Language].Buttons.LoadSet, nil, Dta.losa.constructionLoadClicked)
	LoSawindow.constructions.remove = Dta.ui.createButton("constructionsRemove", LoSawindow.constructions, 0, 230, nil, nil, Lang[Dta.Language].Buttons.RemoveSet, nil, Dta.losa.constructionRemoveClicked)
	LoSawindow.constructions.remove:SetVisible(false)
	LoSawindow.constructions.printReqs = Dta.ui.createButton("constructionsPrintReqs", LoSawindow.constructions, 165, 195, nil, nil, Lang[Dta.Language].Buttons.PrintMaterials, nil, Dta.losa.constructionPrintMaterials)
	LoSawindow.constructions.toClipboard = Dta.ui.createButton("constructionsToClipboard", LoSawindow.constructions, 165, 230, nil, nil, Lang[Dta.Language].Buttons.ToClipboard, nil, Dta.losa.constructionToClipboard)

	LoSawindow.constructions.loadAtOriginalLoc = Dta.ui.createCheckbox("constructionLoadAtOriginalLoc", LoSawindow.constructions, 135, 170, Lang[Dta.Language].Text.LoadOrigionalLocation, false)
	LoSawindow.constructions.loadAtOriginalLoc:SetVisible(false)
	LoSawindow.constructions.LoadNewItems = Dta.ui.createCheckbox("constructionLoadNewItems", LoSawindow.constructions, 0, 170, Lang[Dta.Language].Text.UseNewItems, false, nil, Dta.losa.constructionLoadNewItemsChanged)
	LoSawindow.constructions.LoadNewItems:SetVisible(true)

	LoSawindow.constructions.LoadMultipleSets = Dta.ui.createCheckbox("constructionLoadMultipleSets", LoSawindow.constructions, 0, 265, Lang[Dta.Language].Text.MultiCopies, false, nil, Dta.losa.constructionLoadMultipleSetsChanged)
	LoSawindow.constructions.LoadMultipleSets:SetVisible(false)

	LoSawindow.constructions.NrCopiesLabel = Dta.ui.createText("constructionsNrCopiesLabel", LoSawindow.constructions, 0, 290, Lang[Dta.Language].Text.NrCopies, 14)
	LoSawindow.constructions.NrCopiesLabel:SetVisible(false)
	LoSawindow.constructions.OffsetLabel = Dta.ui.createText("constructionsOffsetLabel", LoSawindow.constructions, 0, 315, Lang[Dta.Language].Text.Offset, 14)
	LoSawindow.constructions.OffsetLabel:SetVisible(false)
	LoSawindow.constructions.xLabel = Dta.ui.createText("constructionsXLabel", LoSawindow.constructions, 70, 315, "X", 14, {1, 0, 0, 1})
	LoSawindow.constructions.xLabel:SetVisible(false)
	LoSawindow.constructions.yLabel = Dta.ui.createText("constructionsYLabel", LoSawindow.constructions, 155, 315, "Y", 14, {0, 1, 0, 1})
	LoSawindow.constructions.yLabel:SetVisible(false)
	LoSawindow.constructions.zLabel = Dta.ui.createText("constructionsZLabel", LoSawindow.constructions, 240, 315, "Z", 14, {0, 1, 1, 1})
	LoSawindow.constructions.zLabel:SetVisible(false)

	LoSawindow.constructions.NrCopies = Dta.ui.createTextfield("constructionsNrCopies", LoSawindow.constructions, 90, 290, 40)
	LoSawindow.constructions.NrCopies:SetVisible(false)
	LoSawindow.constructions.x = Dta.ui.createTextfield("constructionsX", LoSawindow.constructions, 90, 315, 40)
	LoSawindow.constructions.x:SetVisible(false)
	LoSawindow.constructions.y = Dta.ui.createTextfield("constructionsY", LoSawindow.constructions, 175, 315, 40)
	LoSawindow.constructions.y:SetVisible(false)
	LoSawindow.constructions.z = Dta.ui.createTextfield("mconstructionsZ", LoSawindow.constructions, 260, 315, 40)
	LoSawindow.constructions.z:SetVisible(false)

	-- TODO: temp fix for new window hierarchy
	newWindow.constructions = LoSawindow.constructions
	return newWindow
end

-- Show the toolbox window
function Dta.losa_ui.showLoSaWindow()
	if Dta.ui.windowLoSa == nil then
		Dta.ui.windowLoSa = Dta.losa_ui.buildLoSaWindow()
	else
		Dta.ui.windowLoSa:SetVisible(true)
		Dta.ui.windowLoSa.constructions.nameLoad:SetEnabled(true)
	end
	Dta.ui.activeLoSa = true
end

-- Hide the toolbox window
function Dta.losa_ui.hideLoSaWindow()
	Dta.ui.windowLoSa:SetVisible(false)
	Dta.ui.windowLoSa:ClearKeyFocus()
	Dta.ui.windowLoSa.constructions.nameLoad:SetEnabled(false)
--	Dta.ui.windowLoSa = nil
--	Dta.ui.loadLoSa = "Default"
	--Dta.constructions = {}
	--Dta.constructionsdefaults = {}
	Dta.ui.activeLoSa = false
end

-- Toggle the toolbox window
function Dta.losa_ui.toggleLoSaWindow()
	if Dta.ui.activeLoSa then Dta.losa_ui.hideLoSaWindow()
	else Dta.losa_ui.showLoSaWindow() end
end

--Called when the window has been closed
function Dta.losa_ui.LoSaWindowClosed()
	Dta.losa_ui.hideLoSaWindow()
end

--Called when the window has been moved
function Dta.losa_ui.LoSaWindowMoved()
	Dta.settings.set("LoSawindowPosX", Dta.ui.windowLoSa:GetLeft())
	Dta.settings.set("LoSawindowPosY", Dta.ui.windowLoSa:GetTop())
end
