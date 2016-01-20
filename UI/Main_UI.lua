local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.ui = {}

Dta.ui.context = UI.CreateContext("Dta")
Dta.ui.context_top = UI.CreateContext("Dta_Top")
Dta.ui.context_top:SetStrata("topmost")
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

function Dta.ui.checkNumber(n_str, default)
	if not n_str or n_str == "" then
		return default, true
	end
	local n_val = tonumber(n_str)
	return n_val, n_val ~= nil
end

-------------------------------
-- FOCUS CYCLING WITH [<Shift>]<Tab>
-------------------------------

function Dta.ui.ShiftKeyDownCallback(frame, hEvent, key)
	if key == "Shift" then Dta.ui.isShiftPressed = true end
end

function Dta.ui.ShiftKeyUpCallback(frame, hEvent, key)
	if key == "Shift" then Dta.ui.isShiftPressed = false end
end

UIParent:EventAttach(Event.UI.Input.Key.Down.Dive, Dta.ui.ShiftKeyDownCallback, "ShiftKeyDownSensor")
UIParent:EventAttach(Event.UI.Input.Key.Up.Dive, Dta.ui.ShiftKeyUpCallback, "ShiftKeyUpSensor")

function Dta.ui.AddFocusCycleElement(owner, frame)
	if not owner.focusCycleList then
		owner.focusCycleList = {}
	end
	local idx = #owner.focusCycleList + 1
	owner.focusCycleList[idx] = frame
	frame.focusCycleIndex = idx
	-- this was not planned, see comment in FocusCycleCallback
	frame.focusCycleList = owner.focusCycleList
end

function Dta.ui.FocusCycleCallback(frame, hEvent, key)
	local target = hEvent:GetTarget()
	-- apparently you can't get a reference to the "owner" frame to which this dive handler
	-- gets attached, instead the "frame" passed is the the target frames (a cycle list entry).
	-- i.e. frame and hEvent:GetTarget() are identical, which is weird
	if key == "Return" then
		target:SetKeyFocus(false)
		return
	elseif key ~= "Tab" or not frame.focusCycleList then
		return
	end

	local idx = target.focusCycleIndex
	if not idx then
		return
	end
	if Dta.ui.isShiftPressed then
		idx = idx - 1
		if idx == 0 then
			idx = #frame.focusCycleList
		end
	else
		idx = idx + 1
		if idx > #frame.focusCycleList then
			idx = 1
		end
	end
	frame.focusCycleList[idx]:SetKeyFocus(true)
	if type(target.TabFocusCycled) == "function" then
		target.TabFocusCycled(target)
	end
end

-------------------------------
-- CREATION OF THE WINDOW ELLEMENTS
-------------------------------
-- Create a text frame
function Dta.ui.createText(name, parent, x, y, text, fontsize, color, shadow)
	local textFrame = UI.CreateFrame("Text", name, parent)
	textFrame:SetFontSize(fontsize)
	textFrame:SetText(text)
	textFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	if color ~= nil then textFrame:SetFontColor(color[1], color[2], color[3], color[4]) end
	if shadow ~= false then textFrame:SetEffectGlow({offsetX=1, offsetY=1}) end
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

-- textfield helper function
-- TODO: think about proper class hierarchies
function Dta.ui.textfieldSelectAll(self)
	local sval = self:GetText()
	local slen = sval and string.len(sval) or 0
	if slen > 0 then self:SetSelection(0, slen) end
end
-- create textfield
function Dta.ui.createTextfield(name, parent, x, y, width, text)
	local textfield = UI.CreateFrame("RiftTextfield", name, parent)
	textfield:SetWidth(width)
	textfield:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	textfield:SetBackgroundColor(0,0,0,0.75)
	if text ~= nil then textfield:SetText(text)
	else textfield:SetText("") end
	textfield.TabFocusCycled = Dta.ui.textfieldSelectAll
	return textfield
end

-- create reload button to accompany certain textfields
function Dta.ui.createReloadButton(name, parent, x, y, callback)
	local reloadBtn = Dta.ui.Button.Create(name, parent, callback,
			"textures/reload_btn_normal.png",
			"textures/reload_btn_over.png",
			"textures/reload_btn_click.png",
			"textures/reload_btn_disable.png",
			"Dimtools"
			)
	reloadBtn:SetWidth(20)
	reloadBtn:SetHeight(20)
	reloadBtn:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	reloadBtn:SetBackgroundColor(0, 0, 0, 0.55)
	return reloadBtn
end

-- checkbox helper function
function Dta.ui.checkboxSetEnabled(self, enabled)
	if enabled then
		self.textFrame:SetAlpha(1)
	else
		self.textFrame:SetAlpha(0.5)
	end
	self:SetEnabled(enabled)
end

-- create checkbox
function Dta.ui.createCheckbox(name, parent, x, y, text, checked, fontColor, checkChangedCallback)
	local checkbox = UI.CreateFrame("RiftCheckbox", name, parent)
	checkbox:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	if checked ~= nil then checkbox:SetChecked(checked) end

	checkbox.textFrame = Dta.ui.createText(name .. "TextFrame", checkbox, 15, -2, text, 14, fontColor)
	checkbox.CBSetEnabled = Dta.ui.checkboxSetEnabled

	function checkbox.textFrame.Event:LeftClick()
		checkbox:SetChecked(not checkbox:GetChecked())
	end

	if type(checkChangedCallback) == "function" then
		checkbox:EventAttach(Event.UI.Checkbox.Change, checkChangedCallback, name .. "_changed")
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

function Dta.ui.clickCallback(frame, hEvent)
	-- remove key-focus of any other frame by temporarily claiming it
	frame:SetKeyFocus(true)
	frame:SetKeyFocus(false)
end

-- create button
function Dta.ui.createButton(name, parent, x, y, width, height, text, skin, clickCallback)
	local button = UI.CreateFrame("RiftButton", name, parent)

	if skin ~= nil and skin == "close" then
		button:SetSkin("close")
	else
		if text ~= nil then button:SetText(text) end
	end
	if height ~= nil then button:SetHeight(height) end
	if width ~= nil then button:SetWidth(width) end

	button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

	if type(clickCallback) == "function" then
		button:EventAttach(Event.UI.Input.Mouse.Left.Click, clickCallback, name .. "_left_click")
	end
	return button
end

-------------------------------
-- BUILD THE MAINWINDOW TOGGLE BUTTON
-------------------------------

--Called when the window has been moved
function Dta.ui.MainButtonMoved()
	Dta.settings.set("MainbuttonPosX", Dta.ui.buttonMainToggle:GetLeft())
	Dta.settings.set("MainbuttonPosY", Dta.ui.buttonMainToggle:GetTop())
end

function Dta.ui.showMainButton()
	if not Dta.ui.buttonMainToggle then
		Dta.ui.buttonMainToggle = Dta.ui.Button.Create("UI_Toggle_Button", Dta.ui.context,
			function(self, h) Dta.ui.toggleMainWindow() end,
			"btn_dimensions_top_edit_(normal).png.dds",
			"btn_dimensions_top_edit_(over).png.dds",
			"btn_dimensions_top_edit_(click).png.dds",
			"btn_dimensions_top_edit_(disabled).png.dds"
			)
		Dta.ui.buttonMainToggle:SetWidth(48)
		Dta.ui.buttonMainToggle:SetHeight(48)
		Dta.ui.buttonMainToggle:SetLayer(-1)
		Dta.ui.buttonMainToggle:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Dta.settings.get("MainbuttonPosX"), Dta.settings.get("MainbuttonPosY"))
		Dta.ui.DraggableFrame.Setup(Dta.ui.buttonMainToggle, Dta.ui.buttonMainToggle, Dta.ui.MainButtonMoved, "Right")
	end
	Dta.ui.buttonMainToggle:SetVisible(true)
end

function Dta.ui.hideMainButton()
	if Dta.ui.buttonMainToggle then
		Dta.ui.buttonMainToggle:SetVisible(false)
	end
end
-------------------------------
-- BUILD THE DIMENSIONTOOLS MAINWINDOW
-------------------------------

local MainWindowSettings = {
	WIDTH = 325,
	HEIGHT = 260,
	CLOSABLE = true,
	MOVABLE = true,
}
local BGwidth, BGheight = 313, 125
local BGpath = {	{x = 0, y = 10},
					{x = 10, y = 0, xControl = 0, yControl = 0},
					{x = BGwidth - 10, y = 0 },
					{x = BGwidth, y = 10, xControl = BGwidth, yControl = 0},
					{x = BGwidth, y = BGheight - 10},
					{x = BGwidth - 10, y = BGheight, xControl = BGwidth, yControl = BGheight},
					{x = 10, y = BGheight },
					{x = 0, y = BGheight - 10, xControl = 0, yControl = BGheight},
					{x = 0, y = 10} }

function Dta.ui.buildMainWindow()
	local x = Dta.settings.get("MainwindowPosX")
	local y = Dta.settings.get("MainwindowPosY")
	--Mainwindow = Dta.ui.createWindow("MainWindow",
	local newWindow = Dta.ui.Window.Create("MainWindowNew",
							Dta.ui.context,
							Lang[Dta.Language].Titles.Main,
							MainWindowSettings.WIDTH,
							MainWindowSettings.HEIGHT,
							x, y,
							MainWindowSettings.CLOSABLE,
							MainWindowSettings.MOVABLE,
							Dta.ui.MainWindowClosed,
							Dta.ui.MainWindowMoved
							)
	newWindow.versionText = Dta.ui.createText("versionText", newWindow, 20, 10, Dta.Version, 12, {0.3, 0.6, 0.6, 1})
	newWindow.versionText:SetLayer(15)
	local Mainwindow = newWindow.content

	Mainwindow.detailsBG = UI.CreateFrame("Canvas", "ItemDetailsBackground", Mainwindow)
	Mainwindow.detailsBG:SetPoint("TOPLEFT", Mainwindow, "TOPLEFT", 5, 3)
	Mainwindow.detailsBG:SetShape(BGpath, {type = "solid", r=0.07, g=0.01, b=0, a=0.6}, {r=0, g=0, b=0, a=0.4, thickness=3})
	-------------------------------
	--ITEM DETAILS
	-------------------------------

	Mainwindow.itemDetails = Dta.ui.createFrame("itemDetails", Mainwindow, 10, 13, Mainwindow:GetWidth()-20, Mainwindow:GetHeight()-20)
	Mainwindow.itemDetails:SetLayer(30)
	--Mainwindow.itemDetails:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	Mainwindow.itemDetails.icon = Dta.ui.createIcon("itemDetailsIcon", Mainwindow.itemDetails, nil, 0, 0, 25)
	Mainwindow.itemDetails.icon:SetLayer(35)
	Mainwindow.itemDetails.name = Dta.ui.createText("itemDetailsName", Mainwindow.itemDetails, 30, 0, Lang[Dta.Language].Text.NothingSelected, 16)
	Mainwindow.itemDetails.name:SetWidth(280)
	Mainwindow.itemDetails.name:SetWordwrap(true)
	Mainwindow.itemDetails.name:ClearPoint("TOPLEFT")
	Mainwindow.itemDetails.name:SetPoint("CENTERLEFT", Mainwindow.itemDetails, "TOPLEFT", 36, 12)
	Mainwindow.itemDetails.name:SetEffectGlow({offsetX=1, offsetY=1, strength=2})
	Mainwindow.itemDetails.icon:EventAttach(Event.UI.Input.Mouse.Right.Click,
		function(self, h)
			if Dta.selectionCount > 0 then Command.Map.Waypoint.Set(Dta.selectionCenter.x, Dta.selectionCenter.z) end
		end,
		"Waypoint Marker")
	-- clear selection button
	Mainwindow.itemDetails.clearSelection = Dta.ui.createButton("clearSelection", Mainwindow.itemDetails, 20, -7, 18, 18, nil, "close", Dta.ui.clearSelectionButtonClicked)
	Mainwindow.itemDetails.clearSelection:SetLayer(40)
	Mainwindow.itemDetails.clearSelection:SetVisible(false)

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

	Mainwindow.itemDetails.MoveBtn = Dta.ui.createButton("itemDetailMoveBtn", Mainwindow.itemDetails, 0, 125, 160, nil, Lang[Dta.Language].Buttons.MoveWindow, nil, Dta.ui.modifyMoveButtonClicked)
	Mainwindow.itemDetails.RotateBtn = Dta.ui.createButton("itemDetailRotateBtn", Mainwindow.itemDetails, 145, 125, 160, nil, Lang[Dta.Language].Buttons.RotateWindow, nil, Dta.ui.modifyRotateButtonClicked)
	Mainwindow.itemDetails.ScaleBtn = Dta.ui.createButton("mitemDetailScaleBtn", Mainwindow.itemDetails, 0, 150, 160, nil, Lang[Dta.Language].Buttons.ScaleWindow, nil, Dta.ui.modifyScaleButtonClicked)
	Mainwindow.itemDetails.Measurements = Dta.ui.createButton("itemDetailMeasurementsBtn", Mainwindow.itemDetails, 145, 150, 160, nil, Lang[Dta.Language].Buttons.OffsetCalc, nil, Dta.ui.modifyMeasurementsButtonClicked)
	Mainwindow.itemDetails.CoPaBtn = Dta.ui.createButton("itemDetailCoPaBtn", Mainwindow.itemDetails, 0, 175, 160, nil, Lang[Dta.Language].Buttons.CopyPaste, nil, Dta.ui.modifyCoPaButtonClicked)
	Mainwindow.itemDetails.SaveBtn = Dta.ui.createButton("itemDetailSaveBtn", Mainwindow.itemDetails, 145, 175, 160, nil, Lang[Dta.Language].Buttons.LoadSave, nil, Dta.ui.modifySaveButtonClicked)
	--Mainwindow.itemDetails.ImpExpBtn = Dta.ui.createButton("itemDetailImpExpBtn", Mainwindow.itemDetails, 290, 150, 160, nil, Lang[Dta.Language].Buttons.ImportExport, nil, Dta.ui.modifyImpExpButtonClicked)
	Mainwindow.itemDetails.DFlying = Dta.ui.createButton("itemDetailDFlyingBtn", Mainwindow.itemDetails, 0, 200, 160, nil, Lang[Dta.Language].Buttons.TribalMagic, nil, Dta.ui.modifyDFlyingButtonClicked)
	Mainwindow.itemDetails.Alphabet = Dta.ui.createButton("itemDetailAlphabetBtn", Mainwindow.itemDetails, 145, 200, 160, nil, "Alfiebet", nil, Dta.ui.modifyAlphabetButtonClicked)

	-- help button
	newWindow.help = Dta.ui.Button.Create("mainwindow_help", newWindow, Dta.help_ui.toggleHelpWindow,
		"btn_dimensions_top_help_(normal).png.dds",
		"btn_dimensions_top_help_(over).png.dds",
		"btn_dimensions_top_help_(click).png.dds")
	newWindow.help:SetPoint("TOPRIGHT", newWindow.closeBtn, "TOPLEFT", 0, -1)
	newWindow.help:SetWidth(36)
	newWindow.help:SetHeight(36)
	newWindow.help:SetLayer(11)
	if Dta.ui.activeHelp then
		newWindow.help:Toggle(true)
	end

	-- TODO: temp fix for new window hierarchy
	newWindow.itemDetails = Mainwindow.itemDetails

	return newWindow
end

-- Show the Main window
function Dta.ui.showMainWindow()
	Dta.constructions = Dta.settings.get_savedsets("SavedSets") --or {}
	Dta.constructionsdefaults = Dta.settings.get_defaultsets("SavedSets") --or {}
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
	if Dta.selectionCount > 0 then
		Dta.items.StartDetails()
	end
end

-- Hide the Main window
function Dta.ui.hideMainWindow()
	Dta.ui.windowtest:SetVisible(false)
--	Dta.ui.windowtest = nil
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
	Dta.settings.set("MainwindowPosX", Dta.ui.windowtest:GetLeft())
	Dta.settings.set("MainwindowPosY", Dta.ui.windowtest:GetTop())
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

function Dta.ui.clearSelectionButtonClicked()
	-- NOTE: in contrast to Dta.items.DeselectAll(), this function doesn't verify
	-- current selection state, and clears IDs from selection regardless of their validity.
	-- We want to recover from any selection state bugs here
	for id,Details in pairs(Dta.selectedItems) do
		local detail = Inspect.Dimension.Layout.Detail(Details.id)
		if detail ~= nil then
			Dta.items.QueueDeselection(Details.id)
		end
		-- already nil it here, item updates are not reliable when we lost sync unfortunately
		Dta.selectedItems[id] = nil
	end
end

-------------------------------
-- NOTIFICATION WINDOW
-------------------------------

function Dta.ui.buildNotificationWindow()
	local newWindow = Dta.ui.Window.CreatePopup("NotificationWindow",
							Dta.ui.context_top,
							500, -- width
							110, -- height
							100, 100, -- x, y
							true) -- movable

	newWindow.Message = Dta.ui.createText("confirmationDialogueMessage", newWindow, 10, 0, "-", 16)
	newWindow.Message:ClearPoint("TOPLEFT")
	newWindow.Message:SetPoint("TOPCENTER", newWindow, "TOPCENTER", 0, 10)
	newWindow.YesBtn = Dta.ui.createButton("errorBtn_Yes", newWindow, 80, 70, 160, nil, Lang[Dta.Language].Buttons.Yes, nil, Dta.ui.notificationWindowButtonClicked)
	newWindow.NoBtn = Dta.ui.createButton("errorBtn_No", newWindow, 260, 70, 160, nil, Lang[Dta.Language].Buttons.No, nil, Dta.ui.notificationWindowButtonClicked)
	return newWindow
end

function Dta.ui.showNotification(message, btn1_callback, btn2_callback, userdata, btn1_text, btn2_text)
	if Dta.ui.notificationWindow == nil then
		Dta.ui.notificationWindow = Dta.ui.buildNotificationWindow()
	end
	Dta.ui.notificationWindow.Message:SetText(message)
	Dta.ui.notificationWindow.YesBtn:SetText(btn1_text or Lang[Dta.Language].Buttons.Yes)
	Dta.ui.notificationWindow.NoBtn:SetText(btn2_text or Lang[Dta.Language].Buttons.No)
	Dta.ui.notificationWindow.YesBtn.click_callback = btn1_callback
	Dta.ui.notificationWindow.NoBtn.click_callback = btn2_callback
	Dta.ui.notificationWindow.user_data = userdata
	local x = (UIParent:GetWidth() - Dta.ui.notificationWindow:GetWidth())/2
	local y = (UIParent:GetHeight() - Dta.ui.notificationWindow:GetHeight())/2
	Dta.ui.notificationWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
	Dta.ui.notificationWindow:SetVisible(true)
end

function Dta.ui.showConfirmation(message, btn1_callback, btn2_callback, userdata)
	Dta.ui.showNotification(message, btn1_callback, btn2_callback, userdata,
							Lang[Dta.Language].Buttons.OK, Lang[Dta.Language].Buttons.Cancel)
end

function Dta.ui.notificationWindowButtonClicked(self, event)
	Dta.ui.notificationWindow:SetVisible(false)
	if type(self.click_callback) == "function" then
		self.click_callback(Dta.ui.notificationWindow.user_data)
	end
end
