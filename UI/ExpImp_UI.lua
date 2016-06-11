local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.expimp_ui = {}

local ExpImpWindowSettings = {
	WIDTH = 325,
	HEIGHT = 290,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "ExpImpwindowPosX",
	POS_Y = "ExpImpwindowPosY"
}

function Dta.expimp_ui.buildExpImpWindow()
	local x = Dta.settings.get("ExpImpwindowPosX")
	local y = Dta.settings.get("ExpImpwindowPosY")
	local newWindow = Dta.ui.Window.Create("ExpImpWindow",
							Dta.ui.context,
							Lang[Dta.Language].Titles.ImportExport,
							ExpImpWindowSettings.WIDTH,
							ExpImpWindowSettings.HEIGHT,
							x,
							y,
							ExpImpWindowSettings.CLOSABLE,
							ExpImpWindowSettings.MOVABLE,
							Dta.expimp_ui.ExpImpWindowClosed,
							Dta.ui.WindowMoved
							)
	newWindow.settings = ExpImpWindowSettings
	local ExpImpwindow = newWindow.content

	ExpImpwindow.background2 = UI.CreateFrame("Texture", "ExpImpwindowBackground2", ExpImpwindow)
	ExpImpwindow.background2:SetPoint("BOTTOMCENTER", ExpImpwindow, "BOTTOMCENTER")
	ExpImpwindow.background2:SetWidth(ExpImpWindowSettings.WIDTH)
	ExpImpwindow.background2:SetHeight(80)
	ExpImpwindow.background2:SetAlpha(0.3)
	ExpImpwindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	ExpImpwindow.background2:SetLayer(5)

	-------------------------------
	--ITEM DETAILS
	-------------------------------
	ExpImpwindow.ImportExport = Dta.ui.createFrame("ImportExport", ExpImpwindow, 10, 5, ExpImpwindow:GetWidth()-20, ExpImpwindow:GetHeight()-20)
	ExpImpwindow.ImportExport:SetLayer(30)
	--ExpImpwindow.ImportExport:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	ExpImpwindow.ImportExport.ExportSavedCheckbox = Dta.ui.createCheckbox("ExportSavedCheckbox", ExpImpwindow.ImportExport, 55, 0, Lang[Dta.Language].Text.SavedSets, true, nil, Dta.expimp.ExportSavedCheckboxChanged)
	ExpImpwindow.ImportExport.ExportTbxCheckbox = Dta.ui.createCheckbox("ExportTbxCheckbox", ExpImpwindow.ImportExport, 175, 0, Lang[Dta.Language].Text.TbxSets, false, nil, Dta.expimp.ExportTbxCheckboxChanged)


	ExpImpwindow.ImportExport.ExportLabel = Dta.ui.createText("ImportExportExportLabel", ExpImpwindow.ImportExport, 0, 25, Lang[Dta.Language].Text.Name, 14)
	ExpImpwindow.ImportExport.ExportLoad = UI.CreateFrame("SimpleSelect", "ExportNameSelect", ExpImpwindow.ImportExport)
	ExpImpwindow.ImportExport.ExportLoad:SetPoint("TOPLEFT", ExpImpwindow.ImportExport, "TOPLEFT", 55, 25)
	ExpImpwindow.ImportExport.ExportLoad:SetLayer(100)
	ExpImpwindow.ImportExport.ExportLoad:SetItems(Dta.expimp.loadExport())
	ExpImpwindow.ImportExport.ExportLoad:ResizeToFit()
	ExpImpwindow.ImportExport.ExportLoad:SetWidth(245)
	ExpImpwindow.ImportExport.Export = Dta.ui.createButton("ImportExport_Export", ExpImpwindow.ImportExport, 0, 50, nil, nil, Lang[Dta.Language].Buttons.Export, nil, Dta.expimp.ImportExport_ExportClicked)

	ExpImpwindow.divider5 = Dta.ui.createTexture("divider5", ExpImpwindow, "Rift", "divider_06.png.dds", 10, 85, ExpImpwindow:GetWidth()-20)
	ExpImpwindow.divider5:SetLayer(29)

	ExpImpwindow.ImportExport.ImportLabel = Dta.ui.createText("ImportExportImportLabel", ExpImpwindow.ImportExport, 0, 100, Lang[Dta.Language].Text.Name, 14)
	ExpImpwindow.ImportExport.ImportLoad = UI.CreateFrame("SimpleSelect", "ImportNameSelect", ExpImpwindow.ImportExport)
	ExpImpwindow.ImportExport.ImportLoad:SetPoint("TOPLEFT", ExpImpwindow.ImportExport, "TOPLEFT", 55, 100)
	ExpImpwindow.ImportExport.ImportLoad:SetLayer(101)
	ExpImpwindow.ImportExport.ImportLoad:SetItems(Dta.expimp.loadImport())
	ExpImpwindow.ImportExport.ImportLoad:ResizeToFit()
	ExpImpwindow.ImportExport.ImportLoad:SetWidth(245)
	ExpImpwindow.ImportExport.NewNameLabel = Dta.ui.createText("ImportExportNewNameLabel", ExpImpwindow.ImportExport, 0, 125, Lang[Dta.Language].Text.NewName, 14)
	ExpImpwindow.ImportExport.NewName = Dta.ui.createTextfield("ImportExportNewName", ExpImpwindow.ImportExport, 85, 125, 215)
	ExpImpwindow.ImportExport.Import = Dta.ui.createButton("ImportExport_Import", ExpImpwindow.ImportExport, 0, 150, nil, nil, Lang[Dta.Language].Buttons.Import, nil, Dta.expimp.ImportExport_ImportClicked)
	ExpImpwindow.ImportExport.ImportText = Dta.ui.createButton("ImportExport_ImportText", ExpImpwindow.ImportExport, 165, 150, nil, nil, Lang[Dta.Language].Buttons.ImportText, nil, Dta.expimp.ImportTextClicked)

	ExpImpwindow.divider2 = Dta.ui.createTexture("expimp_divider2", ExpImpwindow, "Rift", "divider_06.png.dds", 10, 185, ExpImpwindow:GetWidth()-20)
	ExpImpwindow.divider2:SetLayer(29)

	local textView = Dta.ui.createTextfield("ExpImpText", ExpImpwindow.ImportExport, 0, 200, 305)
	ExpImpwindow.ImportExport.TextView = textView
	textView:SetHeight(70)
	textView:SetBackgroundColor(0, 0, 0, 0.5)
	textView.textHint = Lang[Dta.Language].Prints.TextHint
	textView:SetText(textView.textHint)
	textView.hint_active = true

	local function KeyFocusGain(self, hEvent)
		if self.hint_active then
			self:SetText("")
			self.hint_active = false
		end
	end
	local function KeyFocusLoss(self, hEvent)
		if #self:GetText() == 0 then
			self:SetText(self.textHint)
			self.hint_active = true
		end
	end

	textView:EventAttach(Event.UI.Input.Key.Focus.Gain, KeyFocusGain, "TextHintHide")
	textView:EventAttach(Event.UI.Input.Key.Focus.Loss, KeyFocusLoss, "TextHintShow")
	-- TODO: temp fix for new window hierarchy
	newWindow.ImportExport = ExpImpwindow.ImportExport

	return newWindow
end

-- Show the toolbox window
function Dta.expimp_ui.showExpImpWindow()
	if Dta.ui.windowExpImp == nil then
		Dta.ui.windowExpImp = Dta.expimp_ui.buildExpImpWindow()
	else
		Dta.ui.windowExpImp:SetVisible(true)
		Dta.ui.windowExpImp.ImportExport.ExportLoad:SetEnabled(true)
		Dta.ui.windowExpImp.ImportExport.ImportLoad:SetEnabled(true)
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
--	Dta.ui.windowExpImp = nil
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
