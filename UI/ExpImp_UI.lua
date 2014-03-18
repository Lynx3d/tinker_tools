Dta.expimp_ui = {}

function Dta.expimp_ui.createWindowExpImp(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowExpImp = UI.CreateFrame("Frame", name, parent)
		windowExpImp:SetHeight(height)
		windowExpImp:SetWidth(width)
		windowExpImp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowExpImp:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowExpImp:SetLayer(20)

  windowExpImp.background = UI.CreateFrame("Texture", name .. "Background", windowExpImp)
  windowExpImp.background:SetPoint("TOPLEFT", windowExpImp, "TOPLEFT", 0, 0)
  windowExpImp.background:SetPoint("BOTTOMRIGHT", windowExpImp, "TOPRIGHT", 0, height)
  windowExpImp.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowExpImp.background:SetLayer(3)

  local background2Position = windowExpImp:GetHeight()-80
  windowExpImp.background2 = UI.CreateFrame("Texture", name .. "Background2", windowExpImp)
  windowExpImp.background2:SetPoint("CENTERX", windowExpImp, "CENTERX")
  windowExpImp.background2:SetPoint("CENTERY", windowExpImp, "CENTERY", nil, background2Position/2)
  windowExpImp.background2:SetWidth(width)
  windowExpImp.background2:SetHeight(95)
  windowExpImp.background2:SetAlpha(0.3)
  windowExpImp.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowExpImp.background2:SetLayer(5)


  if closable then
    windowExpImp.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowExpImp, windowExpImp:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowExpImp.closeBtn:SetLayer(4)
  end

  if movable then
    windowExpImp.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowExpImp)
    windowExpImp.moveFrame:SetPoint("TOPLEFT", windowExpImp, "TOPLEFT", 0, -40)
    windowExpImp.moveFrame:SetPoint("BOTTOMRIGHT", windowExpImp, "TOPRIGHT", 0, 5)
    windowExpImp.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowExpImp.moveFrame:SetLayer(2)
    --windowExpImp.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowExpImp.header = UI.CreateFrame("Text", name .. "header", windowExpImp.moveFrame)
    windowExpImp.header:SetFontSize(20)
    windowExpImp.header:SetText(title)
    windowExpImp.header:SetFontColor(0,0,0,1)
    windowExpImp.header:SetPoint("CENTERX", windowExpImp.moveFrame, "CENTERX")
    windowExpImp.header:SetPoint("CENTERY", windowExpImp.moveFrame, "CENTERY", nil, 5)

    local dragging = false

    windowExpImp.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowExpImp:GetLeft()
	    dragStartY = mouse.y - windowExpImp:GetTop()
	end, "LMouseDown")

	windowExpImp.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowExpImp.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowExpImp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowExpImp
  end
end

local ExpImpWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.ImportExport,
  WIDTH = 325,
  HEIGHT = 190,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.expimp_ui.buildExpImpWindow()
  local x = Dta.settings.get("ExpImpwindowPosX")
  local y = Dta.settings.get("ExpImpwindowPosY")
  ExpImpwindow = Dta.expimp_ui.createWindowExpImp("ExpImpWindow",
                               Dta.ui.context,
                               ExpImpWindowSettings.TITLE,
                               ExpImpWindowSettings.WIDTH,
                               ExpImpWindowSettings.HEIGHT,
                               x,
                               y,
                               ExpImpWindowSettings.CLOSABLE,
                               ExpImpWindowSettings.MOVABLE,
                               Dta.expimp_ui.ExpImpWindowClosed,
                               Dta.expimp_ui.ExpImpWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------
                                ExpImpwindow.ImportExport = Dta.ui.createFrame("ImportExport", ExpImpwindow, 10, 10, ExpImpwindow:GetWidth()-20, ExpImpwindow:GetHeight()-20)
                                ExpImpwindow.ImportExport:SetLayer(30)
                                --ExpImpwindow.ImportExport:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                ExpImpwindow.ImportExport.ExportSavedCheckbox = Dta.ui.createCheckbox("ExportSavedCheckbox", ExpImpwindow.ImportExport, 55, 0, Lang[Dta.Language].Text.SavedSets, true, nil, Dta.expimp.ExportSavedCheckboxChanged)
                                ExpImpwindow.ImportExport.ExportTbxCheckbox = Dta.ui.createCheckbox("ExportTbxCheckbox", ExpImpwindow.ImportExport, 155, 0, Lang[Dta.Language].Text.TbxSets, false, nil, Dta.expimp.ExportTbxCheckboxChanged)


                                ExpImpwindow.ImportExport.ExportLabel = Dta.ui.createText("ImportExportExportLabel", ExpImpwindow.ImportExport, 0, 25, Lang[Dta.Language].Text.Name, 14)
                                ExpImpwindow.ImportExport.ExportLoad = UI.CreateFrame("SimpleSelect", "ExportNameSelect", ExpImpwindow.ImportExport)
                                ExpImpwindow.ImportExport.ExportLoad:SetPoint("TOPLEFT", ExpImpwindow.ImportExport, "TOPLEFT", 55, 25)
                                ExpImpwindow.ImportExport.ExportLoad:SetLayer(100)
                                ExpImpwindow.ImportExport.ExportLoad:SetItems(Dta.expimp.loadExport())
                                ExpImpwindow.ImportExport.ExportLoad:ResizeToFit()
                                ExpImpwindow.ImportExport.ExportLoad:SetWidth(245)
                                ExpImpwindow.ImportExport.ExportLoad:SetEnabled(true)
                                ExpImpwindow.ImportExport.Export = Dta.ui.createButton("ImportExport_Export", ExpImpwindow.ImportExport, 0, 50, nil, nil, Lang[Dta.Language].Buttons.Export, nil, Dta.expimp.ImportExport_ExportClicked)

                                ExpImpwindow.divider5 = Dta.ui.createTexture("divider5", ExpImpwindow, "Dimtools", "textures/divider.png", 10, 95, ExpImpwindow:GetWidth()-10)
                                ExpImpwindow.divider5:SetLayer(29)

                                ExpImpwindow.ImportExport.ImportLabel = Dta.ui.createText("ImportExportImportLabel", ExpImpwindow.ImportExport, 0, 110, Lang[Dta.Language].Text.Name, 14)
                                ExpImpwindow.ImportExport.ImportLoad = UI.CreateFrame("SimpleSelect", "ImportNameSelect", ExpImpwindow.ImportExport)
                                ExpImpwindow.ImportExport.ImportLoad:SetPoint("TOPLEFT", ExpImpwindow.ImportExport, "TOPLEFT", 55, 110)
                                ExpImpwindow.ImportExport.ImportLoad:SetLayer(101)
                                ExpImpwindow.ImportExport.ImportLoad:SetItems(Dta.expimp.loadImport())
                                ExpImpwindow.ImportExport.ImportLoad:ResizeToFit()
                                ExpImpwindow.ImportExport.ImportLoad:SetWidth(245)
                                ExpImpwindow.ImportExport.ImportLoad:SetEnabled(true)
                                ExpImpwindow.ImportExport.Import = Dta.ui.createButton("ImportExport_Import", ExpImpwindow.ImportExport, 0, 135, nil, nil, Lang[Dta.Language].Buttons.Import, nil, Dta.expimp.ImportExport_ImportClicked)


  return ExpImpwindow
end

-- Show the toolbox window
function Dta.expimp_ui.showExpImpWindow()
  if Dta.ui.windowExpImp == nil then
    Dta.ui.windowExpImp = Dta.expimp_ui.buildExpImpWindow()
  else
    Dta.expimp_ui.windowExpImp:SetVisible(true)
  end
  Dta.ui.activeExpImp = true
  Dta.ui.loadExpImp = "Saved"
  Dta.expimp.refreshExportSelect()
end

-- Hide the toolbox window
function Dta.expimp_ui.hideExpImpWindow()
  Dta.ui.windowExpImp:SetVisible(false)
  Dta.ui.windowExpImp.ImportExport.ExportLoad:SetEnabled(false)
  Dta.ui.windowExpImp.ImportExport.ImportLoad:SetEnabled(false)
  Dta.ui.windowExpImp = nil
  Dta.ui.activeExpImp = false

end

-- Toggle the toolbox window
function Dta.expimp_ui.toggleExpImpWindow()
  if Dta.ui.activeExpImp then Dta.expimp_ui.hideExpImpWindow()
  else Dta.expimp_ui.showExpImpWindow() end
end

--Called when the window has been closed
function Dta.expimp_ui.ExpImpWindowClosed()
  Dta.expimp_ui.hideExpImpWindow()
end

--Called when the window has been moved
function Dta.expimp_ui.ExpImpWindowMoved()
  Dta.settings.set("ExpImpwindowPosX", ExpImpwindow:GetLeft())
  Dta.settings.set("ExpImpwindowPosY", ExpImpwindow:GetTop())
end
