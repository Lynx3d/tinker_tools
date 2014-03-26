Dta.ui = {}

Dta.ui.context = UI.CreateContext("Dta")
Dta.ui.windowtest = nil
Dta.ui.active = false

Dta.ui.windowMove = nil
Dta.ui.activeMove = false

Dta.ui.windowScale = nil
Dta.ui.activeScale = false

Dta.ui.windowCopyPaste = nil
Dta.ui.activeCopyPaste = false

Dta.ui.windowRotate = nil
Dta.ui.activeRotate = false

Dta.ui.windowLoSa = nil
Dta.ui.activeLoSa = false

Dta.ui.windowExpImp = nil
Dta.ui.activeExpImp = false

Dta.ui.windowHelp = nil
Dta.ui.activeHelp = false

Dta.ui.windowFlying = nil
Dta.ui.activeFlying = false

Dta.ui.windowAlphabet = nil
Dta.ui.activeAlphabet = false

Dta.ui.windowMeasurements = nil
Dta.ui.activeMeasurements = false

Dta.ui.loadLoSa = "Default"
Dta.ui.loadExpImp = "Saved"

Dta.ui.needsReset = true

-------------------------------
-- CREATION OF THE WINDOW ELLEMENTS
-------------------------------
-- Create a text frame
function Dta.ui.createText(name, parent, x, y, text, fontsize, color)
  local textFrame = UI.CreateFrame("Text", name, parent)
  textFrame:SetFontSize(fontsize)
  textFrame:SetText(text)
  textFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
  if color ~= nil then textFrame:SetFontColor(color[1], color[2], color[3], color[4]) end
	return textFrame
end

-- create icon
function Dta.ui.createIcon(name, parent, texture, x, y, size)
  local textureFrame = UI.CreateFrame("Texture", name, parent)
  if texture ~= nil then textureFrame:SetTexture("Rift", texture) end
  textureFrame:SetWidth(size)
  textureFrame:SetHeight(size)
  textureFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	return textureFrame
end

-- create texture
function Dta.ui.createTexture(name, parent, source, texture, x, y, width, height)
  local textureFrame = UI.CreateFrame("Texture", name, parent)
  if texture ~= nil then textureFrame:SetTexture(source, texture) end
  if width ~= nil then textureFrame:SetWidth(width) end
  if height ~= nil then textureFrame:SetHeight(height) end
  textureFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	return textureFrame
end

-- create textfield
function Dta.ui.createTextfield(name, parent, x, y, width, text)
  local textfield = UI.CreateFrame("RiftTextfield", name, parent)
  textfield:SetWidth(width)
  textfield:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
  textfield:SetBackgroundColor(0,0,0,0.75)
  if text ~= nil then textfield:SetText(text)
  else textfield:SetText("") end
  return textfield
end

-- create checkbox
function Dta.ui.createCheckbox(name, parent, x, y, text, checked, fontColor, checkChangedCallback)
  local checkbox = UI.CreateFrame("RiftCheckbox", name, parent)
  checkbox:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
  if checked ~= nil then checkbox:SetChecked(checked) end

  checkbox.textFrame = Dta.ui.createText(name .. "TextFrame", checkbox, 15, -2, text, 14, fontColor)

  function checkbox.textFrame.Event:LeftClick()
    checkbox:SetChecked(not checkbox:GetChecked())
  end

  function checkbox.Event:CheckboxChange()
    if checkChangedCallback ~= nil then checkChangedCallback() end
  end
  return checkbox
end

-- Create a frame with a set height and width
function Dta.ui.createFrame(name, parent, x, y, width, height, color)
	local frame = UI.CreateFrame("Frame", name, parent)
	frame:SetHeight(height)
	frame:SetWidth(width)
  frame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
  if color ~= nil then frame:SetBackgroundColor(color[1], color[2], color[3], color[4]) end
	return frame
end

-- create mainwindow
function Dta.ui.createWindow(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
  local windowtest = UI.CreateFrame("Frame", name, parent)
		windowtest:SetHeight(height)
		windowtest:SetWidth(width)
		windowtest:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
		-- windowtest:SetBackgroundColor(1, 1, 1, 0.5) --Debug
		windowtest:SetLayer(10)

  windowtest.background = UI.CreateFrame("Texture", name .. "Background", windowtest)
  windowtest.background:SetPoint("TOPLEFT", windowtest, "TOPLEFT", 0, 0)
  windowtest.background:SetPoint("BOTTOMRIGHT", windowtest, "TOPRIGHT", 0, height)
  windowtest.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
  windowtest.background:SetLayer(3)

  local background2Position = windowtest:GetHeight()-100
  windowtest.background2 = UI.CreateFrame("Texture", name .. "Background2", windowtest)
  windowtest.background2:SetPoint("CENTERX", windowtest, "CENTERX")
  windowtest.background2:SetPoint("CENTERY", windowtest, "CENTERY", nil, background2Position/2)
  windowtest.background2:SetWidth(width)
  windowtest.background2:SetHeight(115)
  windowtest.background2:SetAlpha(0.3)
  windowtest.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
  windowtest.background2:SetLayer(5)

  windowtest.help = UI.CreateFrame("Texture", name .. "help", windowtest)
  windowtest.help:SetPoint("TOPLEFT", windowtest, "TOPLEFT", windowtest:GetWidth()-70, -33)
  windowtest.help:SetTexture("Rift", "btn_dimensions_top_help_(normal).png.dds")
  windowtest.help:SetWidth(34)
  windowtest.help:SetHeight(34)
  windowtest.help:SetLayer(5)
  windowtest.help:EventAttach(Event.UI.Input.Mouse.Cursor.In, function(self, h)
    windowtest.help:SetTexture("Rift", "btn_dimensions_top_help_(over).png.dds")
  end, "HelpCursorIn")
  windowtest.help:EventAttach(Event.UI.Input.Mouse.Cursor.Out, function(self, h)
    windowtest.help:SetTexture("Rift", "btn_dimensions_top_help_(normal).png.dds")
  end, "HelpCursorOut")
  windowtest.help:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
    windowtest.help:SetTexture("Rift", "btn_dimensions_top_help_(click).png.dds")
  end, "HelpCursorDown")
  windowtest.help:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
    windowtest.help:SetTexture("Rift", "btn_dimensions_top_help_(over).png.dds")
  end, "HelpCursorUp")
  windowtest.help:EventAttach(Event.UI.Input.Mouse.Left.Up, Dta.help_ui.toggleHelpWindow , "HelpCursorUp")



  if closable then
    windowtest.closeBtn = Dta.ui.createButton(name .. "CloseBtn", windowtest, windowtest:GetWidth()-35, -33,0, 0, nil, "close", closeCallback)
    windowtest.closeBtn:SetLayer(4)
  end

  if movable then
    windowtest.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", windowtest)
    windowtest.moveFrame:SetPoint("TOPLEFT", windowtest, "TOPLEFT", 0, -40)
    windowtest.moveFrame:SetPoint("BOTTOMRIGHT", windowtest, "TOPRIGHT", 0, 5)
    windowtest.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
    windowtest.moveFrame:SetLayer(2)
    --windowtest.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

    windowtest.header = UI.CreateFrame("Text", name .. "header", windowtest.moveFrame)
    windowtest.header:SetFontSize(20)
    windowtest.header:SetText(title .. " " .. Dta.Version)
    windowtest.header:SetFontColor(0,0,0,1)
    windowtest.header:SetPoint("CENTERX", windowtest.moveFrame, "CENTERX")
    windowtest.header:SetPoint("CENTERY", windowtest.moveFrame, "CENTERY", nil, 5)


    local dragging = false

    windowtest.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Down, function(self, h)
	    dragging = true
	    mouse = Inspect.Mouse()
	    dragStartX = mouse.x - windowtest:GetLeft()
	    dragStartY = mouse.y - windowtest:GetTop()
	end, "LMouseDown")

	windowtest.moveFrame:EventAttach(Event.UI.Input.Mouse.Left.Up, function(self, h)
	    dragging = false
	    if moveCallback ~= nil then moveCallback() end
	end, "LMouseUp")

	windowtest.moveFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Move, function(self,h)
	    local x, y
	    local md = Inspect.Mouse()
	    x = md.x
	    y = md.y
	    if dragging then
		    windowtest:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - dragStartX, y - dragStartY)
		    end
	end, "MouseMove")

  return windowtest
  end
end

-- create button
function Dta.ui.createButton(name, parent, x, y, width, height, text, skin, clickCallback)
  local button = UI.CreateFrame("RiftButton", name, parent)

  if skin ~= nil and skin == "close" then
    button:SetSkin("close")
  else
    if height ~= nil then button:SetHeight(height) end
    if width ~= nil then button:SetWidth(width) end
    if text ~= nil then button:SetText(text) end
  end

  button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

  function button.Event:LeftPress()
    if clickCallback ~= nil then clickCallback() end
  end

  return button
end
-------------------------------
-- BUILD THE DIMENSIONTOOLS MAINWINDOW
-------------------------------

local MainWindowSettings = {
  TITLE = Lang[Dta.Language].Titles.Main,
  WIDTH = 470,
  HEIGHT = 300,
  CLOSABLE = true,
  MOVABLE = true,
}

function Dta.ui.buildMainWindow()
  local x = Dta.settings.get("MainwindowPosX")
  local y = Dta.settings.get("MainwindowPosY")
  Mainwindow = Dta.ui.createWindow("MainWindow",
                               Dta.ui.context,
                               MainWindowSettings.TITLE,
                               MainWindowSettings.WIDTH,
                               MainWindowSettings.HEIGHT,
                               x, y,
                               MainWindowSettings.CLOSABLE,
                               MainWindowSettings.MOVABLE,
                               Dta.ui.MainWindowClosed,
                               Dta.ui.MainWindowMoved
                              )

                                -------------------------------
                                --ITEM DETAILS
                                -------------------------------

                                Mainwindow.itemDetails = Dta.ui.createFrame("itemDetails", Mainwindow, 10, 10, Mainwindow:GetWidth()-20, Mainwindow:GetHeight()-20)
                                Mainwindow.itemDetails:SetLayer(30)
                                --Mainwindow.itemDetails:SetBackgroundColor(1, 0, 0, 0.5) --Debug

                                Mainwindow.itemDetails.icon = Dta.ui.createIcon("itemDetailsIcon", Mainwindow.itemDetails, nil, 0, 0, 25)
                                Mainwindow.itemDetails.name = Dta.ui.createText("itemDetailsName", Mainwindow.itemDetails, 30, 0, Lang[Dta.Language].Text.NothingSelected, 18)

                                Mainwindow.itemDetails.xLabel = Dta.ui.createText("itemDetailsXLabel", Mainwindow.itemDetails, 0, 30, "X", 14, {1, 0, 0, 1})
                                Mainwindow.itemDetails.yLabel = Dta.ui.createText("itemDetailsYLabel", Mainwindow.itemDetails, 0, 50, "Y", 14, {0, 1, 0, 1})
                                Mainwindow.itemDetails.zLabel = Dta.ui.createText("itemDetailsZLabel", Mainwindow.itemDetails, 0, 70, "Z", 14, {0, 1, 1, 1})

                                Mainwindow.itemDetails.x = Dta.ui.createText("itemDetailsX", Mainwindow.itemDetails, 25, 30, "-", 14)
                                Mainwindow.itemDetails.y = Dta.ui.createText("itemDetailsY", Mainwindow.itemDetails, 25, 50, "-", 14)
                                Mainwindow.itemDetails.z = Dta.ui.createText("itemDetailsZ", Mainwindow.itemDetails, 25, 70, "-", 14)

                                Mainwindow.itemDetails.yawLabel = Dta.ui.createText("itemDetailsYawLabel", Mainwindow.itemDetails, 125, 30, Lang[Dta.Language].Text.Yaw, 14, {0, 1, 0, 1})
                                Mainwindow.itemDetails.pitchLabel = Dta.ui.createText("itemDetailsPitchLabel", Mainwindow.itemDetails, 125, 50, Lang[Dta.Language].Text.Pitch, 14, {1, 0, 0, 1})
                                Mainwindow.itemDetails.rollLabel = Dta.ui.createText("itemDetailsRollLabel", Mainwindow.itemDetails, 125, 70, Lang[Dta.Language].Text.Roll, 14, {0, 1, 1, 1})

                                Mainwindow.itemDetails.yaw = Dta.ui.createText("itemDetailsYaw", Mainwindow.itemDetails, 175, 30, "-", 14)
                                Mainwindow.itemDetails.pitch = Dta.ui.createText("itemDetailsPitch", Mainwindow.itemDetails, 175, 50, "-", 14)
                                Mainwindow.itemDetails.roll = Dta.ui.createText("itemDetailsRoll", Mainwindow.itemDetails, 175, 70, "-", 14)

                                Mainwindow.itemDetails.scaleLabel = Dta.ui.createText("itemDetailsScaleLabel", Mainwindow.itemDetails, 0, 90, Lang[Dta.Language].Text.Scale, 14)
                                Mainwindow.itemDetails.scale = Dta.ui.createText("itemDetailsScale", Mainwindow.itemDetails, 50, 90, "-", 14)

                                Mainwindow.itemDetails.nrItemsLabel = Dta.ui.createText("itemDetailsnrItemsLabel", Mainwindow.itemDetails, 125, 90, Lang[Dta.Language].Text.NrSelectItems, 14)
                                Mainwindow.itemDetails.nrItems = Dta.ui.createText("itemDetailsnrItems", Mainwindow.itemDetails, 265, 90, "-", 14)

                                Mainwindow.divider1 = Dta.ui.createTexture("divider1", Mainwindow, "Dimtools", "textures/divider.png", 20, 120, Mainwindow:GetWidth()-40)
                                Mainwindow.divider1:SetLayer(29)

                                Mainwindow.itemDetails.MoveBtn = Dta.ui.createButton("itemDetailMoveBtn", Mainwindow.itemDetails, 0, 125, 160, nil, Lang[Dta.Language].Buttons.MoveWindow, nil, Dta.ui.modifyMoveButtonClicked)
                                Mainwindow.itemDetails.RotateBtn = Dta.ui.createButton("itemDetailRotateBtn", Mainwindow.itemDetails, 145, 125, 160, nil, Lang[Dta.Language].Buttons.RotateWindow, nil, Dta.ui.modifyRotateButtonClicked)
                                Mainwindow.itemDetails.ScaleBtn = Dta.ui.createButton("mitemDetailScaleBtn", Mainwindow.itemDetails, 290, 125, 160, nil, Lang[Dta.Language].Buttons.ScaleWindow, nil, Dta.ui.modifyScaleButtonClicked)
                                Mainwindow.itemDetails.CoPaBtn = Dta.ui.createButton("itemDetailCoPaBtn", Mainwindow.itemDetails, 0, 150, 160, nil, Lang[Dta.Language].Buttons.CopyPaste, nil, Dta.ui.modifyCoPaButtonClicked)
                                Mainwindow.itemDetails.SaveBtn = Dta.ui.createButton("itemDetailSaveBtn", Mainwindow.itemDetails, 145, 150, 160, nil, Lang[Dta.Language].Buttons.LoadSave, nil, Dta.ui.modifySaveButtonClicked)
                                Mainwindow.itemDetails.ImpExpBtn = Dta.ui.createButton("itemDetailImpExpBtn", Mainwindow.itemDetails, 290, 150, 160, nil, Lang[Dta.Language].Buttons.ImportExport, nil, Dta.ui.modifyImpExpButtonClicked)
                                Mainwindow.itemDetails.DFlying = Dta.ui.createButton("itemDetailDFlyingBtn", Mainwindow.itemDetails, 0, 175, 160, nil, Lang[Dta.Language].Buttons.TribalMagic, nil, Dta.ui.modifyDFlyingButtonClicked)
                                Mainwindow.itemDetails.Measurements = Dta.ui.createButton("itemDetailMeasurementsBtn", Mainwindow.itemDetails, 145, 175, 160, nil, Lang[Dta.Language].Buttons.OffsetCalc, nil, Dta.ui.modifyMeasurementsButtonClicked)
                                Mainwindow.itemDetails.Alphabet = Dta.ui.createButton("itemDetailAlphabetBtn", Mainwindow.itemDetails, 0, 200, 160, nil, "Alfiebet", nil, Dta.ui.modifyAlphabetButtonClicked)

  return Mainwindow
end

-- Show the Main window
function Dta.ui.showMainWindow()
  Dta.constructions = Dta.settings.get_savedsets("SavedSets") --or {}
  Dta.constructionsdefaults = Dta.settings.get_defaultsets("SavedDefaultSets") --or {}
  Dta.constructionstbx = tbx_import.get("savedConstructions")
  Dta.ExportImport_Sets = Dta_export.get("ExportImport")--or {}
  Dta.alphabet.Fonts = Dta.settings.get_alphabetFonts("SavedAlphabets")
  Dta.Replacement.Skins = Dta.settings.get_Skins("SavedSkins")
  if Dta.ui.windowtest == nil then
    Dta.ui.windowtest = Dta.ui.buildMainWindow()
  else
    Dta.ui.windowtest:SetVisible(true)
  end
  Dta.ui.active = true
  if Dta.losa.tableLength(Dta.selectedItems) > 0 then
    Dta.items.StartDetails(Dta.Key)
  end
end

-- Hide the Main window
function Dta.ui.hideMainWindow()
  Dta.ui.windowtest:SetVisible(false)
  Dta.ui.windowtest = nil
  Dta.constructions = {}
  Dta.constructionsdefaults = {}
  Dta.ui.active = false
  if Dta.ui.activeMove then Dta.move_ui.hideMoveWindow() end
  if Dta.ui.activeScale then Dta.scale_ui.hideScaleWindow() end
  if Dta.ui.activeCopyPaste then Dta.copa_ui.hideCopyPastewindow() end
  if Dta.ui.activeRotate then Dta.rotate_ui.hideRotateWindow() end
  if Dta.ui.activeLoSa then Dta.losa_ui.hideLoSaWindow() end
  if Dta.ui.activeExpImp then Dta.expimp_ui.hideExpImpWindow() end
  if Dta.ui.activeHelp then Dta.help_ui.hideHelpWindow() end
  if Dta.ui.activeFlying then Dta.flying_ui.hideFlyingWindow() end
  if Dta.ui.activeAlphabet then Dta.alphabet_ui.hideAlphabetWindow() end
  if Dta.ui.activeMeasurements then Dta.measurements_ui.hideMeasurementsWindow() end
end

-- Toggle the Main window
function Dta.ui.toggleMainWindow()
  if Dta.ui.active then Dta.ui.hideMainWindow()
  else Dta.ui.showMainWindow() end
end

--Called when the window has been moved
function Dta.ui.MainWindowMoved()
  Dta.settings.set("MainwindowPosX", Mainwindow:GetLeft())
  Dta.settings.set("MainwindowPosY", Mainwindow:GetTop())
end

--Called when the window has been closed
function Dta.ui.MainWindowClosed()
  Dta.ui.hideMainWindow()

end

-------------------------------
-- CALLBACKS FOR WINDOW BUTTONS
-------------------------------

function Dta.ui.modifyMoveButtonClicked()
Dta.move_ui.toggleMoveWindow()
end

function Dta.ui.modifyRotateButtonClicked()
Dta.rotate_ui.toggleRotateWindow()
end

function Dta.ui.modifyScaleButtonClicked()
Dta.scale_ui.toggleScaleWindow()
end

function Dta.ui.modifyCoPaButtonClicked()
Dta.copa_ui.toggleCopyPastewindow()
end

function Dta.ui.modifySaveButtonClicked()
Dta.losa_ui.toggleLoSaWindow()
end

function Dta.ui.modifyImpExpButtonClicked()
Dta.expimp_ui.toggleExpImpWindow()
end

function Dta.ui.modifyDFlyingButtonClicked()
    Dta.flying_ui.toggleFlyingWindow()
end

function Dta.ui.modifyAlphabetButtonClicked()
    Dta.alphabet_ui.toggleAlphabetWindow()
end

function Dta.ui.modifyMeasurementsButtonClicked()
    Dta.measurements_ui.toggleMeasurementsWindow()
end
