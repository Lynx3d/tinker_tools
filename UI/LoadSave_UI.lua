Dta.losa_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS LoSaWINDOW
-------------------------------

function Dta.losa_ui.createWindowLoSa(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowLoSa = UI.CreateFrame("Frame", name, parent)
		windowLoSa:SetHeight(height)
		windowLoSa:SetWidth(width)
		windowLoSa:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowLoSa:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowLoSa:SetLayer(22)

  windowLoSa.background = UI.CreateFrame("Texture", name .. "Background", windowLoSa)
  windowLoSa.background:SetPoint("TOPLEFT", windowLoSa, "TOPLEFT", 0, 0)
  windowLoSa.background:SetPoint("BOTTOMRIGHT", windowLoSa, "TOPRIGHT", 0, height)
  windowLoSa.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowLoSa.background:SetLayer(3)

  local background2Position = windowLoSa:GetHeight()-80
  windowLoSa.background2 = UI.CreateFrame("Texture", name .. "Background2", windowLoSa)
  windowLoSa.background2:SetPoint("CENTERX", windowLoSa, "CENTERX")
  windowLoSa.background2:SetPoint("CENTERY", windowLoSa, "CENTERY", nil, background2Position/2)
  windowLoSa.background2:SetWidth(width)
  windowLoSa.background2:SetHeight(95)
  windowLoSa.background2:SetAlpha(0.3)
  windowLoSa.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowLoSa.background2:SetLayer(5)


  if closable then
    windowLoSa.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowLoSa, windowLoSa:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowLoSa.closeBtn:SetLayer(4)
  end

  if movable then
    windowLoSa.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowLoSa)
    windowLoSa.moveFrame:SetPoint("TOPLEFT", windowLoSa, "TOPLEFT", 0, -40)
    windowLoSa.moveFrame:SetPoint("BOTTOMRIGHT", windowLoSa, "TOPRIGHT", 0, 5)
    windowLoSa.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowLoSa.moveFrame:SetLayer(2)
    --windowLoSa.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowLoSa.header = UI.CreateFrame("Text", name .. "header", windowLoSa.moveFrame)
    windowLoSa.header:SetFontSize(20)
    windowLoSa.header:SetText(title)
    windowLoSa.header:SetFontColor(0,0,0,1)
    windowLoSa.header:SetPoint("CENTERX", windowLoSa.moveFrame, "CENTERX")
    windowLoSa.header:SetPoint("CENTERY", windowLoSa.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowLoSa.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowLoSa:GetLeft()
	    dragStartY = mouse.y - windowLoSa:GetTop()
	end, "LMouseDown")

	windowLoSa.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowLoSa.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowLoSa:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowLoSa
  end
end

local LoSaWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.LoadSave,
  WIDTH = 325,
  HEIGHT = 330,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.losa_ui.buildLoSaWindow()
  local x = Dta.settings.get("LoSawindowPosX")
  local y = Dta.settings.get("LoSawindowPosY")
  LoSawindow = Dta.losa_ui.createWindowLoSa("LoSaWindow",
                               Dta.ui.context,
                               LoSaWindowSettings.TITLE,
                               LoSaWindowSettings.WIDTH,
                               LoSaWindowSettings.HEIGHT,
                               x,
                               y,
                               LoSaWindowSettings.CLOSABLE,
                               LoSaWindowSettings.MOVABLE,
                               Dta.losa_ui.LoSaWindowClosed,
                               Dta.losa_ui.LoSaWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                LoSawindow.constructions = Dta.ui.createFrame("constructions", LoSawindow, 10, 10, LoSawindow:GetWidth()-20, LoSawindow:GetHeight()-20)
                                LoSawindow.constructions:SetLayer(30)
                                --LoSawindow.constructions:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                LoSawindow.constructions.nameLabel = Dta.ui.createText("constructionsNameLabel", LoSawindow.constructions, 0, 0, Lang[Dta.Language].Text.Name, 14)
                                LoSawindow.constructions.name = Dta.ui.createTextfield("constructionsName", LoSawindow.constructions, 55, 0, 245)
                                LoSawindow.constructions.save = Dta.ui.createButton("constructionsSave", LoSawindow.constructions, 0, 25, nil, nil, Lang[Dta.Language].Buttons.SaveSet, nil, Dta.losa.constructionSaveClicked)

                                LoSawindow.divider5 = Dta.ui.createTexture("divider5", LoSawindow, "Dimtools", "textures/divider.png", 10, 70, LoSawindow:GetWidth()-10)
                                LoSawindow.divider5:SetLayer(29)

                                LoSawindow.constructions.loadDeafaultSets = Dta.ui.createCheckbox("constructionLoadDeafaultSets", LoSawindow.constructions, 0, 85, Lang[Dta.Language].Text.DefaultSets, true, nil, Dta.losa.constructionLoadDeafaultSetsChanged)
                                LoSawindow.constructions.loadSavedSets = Dta.ui.createCheckbox("constructionLoadSavedSets", LoSawindow.constructions, 100, 85, Lang[Dta.Language].Text.SavedSets, false, nil, Dta.losa.constructionLoadSavedSetsChanged)
                                LoSawindow.constructions.loadTbxSets = Dta.ui.createCheckbox("constructionLoadTbxSets", LoSawindow.constructions, 200, 85, Lang[Dta.Language].Text.TbxSets, false, nil, Dta.losa.constructionLoadTbxSetsChanged)

                                LoSawindow.constructions.nameLabel2 = Dta.ui.createText("constructionsNameLabel2", LoSawindow.constructions, 0, 115, Lang[Dta.Language].Text.Name, 14)
                                LoSawindow.constructions.nameLoad = UI.CreateFrame("SimpleSelect", "constructionsNameSelect", LoSawindow.constructions)
                                LoSawindow.constructions.nameLoad:SetPoint("TOPLEFT", LoSawindow.constructions, "TOPLEFT", 55, 115)
                                LoSawindow.constructions.nameLoad:SetLayer(100)
                                LoSawindow.constructions.nameLoad:SetItems(Dta.losa.loadConstructions())
                                LoSawindow.constructions.nameLoad:ResizeToFit()
                                LoSawindow.constructions.nameLoad:SetWidth(245)
                                LoSawindow.constructions.nameLoad:SetEnabled(true)

                                LoSawindow.constructions.load = Dta.ui.createButton("constructionsLoad", LoSawindow.constructions, 0, 170, nil, nil, Lang[Dta.Language].Buttons.LoadSet, nil, Dta.losa.constructionLoadClicked)
                                LoSawindow.constructions.remove = Dta.ui.createButton("constructionsRemove", LoSawindow.constructions, 0, 205, nil, nil, Lang[Dta.Language].Buttons.RemoveSet, nil, Dta.losa.constructionRemoveClicked)
                                LoSawindow.constructions.remove:SetVisible(false)
                                LoSawindow.constructions.printReqs = Dta.ui.createButton("constructionsPrintReqs", LoSawindow.constructions, 165, 170, nil, nil, Lang[Dta.Language].Buttons.PrintMaterials, nil, Dta.losa.constructionPrintMaterials)

                                LoSawindow.constructions.loadAtOriginalLoc = Dta.ui.createCheckbox("constructionLoadAtOriginalLoc", LoSawindow.constructions, 135, 145, Lang[Dta.Language].Text.LoadOrigionalLocation, false)
                                LoSawindow.constructions.loadAtOriginalLoc:SetVisible(false)
                                LoSawindow.constructions.LoadNewItems = Dta.ui.createCheckbox("constructionLoadNewItems", LoSawindow.constructions, 0, 145, Lang[Dta.Language].Text.UseNewItems, false, nil, Dta.losa.constructionLoadNewItemsChanged)
                                LoSawindow.constructions.LoadNewItems:SetVisible(true)

                                LoSawindow.constructions.LoadMultipleSets = Dta.ui.createCheckbox("constructionLoadMultipleSets", LoSawindow.constructions, 0, 240, Lang[Dta.Language].Text.MultiCopies, false, nil, Dta.losa.constructionLoadMultipleSetsChanged)
                                LoSawindow.constructions.LoadMultipleSets:SetVisible(false)

                                LoSawindow.constructions.NrCopiesLabel = Dta.ui.createText("constructionsNrCopiesLabel", LoSawindow.constructions, 0, 265, Lang[Dta.Language].Text.NrCopies, 14)
                                LoSawindow.constructions.NrCopiesLabel:SetVisible(false)
                                LoSawindow.constructions.OffsetLabel = Dta.ui.createText("constructionsOffsetLabel", LoSawindow.constructions, 0, 290, Lang[Dta.Language].Text.Offset, 14)
                                LoSawindow.constructions.OffsetLabel:SetVisible(false)
                                LoSawindow.constructions.xLabel = Dta.ui.createText("constructionsXLabel", LoSawindow.constructions, 70, 290, "X", 14, {1, 0, 0, 1})
                                LoSawindow.constructions.xLabel:SetVisible(false)
                                LoSawindow.constructions.yLabel = Dta.ui.createText("constructionsYLabel", LoSawindow.constructions, 155, 290, "Y", 14, {0, 1, 0, 1})
                                LoSawindow.constructions.yLabel:SetVisible(false)
                                LoSawindow.constructions.zLabel = Dta.ui.createText("constructionsZLabel", LoSawindow.constructions, 240, 290, "Z", 14, {0, 1, 1, 1})
                                LoSawindow.constructions.zLabel:SetVisible(false)

                                LoSawindow.constructions.NrCopies = Dta.ui.createTextfield("constructionsNrCopies", LoSawindow.constructions, 90, 265, 40)
                                LoSawindow.constructions.NrCopies:SetVisible(false)
                                LoSawindow.constructions.x = Dta.ui.createTextfield("constructionsX", LoSawindow.constructions, 90, 290, 40)
                                LoSawindow.constructions.x:SetVisible(false)
                                LoSawindow.constructions.y = Dta.ui.createTextfield("constructionsY", LoSawindow.constructions, 175, 290, 40)
                                LoSawindow.constructions.y:SetVisible(false)
                                LoSawindow.constructions.z = Dta.ui.createTextfield("mconstructionsZ", LoSawindow.constructions, 260, 290, 40)
                                LoSawindow.constructions.z:SetVisible(false)

  return LoSawindow
end

-- Show the toolbox window
function Dta.losa_ui.showLoSaWindow()
  if Dta.ui.windowLoSa == nil then
    Dta.ui.windowLoSa = Dta.losa_ui.buildLoSaWindow()
  else
    Dta.losa_ui.windowLoSa:SetVisible(true)
  end
  Dta.ui.activeLoSa = true
end

-- Hide the toolbox window
function Dta.losa_ui.hideLoSaWindow()
  Dta.ui.windowLoSa:SetVisible(false)
  Dta.ui.windowLoSa.constructions.nameLoad:SetEnabled(false)
  Dta.ui.windowLoSa = nil
  Dta.ui.loadLoSa = "Default"
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
  Dta.settings.set("LoSawindowPosX", LoSawindow:GetLeft())
  Dta.settings.set("LoSawindowPosY", LoSawindow:GetTop())
end
