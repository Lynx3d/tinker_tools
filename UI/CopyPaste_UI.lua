﻿Dta.copa_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS COPY/PASTE WINDOW
-------------------------------

local CopyPasteWindowSettings = {
	TITLE = Lang[Dta.Language].Titles.CopyPaste,
	WIDTH = 325,
	HEIGHT = 255,
	CLOSABLE = true,
	MOVABLE = true,
}

function Dta.copa_ui.buildCopyPasteWindow()
	local x = Dta.settings.get("CopyPastewindowPosX")
	local y = Dta.settings.get("CopyPastewindowPosY")
	local newWindow = Dta.ui.Window.Create("CopyPastewindow",
							Dta.ui.context,
							CopyPasteWindowSettings.TITLE,
							CopyPasteWindowSettings.WIDTH,
							CopyPasteWindowSettings.HEIGHT,
							x,
							y,
							CopyPasteWindowSettings.CLOSABLE,
							CopyPasteWindowSettings.MOVABLE,
							Dta.copa_ui.CopyPastewindowClosed,
							Dta.copa_ui.CopyPastewindowMoved
							)
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

	CopyPastewindow.copyPaste.copyBtn = Dta.ui.createButton("copyBtn", CopyPastewindow.copyPaste, 0, 110, nil, nil, Lang[Dta.Language].Buttons.Copy, nil, Dta.copa.copyButtonClicked)
	CopyPastewindow.copyPaste.pasteBtn = Dta.ui.createButton("pasteBtn", CopyPastewindow.copyPaste, 165, 110, nil, nil, Lang[Dta.Language].Buttons.Paste, nil, Dta.copa.pasteButtonClicked)

	CopyPastewindow.copyPaste.offsetLabel1 = Dta.ui.createText("copyPasteOffsetLabel1", CopyPastewindow.copyPaste, 45, 0, Lang[Dta.Language].Text.Offset, 11)
	CopyPastewindow.copyPaste.offsetLabel2 = Dta.ui.createText("copyPasteOffsetLabel3", CopyPastewindow.copyPaste, 155, 0, Lang[Dta.Language].Text.Offset, 11)
	CopyPastewindow.copyPaste.offsetLabel3 = Dta.ui.createText("copyPasteOffsetLabel4", CopyPastewindow.copyPaste, 260, 0, Lang[Dta.Language].Text.Offset, 11)

	CopyPastewindow.copyPaste.x = Dta.ui.createCheckbox("copyPasteX", CopyPastewindow.copyPaste, 0, 15, "X", true, {1, 0, 0, 1})
	CopyPastewindow.copyPaste.y = Dta.ui.createCheckbox("copyPasteY", CopyPastewindow.copyPaste, 0, 40, "Y", true, {0, 1, 0, 1})
	CopyPastewindow.copyPaste.z = Dta.ui.createCheckbox("copyPasteZ", CopyPastewindow.copyPaste, 0, 65, "Z", true, {0, 1, 1, 1})

	CopyPastewindow.copyPaste.yaw = Dta.ui.createCheckbox("copyPasteYaw", CopyPastewindow.copyPaste, 105, 15, Lang[Dta.Language].Text.Yaw, true, {0, 1, 0, 1})
	CopyPastewindow.copyPaste.pitch = Dta.ui.createCheckbox("copyPastePitch", CopyPastewindow.copyPaste, 105, 40, Lang[Dta.Language].Text.Pitch, true, {1, 0, 0, 1})
	CopyPastewindow.copyPaste.roll = Dta.ui.createCheckbox("copyPasteRoll", CopyPastewindow.copyPaste, 105, 65, Lang[Dta.Language].Text.Roll, true, {0, 1, 1, 1})

	CopyPastewindow.copyPaste.scale = Dta.ui.createCheckbox("copyPasteScale", CopyPastewindow.copyPaste, 210, 15, Lang[Dta.Language].Text.Scale, true)

	CopyPastewindow.copyPaste.xOffset = Dta.ui.createTextfield("copyPasteXOffset", CopyPastewindow.copyPaste, 45, 15, 40)
	CopyPastewindow.copyPaste.yOffset = Dta.ui.createTextfield("copyPasteYOffset", CopyPastewindow.copyPaste, 45, 40, 40)
	CopyPastewindow.copyPaste.zOffset = Dta.ui.createTextfield("copyPasteZOffset", CopyPastewindow.copyPaste, 45, 65, 40)

	CopyPastewindow.copyPaste.yawOffset = Dta.ui.createTextfield("copyPasteYawOffset", CopyPastewindow.copyPaste, 155, 15, 40)
	CopyPastewindow.copyPaste.pitchOffset = Dta.ui.createTextfield("copyPastePitchOffset", CopyPastewindow.copyPaste, 155, 40, 40)
	CopyPastewindow.copyPaste.rollOffset = Dta.ui.createTextfield("copyPasteRollOffset", CopyPastewindow.copyPaste, 155, 65, 40)

	CopyPastewindow.copyPaste.scaleOffset = Dta.ui.createTextfield("copyPasteScaleOffset", CopyPastewindow.copyPaste, 260, 15, 40)

	CopyPastewindow.copyPaste.multiplyOffsets = Dta.ui.createCheckbox("copyPasteMultiplyOffsets", CopyPastewindow.copyPaste, 0, 95, Lang[Dta.Language].Text.OffsetMultiItems, false, nil, Dta.copa.CopaOffsetChanged)
	CopyPastewindow.copyPaste.multiplyOffsets:SetVisible(true)

	CopyPastewindow.copyPaste.divider1 = Dta.ui.createTexture("dividerCopa", CopyPastewindow, "Dimtools", "textures/divider.png", 10, 155, CopyPastewindow:GetWidth()-10)
	CopyPastewindow.copyPaste.divider1:SetLayer(29)

	CopyPastewindow.copyPaste.NewItem = Dta.ui.createCheckbox("copyPasteNewItem", CopyPastewindow.copyPaste, 0, 165, Lang[Dta.Language].Text.UseNewItems, false, nil, Dta.copa.CopaNewItemChanged)

	CopyPastewindow.copyPaste.NewItemLabel = Dta.ui.createText("copyPasteNewItemLabel", CopyPastewindow.copyPaste, 0, 190, Lang[Dta.Language].Text.NrItems, 15)
	CopyPastewindow.copyPaste.NewItemLabel:SetVisible(false)

	CopyPastewindow.copyPaste.NewItemNr = Dta.ui.createTextfield("copyPasteNewItemNr", CopyPastewindow.copyPaste, 85, 190, 40)
	CopyPastewindow.copyPaste.NewItemNr:SetVisible(false)

	CopyPastewindow.copyPaste.Bags = Dta.ui.createCheckbox("copyPasteBags", CopyPastewindow.copyPaste, 0, 220, Lang[Dta.Language].Text.Bags, true, nil, Dta.copa.CopaBagsChanged)
	CopyPastewindow.copyPaste.Bags:SetVisible(false)
	CopyPastewindow.copyPaste.Bank = Dta.ui.createCheckbox("copyPasteBank", CopyPastewindow.copyPaste, 110, 220, Lang[Dta.Language].Text.BankBags, false, nil, Dta.copa.CopaBankChanged)
	CopyPastewindow.copyPaste.Bank:SetVisible(false)
	CopyPastewindow.copyPaste.Both = Dta.ui.createCheckbox("copyPasteBoth", CopyPastewindow.copyPaste, 235, 220, Lang[Dta.Language].Text.Vaults, false, nil, Dta.copa.CopaBothChanged)
	CopyPastewindow.copyPaste.Both:SetVisible(false)

	-- TODO: temp fix for new window hierarchy
	newWindow.copyPaste = CopyPastewindow.copyPaste
	return newWindow
end

-- Show the toolbox window
function Dta.copa_ui.showCopyPastewindow()
	if Dta.ui.windowCopyPaste == nil then
		Dta.ui.windowCopyPaste = Dta.copa_ui.buildCopyPasteWindow()
	else
		Dta.copa_ui.windowCopyPaste:SetVisible(true)
	end
	Dta.ui.activeCopyPaste = true
end

-- Hide the toolbox window
function Dta.copa_ui.hideCopyPastewindow()
	Dta.ui.windowCopyPaste:SetVisible(false)
	Dta.ui.windowCopyPaste = nil
	Dta.ui.activeCopyPaste = false
	Dta.clipboard = {}
end

-- Toggle the toolbox window
function Dta.copa_ui.toggleCopyPastewindow()
	if Dta.ui.windowCopyPaste then Dta.copa_ui.hideCopyPastewindow()
	else Dta.copa_ui.showCopyPastewindow() end
end

--Called when the window has been closed
function Dta.copa_ui.CopyPastewindowClosed()
	Dta.copa_ui.hideCopyPastewindow()
end

--Called when the window has been moved
function Dta.copa_ui.CopyPastewindowMoved()
	Dta.settings.set("CopyPastewindowPosX", Dta.ui.windowCopyPaste:GetLeft())
	Dta.settings.set("CopyPastewindowPosY", Dta.ui.windowCopyPaste:GetTop())
end
