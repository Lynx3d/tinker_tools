local Dta = select(2, ...)

Dta.copa_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS COPY/PASTE WINDOW
-------------------------------

local CopyPasteWindowSettings = {
	WIDTH = 325,
	HEIGHT = 260,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "CopyPastewindowPosX",
	POS_Y = "CopyPastewindowPosY"
}

function Dta.copa_ui.buildCopyPasteWindow()
	local x = Dta.settings.get("CopyPastewindowPosX")
	local y = Dta.settings.get("CopyPastewindowPosY")
	local newWindow = Dta.ui.Window.Create("CopyPastewindow",
							Dta.ui.context,
							Dta.Locale.Titles.CopyPaste,
							CopyPasteWindowSettings.WIDTH,
							CopyPasteWindowSettings.HEIGHT,
							x,
							y,
							CopyPasteWindowSettings.CLOSABLE,
							CopyPasteWindowSettings.MOVABLE,
							Dta.copa_ui.CopyPastewindowClosed,
							Dta.ui.WindowMoved
							)
	newWindow.settings = CopyPasteWindowSettings
	local CopyPastewindow = newWindow.content

	CopyPastewindow.background2 = UI.CreateFrame("Texture", "CopyPasteWindowBackground2", CopyPastewindow)
	CopyPastewindow.background2:SetPoint("BOTTOMCENTER", CopyPastewindow, "BOTTOMCENTER")
	CopyPastewindow.background2:SetWidth(CopyPasteWindowSettings.WIDTH)
	CopyPastewindow.background2:SetHeight(80)
	CopyPastewindow.background2:SetAlpha(0.3)
	CopyPastewindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	CopyPastewindow.background2:SetLayer(5)

	-------------------------------
	--ITEM DETAILS
	-------------------------------
	CopyPastewindow.copyPaste = Dta.ui.createFrame("copyPaste", CopyPastewindow, 10, 5, CopyPastewindow:GetWidth()-20, CopyPastewindow:GetHeight()-20)
	CopyPastewindow.copyPaste:SetLayer(30)
	--CopyPastewindow.copyPaste:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	CopyPastewindow.copyPaste.copyBtn = Dta.ui.createButton("copyBtn", CopyPastewindow.copyPaste, 0, 215, nil, nil, Dta.Locale.Buttons.Copy, nil, Dta.copa.copyButtonClicked)
	CopyPastewindow.copyPaste.pasteBtn = Dta.ui.createButton("pasteBtn", CopyPastewindow.copyPaste, 165, 215, nil, nil, Dta.Locale.Buttons.Paste, nil, Dta.copa.pasteButtonClicked)

	CopyPastewindow.copyPaste.offsetLabel1 = Dta.ui.createText("copyPasteOffsetLabel1", CopyPastewindow.copyPaste, 37, 0, Dta.Locale.Text.Offset, 11)
	CopyPastewindow.copyPaste.offsetLabel2 = Dta.ui.createText("copyPasteOffsetLabel3", CopyPastewindow.copyPaste, 157, 0, Dta.Locale.Text.Offset, 11)
	CopyPastewindow.copyPaste.offsetLabel3 = Dta.ui.createText("copyPasteOffsetLabel4", CopyPastewindow.copyPaste, 237, 57, Dta.Locale.Text.Offset, 11)

	CopyPastewindow.copyPaste.x = Dta.ui.createCheckbox("copyPasteX", CopyPastewindow.copyPaste, 0, 15, "X", true, {1, 0, 0, 1})
	CopyPastewindow.copyPaste.y = Dta.ui.createCheckbox("copyPasteY", CopyPastewindow.copyPaste, 0, 40, "Y", true, {0, 1, 0, 1})
	CopyPastewindow.copyPaste.z = Dta.ui.createCheckbox("copyPasteZ", CopyPastewindow.copyPaste, 0, 65, "Z", true, {0, 1, 1, 1})

	CopyPastewindow.copyPaste.pitch = Dta.ui.createCheckbox("copyPastePitch", CopyPastewindow.copyPaste, 100, 15, Dta.Locale.Text.Pitch, true, {1, 0, 0, 1})
	CopyPastewindow.copyPaste.yaw = Dta.ui.createCheckbox("copyPasteYaw", CopyPastewindow.copyPaste, 100, 40, Dta.Locale.Text.Yaw, true, {0, 1, 0, 1})
	CopyPastewindow.copyPaste.roll = Dta.ui.createCheckbox("copyPasteRoll", CopyPastewindow.copyPaste, 100, 65, Dta.Locale.Text.Roll, true, {0, 1, 1, 1})

	CopyPastewindow.copyPaste.scale = Dta.ui.createCheckbox("copyPasteScale", CopyPastewindow.copyPaste, 220, 15, Dta.Locale.Text.Scale, true)

	CopyPastewindow.copyPaste.xOffset = Dta.ui.createTextfield("copyPasteXOffset", CopyPastewindow.copyPaste, 35, 15, 50)
	CopyPastewindow.copyPaste.yOffset = Dta.ui.createTextfield("copyPasteYOffset", CopyPastewindow.copyPaste, 35, 40, 50)
	CopyPastewindow.copyPaste.zOffset = Dta.ui.createTextfield("copyPasteZOffset", CopyPastewindow.copyPaste, 35, 65, 50)

	CopyPastewindow.copyPaste.pitchOffset = Dta.ui.createTextfield("copyPastePitchOffset", CopyPastewindow.copyPaste, 155, 15, 45)
	CopyPastewindow.copyPaste.yawOffset = Dta.ui.createTextfield("copyPasteYawOffset", CopyPastewindow.copyPaste, 155, 40, 45)
	CopyPastewindow.copyPaste.rollOffset = Dta.ui.createTextfield("copyPasteRollOffset", CopyPastewindow.copyPaste, 155, 65, 45)

	CopyPastewindow.copyPaste.scaleOffset = Dta.ui.createTextfield("copyPasteScaleOffset", CopyPastewindow.copyPaste, 235, 40, 45)

	CopyPastewindow.copyPaste.multiplyOffsets = Dta.ui.createCheckbox("copyPasteMultiplyOffsets", CopyPastewindow.copyPaste, 0, 95, Dta.Locale.Text.OffsetMultiItems, false, nil, Dta.copa.CopaOffsetChanged)
	--CopyPastewindow.copyPaste.multiplyOffsets:SetVisible(true)

	CopyPastewindow.copyPaste.NewItemNrLabel = Dta.ui.createText("copyPasteNewItemLabel", CopyPastewindow.copyPaste, 170, 93, Dta.Locale.Text.NrItems, 14)
	CopyPastewindow.copyPaste.NewItemNrLabel:SetVisible(false)

	CopyPastewindow.copyPaste.NewItemNr = Dta.ui.createTextfield("copyPasteNewItemNr", CopyPastewindow.copyPaste, 260, 95, 40)
	CopyPastewindow.copyPaste.NewItemNr:SetVisible(false)

	CopyPastewindow.copyPaste.flickerReduce = Dta.ui.createCheckbox("copyPasteFlickerReduce", CopyPastewindow.copyPaste, 0, 120, Dta.Locale.Text.FlickerReduce, false, nil, Dta.copa.FlickerRedChanged)
	CopyPastewindow.copyPaste.flickerAmplitude = Dta.ui.createTextfield("copyPasteFlickerAmp", CopyPastewindow.copyPaste, 170, 120, 50, "0.001")
	CopyPastewindow.copyPaste.flickerAmplitude:SetVisible(false)

	CopyPastewindow.copyPaste.SelectionPivot = Dta.ui.createCheckbox("copyPasteSelPivot", CopyPastewindow.copyPaste, 0, 145, Dta.Locale.Text.SelectionPivot, false, nil, Dta.copa.PivotChanged)

	CopyPastewindow.copyPaste.pickPivotBtn = Dta.ui.createButton("pickPivotBtn", CopyPastewindow.copyPaste, 165, 140, nil, nil, Dta.Locale.Buttons.Pick, nil, Dta.copa.pickButtonClicked)
	CopyPastewindow.copyPaste.pickPivotBtn:SetVisible(false)

	CopyPastewindow.copyPaste.NewItem = Dta.ui.createCheckbox("copyPasteNewItem", CopyPastewindow.copyPaste, 0, 170, Dta.Locale.Text.UseNewItems, false, nil, Dta.copa.CopaNewItemChanged)

	CopyPastewindow.copyPaste.Bags = Dta.ui.createCheckbox("copyPasteBags", CopyPastewindow.copyPaste, 15, 195, Dta.Locale.Text.Bags, true, nil)
	CopyPastewindow.copyPaste.Bags:SetVisible(false)
	CopyPastewindow.copyPaste.Bank = Dta.ui.createCheckbox("copyPasteBank", CopyPastewindow.copyPaste, 120, 195, Dta.Locale.Text.BankBags, false, nil)
	CopyPastewindow.copyPaste.Bank:SetVisible(false)

	Dta.ui.AddFocusCycleElement(CopyPastewindow, CopyPastewindow.copyPaste.xOffset)
	Dta.ui.AddFocusCycleElement(CopyPastewindow, CopyPastewindow.copyPaste.yOffset)
	Dta.ui.AddFocusCycleElement(CopyPastewindow, CopyPastewindow.copyPaste.zOffset)
	Dta.ui.AddFocusCycleElement(CopyPastewindow, CopyPastewindow.copyPaste.pitchOffset)
	Dta.ui.AddFocusCycleElement(CopyPastewindow, CopyPastewindow.copyPaste.yawOffset)
	Dta.ui.AddFocusCycleElement(CopyPastewindow, CopyPastewindow.copyPaste.rollOffset)
	Dta.ui.AddFocusCycleElement(CopyPastewindow, CopyPastewindow.copyPaste.scaleOffset)
	CopyPastewindow:EventAttach(Event.UI.Input.Key.Down.Dive, Dta.ui.FocusCycleCallback, "CoPaWindow_TabFocusCycle")

	-- TODO: temp fix for new window hierarchy
	newWindow.copyPaste = CopyPastewindow.copyPaste
	return newWindow
end

-- Show the toolbox window
function Dta.copa_ui.showCopyPastewindow()
	if Dta.ui.windowCopyPaste == nil then
		Dta.ui.windowCopyPaste = Dta.copa_ui.buildCopyPasteWindow()
	else
		Dta.ui.windowCopyPaste:SetVisible(true)
	end
	Dta.ui.activeCopyPaste = true
end

-- Hide the toolbox window
function Dta.copa_ui.hideCopyPastewindow()
	Dta.ui.windowCopyPaste:SetVisible(false)
	Dta.ui.windowCopyPaste:ClearKeyFocus()
--	Dta.ui.windowCopyPaste = nil
	Dta.ui.activeCopyPaste = false
end

-- Toggle the toolbox window
function Dta.copa_ui.toggleCopyPastewindow()
	if Dta.ui.activeCopyPaste then Dta.copa_ui.hideCopyPastewindow()
	else Dta.copa_ui.showCopyPastewindow() end
end

--Called when the window has been closed
function Dta.copa_ui.CopyPastewindowClosed()
	Dta.copa_ui.hideCopyPastewindow()
end
