local Dta = select(2, ...)

Dta.ui = {}

Dta.ui.context = UI.CreateContext("Dta")
Dta.ui.context_top = UI.CreateContext("Dta_Top")
Dta.ui.context_top:SetStrata("topmost")
Dta.ui.windowtest = nil
Dta.ui.active = false
Dta.ui.restore = {}

Dta.ui.windowHelp = nil
Dta.ui.activeHelp = false

Dta.ui.loadLoSa = "Default"
Dta.ui.loadExpImp = "Saved"

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

function Dta.ui.ModifierKeyDownCallback(frame, hEvent, key)
	if key == "Shift" then
		Dta.ui.isShiftPressed = true
	elseif key == "Control" then
		Dta.ui.isControlPressed = true
	end
end

function Dta.ui.ModifierKeyUpCallback(frame, hEvent, key)
	if key == "Shift" then
		Dta.ui.isShiftPressed = false
	elseif key == "Control" then
		Dta.ui.isControlPressed = false
	end
end

function Dta.ui.KeyFocusLossCallback(frame, hEvent)
	if not Dta.ui.keyFocusTransfer then
		Dta.ui.isShiftPressed = false
		Dta.ui.isControlPressed = false
	end
end

-- Note: attaching to UIParent will trigger for any addon
UIParent:EventAttach(Event.UI.Input.Key.Down.Dive, Dta.ui.ModifierKeyDownCallback, "ShiftKeyDownSensor")
UIParent:EventAttach(Event.UI.Input.Key.Up.Dive, Dta.ui.ModifierKeyUpCallback, "ShiftKeyUpSensor")
UIParent:EventAttach(Event.UI.Input.Key.Focus.Loss.Dive, Dta.ui.KeyFocusLossCallback, "KeyFocusSensor")

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
	Dta.ui.keyFocusTransfer = true
	frame.focusCycleList[idx]:SetKeyFocus(true)
	Dta.ui.keyFocusTransfer = false
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
	if x and y then
		textFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	end
	if color ~= nil then textFrame:SetFontColor(color[1], color[2], color[3], color[4]) end
	if shadow ~= false then textFrame:SetEffectGlow({offsetX=1, offsetY=1}) end
	return textFrame
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

-- textfield helper functions
-- TODO: think about proper class hierarchies
function Dta.ui.textfieldSelectAll(self)
	local sval = self:GetText()
	local slen = sval and string.len(sval) or 0
	if slen > 0 then self:SetSelection(0, slen) end
end

local function textfieldSwapText(self)
	local currentText = self:GetText()
	self:SetText(self.text_alt or "")
	self.text_alt = currentText
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
	textfield.SwapText = textfieldSwapText
	return textfield
end

-- create reload button to accompany certain textfields
function Dta.ui.createReloadButton(name, parent, x, y, callback)
	local reloadBtn = Dta.ui.Button.Create(name, parent, callback,
			"textures/reload_btn_normal.png",
			"textures/reload_btn_over.png",
			"textures/reload_btn_click.png",
			"textures/reload_btn_disable.png",
			Dta.AddonID
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
		if checkbox:GetEnabled() then
			checkbox:SetChecked(not checkbox:GetChecked())
		end
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

-- create drop-down
function Dta.ui.createDropdown(name, parent, x, y, width)
	local dropdown = UI.CreateFrame("SimpleSelect", name, parent)
	dropdown:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	dropdown:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	if width then dropdown:SetWidth(width) end
	return dropdown
end

-------------------------------
-- BUILD THE MAINWINDOW TOGGLE BUTTON
-------------------------------

local MainButtonSettings = {
	POS_X = "MainbuttonPosX",
	POS_Y = "MainbuttonPosY"
}

function Dta.ui.showMainButton()
	if not Dta.ui.buttonMainToggle then
		Dta.ui.buttonMainToggle = Dta.ui.Button.Create("UI_Toggle_Button", Dta.ui.context,
			function(self, h) Dta.ui.toggleMainWindow() end,
			"btn_dimensions_top_edit_(normal).png.dds",
			"btn_dimensions_top_edit_(over).png.dds",
			"btn_dimensions_top_edit_(click).png.dds",
			"btn_dimensions_top_edit_(disabled).png.dds"
			)
		Dta.ui.buttonMainToggle.settings = MainButtonSettings
		Dta.ui.buttonMainToggle:SetWidth(48)
		Dta.ui.buttonMainToggle:SetHeight(48)
		Dta.ui.buttonMainToggle:SetLayer(-1)
		Dta.ui.buttonMainToggle:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Dta.settings.get("MainbuttonPosX"), Dta.settings.get("MainbuttonPosY"))
		Dta.ui.DraggableFrame.Setup(Dta.ui.buttonMainToggle, Dta.ui.buttonMainToggle, Dta.ui.WindowMoved, "Right")
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
	HEIGHT = 255,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "MainwindowPosX",
	POS_Y = "MainwindowPosY"
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
							Dta.Locale.Titles.Main,
							MainWindowSettings.WIDTH,
							MainWindowSettings.HEIGHT,
							x, y,
							MainWindowSettings.CLOSABLE,
							MainWindowSettings.MOVABLE,
							Dta.ui.MainWindowClosed,
							Dta.ui.WindowMoved
							)
	newWindow.settings = MainWindowSettings
	newWindow.versionText = Dta.ui.createText("versionText", newWindow, 20, 16, Dta.Version, 12, {0.3, 0.6, 0.6, 1})
	newWindow.versionText:SetLayer(15)
	local Mainwindow = newWindow.content

	Mainwindow.detailsBG = UI.CreateFrame("Canvas", "ItemDetailsBackground", Mainwindow)
	Mainwindow.detailsBG:SetPoint("TOPLEFT", Mainwindow, "TOPLEFT", 5, 3)
	Mainwindow.detailsBG:SetShape(BGpath, {type = "solid", r=0.07, g=0.01, b=0, a=0.6}, {r=0, g=0, b=0, a=0.4, thickness=3})
	-------------------------------
	--ITEM DETAILS
	-------------------------------

	Mainwindow.itemDetails = Dta.ui.createFrame("itemDetails", Mainwindow, 10, 13, Mainwindow:GetWidth()-20, 120)
	Mainwindow.itemDetails:SetLayer(30)
	--Mainwindow.itemDetails:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	Mainwindow.itemDetails.icon = Dta.ui.createTexture("itemDetailsIcon", Mainwindow.itemDetails, nil, nil, 0, 0, 25, 25)
	Mainwindow.itemDetails.icon:SetLayer(35)
	Mainwindow.itemDetails.name = Dta.ui.createText("itemDetailsName", Mainwindow.itemDetails, 30, 0, Dta.Locale.Text.NothingSelected, 16)
	Mainwindow.itemDetails.name:SetWidth(270)
	Mainwindow.itemDetails.name:SetWordwrap(true)
	Mainwindow.itemDetails.name:ClearPoint("TOPLEFT")
	Mainwindow.itemDetails.name:SetPoint("CENTERLEFT", Mainwindow.itemDetails, "TOPLEFT", 41, 12)
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

	Mainwindow.itemDetails.pitchLabel = Dta.ui.createText("itemDetailsPitchLabel", Mainwindow.itemDetails, 125, 30, Dta.Locale.Text.Pitch, 14, {1, 0, 0, 1})
	Mainwindow.itemDetails.yawLabel = Dta.ui.createText("itemDetailsYawLabel", Mainwindow.itemDetails, 125, 50, Dta.Locale.Text.Yaw, 14, {0, 1, 0, 1})
	Mainwindow.itemDetails.rollLabel = Dta.ui.createText("itemDetailsRollLabel", Mainwindow.itemDetails, 125, 70, Dta.Locale.Text.Roll, 14, {0, 1, 1, 1})

	Mainwindow.itemDetails.pitch = Dta.ui.createText("itemDetailsPitch", Mainwindow.itemDetails, 175, 30, "-", 14)
	Mainwindow.itemDetails.yaw = Dta.ui.createText("itemDetailsYaw", Mainwindow.itemDetails, 175, 50, "-", 14)
	Mainwindow.itemDetails.roll = Dta.ui.createText("itemDetailsRoll", Mainwindow.itemDetails, 175, 70, "-", 14)

	Mainwindow.itemDetails.scaleLabel = Dta.ui.createText("itemDetailsScaleLabel", Mainwindow.itemDetails, 0, 90, Dta.Locale.Text.Scale, 14)
	Mainwindow.itemDetails.scale = Dta.ui.createText("itemDetailsScale", Mainwindow.itemDetails, 50, 90, "-", 14)


	-- Tool Buttons
	Mainwindow.itemDetails.MoveBtn = Dta.ui.createButton("itemDetailMoveBtn", Mainwindow, 8, 133, 160, nil, Dta.Locale.Buttons.MoveWindow, nil, Dta.Tools.Move.Toggle)
	Mainwindow.itemDetails.RotateBtn = Dta.ui.createButton("itemDetailRotateBtn", Mainwindow, 157, 133, 160, nil, Dta.Locale.Buttons.RotateWindow, nil, Dta.Tools.Rotate.Toggle)
	Mainwindow.itemDetails.ScaleBtn = Dta.ui.createButton("mitemDetailScaleBtn", Mainwindow, 8, 160, 160, nil, Dta.Locale.Buttons.ScaleWindow, nil, Dta.Tools.Scale.Toggle)
	Mainwindow.itemDetails.Measurements = Dta.ui.createButton("itemDetailMeasurementsBtn", Mainwindow, 157, 160, 160, nil, Dta.Locale.Buttons.OffsetCalc, nil, Dta.Tools.Offset.Toggle)
	Mainwindow.itemDetails.CoPaBtn = Dta.ui.createButton("itemDetailCoPaBtn", Mainwindow, 8, 187, 160, nil, Dta.Locale.Buttons.CopyPaste, nil, Dta.Tools.CoPa.Toggle)
	Mainwindow.itemDetails.SaveBtn = Dta.ui.createButton("itemDetailSaveBtn", Mainwindow, 157, 187, 160, nil, Dta.Locale.Buttons.LoadSave, nil, Dta.Tools.LoSa.Toggle)
	--Mainwindow.itemDetails.ImpExpBtn = Dta.ui.createButton("itemDetailImpExpBtn", Mainwindow.itemDetails, 290, 150, 160, nil, Dta.Locale.Buttons.ImportExport, nil, Dta.Tools.ExpImp.Toggle)
	Mainwindow.itemDetails.DFlying = Dta.ui.createButton("itemDetailDFlyingBtn", Mainwindow, 8, 214, 160, nil, Dta.Locale.Buttons.TribalMagic, nil, Dta.Tools.Flying.Toggle)
	Mainwindow.itemDetails.MoreBtn = Dta.ui.createButton("itemDetailMoreBtn", Mainwindow, 157, 214, 160, nil, Dta.Locale.Buttons.More, nil, Dta.ui.moreBtnClicked)
	-- Expanded
	Mainwindow.itemDetails.Alphabet = Dta.ui.createButton("itemDetailAlphabetBtn", Mainwindow, 157, 214, 160, nil, "Alfiebet", nil, Dta.Tools.Alfiebet.Toggle)
	Mainwindow.itemDetails.ReskinBtn = Dta.ui.createButton("itemDetailReskinBtn", Mainwindow, 8, 241, 160, nil, Dta.Locale.Buttons.Reskin, nil, Dta.Tools.Reskin.Toggle)
	Mainwindow.itemDetails.SelectionsBtn = Dta.ui.createButton("itemDetailSelectionBtn", Mainwindow, 157, 241, 160, nil, Dta.Locale.Buttons.Selection, nil, Dta.Tools.Select.Toggle)
	Mainwindow.itemDetails.LessBtn = Dta.ui.createButton("itemDetailLessBtn", Mainwindow, 8, 268, 160, nil, Dta.Locale.Buttons.Less, nil, Dta.ui.lessBtnClicked)
	Mainwindow.itemDetails.Alphabet:SetVisible(false)
	Mainwindow.itemDetails.ReskinBtn:SetVisible(false)
	Mainwindow.itemDetails.SelectionsBtn:SetVisible(false)
	Mainwindow.itemDetails.LessBtn:SetVisible(false)

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
	Dta.constructionsdefaults = Dta.settings.get_defaults("SavedSets") --or {}
	Dta.constructionstbx = tbx_import.get("savedConstructions")
	Dta.ExportImport_Sets = Dta_export.get("ExportImport")--or {}
	--Dta.alphabet.Fonts = Dta.settings.get_alphabetFonts("SavedAlphabets")
	--Dta.Replacement.Skins = Dta.settings.get_Skins("SavedSkins")
	if Dta.ui.windowtest == nil then
		Dta.ui.windowtest = Dta.ui.buildMainWindow()
	else
		Dta.ui.windowtest:SetVisible(true)
	end
	Dta.ui.active = true
	Dta.items.updateItemDetails()
	if Dta.settings.get("RestoreTools") then
		for name, active in pairs(Dta.ui.restore) do
			if active then
				Dta.Tools[name]:Toggle()
			end
		end
	end
end

-- Hide the Main window
function Dta.ui.hideMainWindow()
	Dta.ui.windowtest:SetVisible(false)
--	Dta.ui.windowtest = nil
	Dta.ui.active = false
	for name, tool in pairs(Dta.Tools) do
		local active = tool:IsActive()
		if active then
			tool.Toggle()
		end
		Dta.ui.restore[name] = active
	end
	if Dta.ui.activeHelp then Dta.help_ui.hideHelpWindow() end
end

-- Toggle the Main window
function Dta.ui.toggleMainWindow()
	if Dta.ui.active then Dta.ui.hideMainWindow()
	else Dta.ui.showMainWindow() end
end

--Called when the window has been moved
function Dta.ui.WindowMoved(self)
	Dta.settings.set(self.settings.POS_X, self:GetLeft())
	Dta.settings.set(self.settings.POS_Y, self:GetTop())
end

--Called when the window has been closed
function Dta.ui.MainWindowClosed()
	Dta.ui.hideMainWindow()
end

-------------------------------
-- CALLBACKS FOR WINDOW BUTTONS
-------------------------------

function Dta.ui.moreBtnClicked()
	local itemDetails = Dta.ui.windowtest.itemDetails
	itemDetails.Alphabet:SetVisible(true)
	itemDetails.ReskinBtn:SetVisible(true)
	itemDetails.SelectionsBtn:SetVisible(true)
	itemDetails.LessBtn:SetVisible(true)
	itemDetails.MoreBtn:SetVisible(false)
	Dta.ui.windowtest:SetContentHeight(MainWindowSettings.HEIGHT + 2*27)
end

function Dta.ui.lessBtnClicked()
	local itemDetails = Dta.ui.windowtest.itemDetails
	itemDetails.Alphabet:SetVisible(false)
	itemDetails.ReskinBtn:SetVisible(false)
	itemDetails.SelectionsBtn:SetVisible(false)
	itemDetails.LessBtn:SetVisible(false)
	itemDetails.MoreBtn:SetVisible(true)
	Dta.ui.windowtest:SetContentHeight(MainWindowSettings.HEIGHT)
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
	Dta.selectionCount = 0
	Dta.items.updateItemDetails()
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
	newWindow.YesBtn = Dta.ui.createButton("errorBtn_Yes", newWindow, 80, 70, 160, nil, Dta.Locale.Buttons.Yes, nil, Dta.ui.notificationWindowButtonClicked)
	newWindow.NoBtn = Dta.ui.createButton("errorBtn_No", newWindow, 260, 70, 160, nil, Dta.Locale.Buttons.No, nil, Dta.ui.notificationWindowButtonClicked)
	return newWindow
end

-- if btn<n>_callcack is a function, it will be called with userdata as argument on button press,
-- else if userdata is a coroutine, the coroutine will be resumed with btn<n>_callback as argument
function Dta.ui.showNotification(message, btn1_callback, btn2_callback, userdata, btn1_text, btn2_text)
	if Dta.ui.notificationWindow == nil then
		Dta.ui.notificationWindow = Dta.ui.buildNotificationWindow()
	end
	Dta.ui.notificationWindow.Message:SetText(message)
	Dta.ui.notificationWindow.YesBtn:SetText(btn1_text or Dta.Locale.Buttons.Yes)
	Dta.ui.notificationWindow.NoBtn:SetText(btn2_text or Dta.Locale.Buttons.No)
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
							Dta.Locale.Buttons.OK, Dta.Locale.Buttons.Cancel)
end

function Dta.ui.notificationWindowButtonClicked(self, event)
	Dta.ui.notificationWindow:SetVisible(false)
	if type(self.click_callback) == "function" then
		self.click_callback(Dta.ui.notificationWindow.user_data)
	elseif type(Dta.ui.notificationWindow.user_data) == "thread" then
		coroutine.resume(Dta.ui.notificationWindow.user_data, self.click_callback)
	end
end
