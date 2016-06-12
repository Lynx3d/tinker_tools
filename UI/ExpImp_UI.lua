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
	local expImp = Dta.ui.createFrame("ImportExport", ExpImpwindow, 10, 5, ExpImpwindow:GetWidth()-20, ExpImpwindow:GetHeight()-20)
	expImp:SetLayer(30)
	--expImp:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	expImp.ExportSavedCheckbox = Dta.ui.createCheckbox("ExportSavedCheckbox", expImp, 55, 0, Lang[Dta.Language].Text.SavedSets, true, nil, Dta.expimp.ExportSavedCheckboxChanged)
	expImp.ExportTbxCheckbox = Dta.ui.createCheckbox("ExportTbxCheckbox", expImp, 175, 0, Lang[Dta.Language].Text.TbxSets, false, nil, Dta.expimp.ExportTbxCheckboxChanged)


	expImp.ExportLabel = Dta.ui.createText("ImportExportExportLabel", expImp, 0, 25, Lang[Dta.Language].Text.Name, 14)
	expImp.ExportLoad = UI.CreateFrame("SimpleSelect", "ExportNameSelect", expImp)
	expImp.ExportLoad:SetPoint("TOPLEFT", expImp, "TOPLEFT", 55, 25)
	expImp.ExportLoad:SetLayer(100)
	expImp.ExportLoad:SetItems(Dta.expimp.loadExport())
	expImp.ExportLoad:ResizeToFit()
	expImp.ExportLoad:SetWidth(245)
	expImp.Export = Dta.ui.createButton("ImportExport_Export", expImp, 0, 50, nil, nil, Lang[Dta.Language].Buttons.Export, nil, Dta.expimp.ImportExport_ExportClicked)
	expImp.ExportText = Dta.ui.createButton("ImpExp_ExportText", expImp, 165, 50, nil, nil, Lang[Dta.Language].Buttons.ExportText, nil, Dta.expimp.ExportTextClicked)

	expImp.divider5 = Dta.ui.createTexture("divider5", expImp, "Rift", "divider_06.png.dds", 0, 80, expImp:GetWidth())
	--ExpImpwindow.divider5:SetLayer(29)

	expImp.ImportLabel = Dta.ui.createText("ImportExportImportLabel", expImp, 0, 100, Lang[Dta.Language].Text.Name, 14)
	expImp.ImportLoad = UI.CreateFrame("SimpleSelect", "ImportNameSelect", expImp)
	expImp.ImportLoad:SetPoint("TOPLEFT", expImp, "TOPLEFT", 55, 100)
	expImp.ImportLoad:SetLayer(101)
	expImp.ImportLoad:SetItems(Dta.expimp.loadImport())
	expImp.ImportLoad:ResizeToFit()
	expImp.ImportLoad:SetWidth(245)
	expImp.NewNameLabel = Dta.ui.createText("ImportExportNewNameLabel", expImp, 0, 125, Lang[Dta.Language].Text.NewName, 14)
	expImp.NewName = Dta.ui.createTextfield("ImportExportNewName", expImp, 85, 125, 215)
	expImp.Import = Dta.ui.createButton("ImportExport_Import", expImp, 0, 150, nil, nil, Lang[Dta.Language].Buttons.Import, nil, Dta.expimp.ImportExport_ImportClicked)
	expImp.ImportText = Dta.ui.createButton("ImportExport_ImportText", expImp, 165, 150, nil, nil, Lang[Dta.Language].Buttons.ImportText, nil, Dta.expimp.ImportTextClicked)

	expImp.divider2 = Dta.ui.createTexture("expimp_divider2", expImp, "Rift", "divider_06.png.dds", 0, 180, ExpImpwindow:GetWidth())
	--ExpImpwindow.divider2:SetLayer(29)

	local textView = Dta.ui.createTextfield("ExpImpText", expImp, 0, 200, 305)
	expImp.TextView = textView
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
	newWindow.ImportExport = expImp

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
