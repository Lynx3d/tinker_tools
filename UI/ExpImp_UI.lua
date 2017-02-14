local Dta = select(2, ...)

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
							Dta.Locale.Titles.ImportExport,
							ExpImpWindowSettings.WIDTH,
							ExpImpWindowSettings.HEIGHT,
							x,
							y,
							ExpImpWindowSettings.CLOSABLE,
							ExpImpWindowSettings.MOVABLE,
							Dta.expimp_ui.hideExpImpWindow,
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

	expImp.ExportSavedCheckbox = Dta.ui.createCheckbox("ExportSavedCheckbox", expImp, 55, 0, Dta.Locale.Text.SavedSets, true, nil, Dta.expimp.ExportSavedCheckboxChanged)
	expImp.ExportTbxCheckbox = Dta.ui.createCheckbox("ExportTbxCheckbox", expImp, 175, 0, Dta.Locale.Text.TbxSets, false, nil, Dta.expimp.ExportTbxCheckboxChanged)


	expImp.ExportLabel = Dta.ui.createText("ImpExp_ExportLabel", expImp, 0, 25, Dta.Locale.Text.Name, 14)
	expImp.ExportLoad = Dta.ui.createDropdown("ImpExp_ExportNameSelect", expImp, 55, 25, 245)
	expImp.ExportLoad:SetItems(Dta.expimp.loadExport())
	expImp.Export = Dta.ui.createButton("ImpExp_Export", expImp, 0, 50, nil, nil, Dta.Locale.Buttons.Export, nil, Dta.expimp.ExportClicked)
	expImp.ExportText = Dta.ui.createButton("ImpExp_ExportText", expImp, 165, 50, nil, nil, Dta.Locale.Buttons.ExportText, nil, Dta.expimp.ExportTextClicked)

	expImp.divider1 = Dta.ui.createTexture("ImpExp_divider1", expImp, "Rift", "divider_06.png.dds", 0, 80, expImp:GetWidth())

	expImp.ImportLabel = Dta.ui.createText("ImpExp_ImportLabel", expImp, 0, 100, Dta.Locale.Text.Name, 14)
	expImp.ImportLoad = Dta.ui.createDropdown("ImpExp_ImportNameSelect", expImp, 55, 100, 245)
	expImp.ImportLoad:SetItems(Dta.expimp.loadImport())
	expImp.NewNameLabel = Dta.ui.createText("ImpExp_NewNameLabel", expImp, 0, 125, Dta.Locale.Text.NewName, 14)
	expImp.NewName = Dta.ui.createTextfield("ImpExp_NewName", expImp, 85, 125, 215)
	expImp.Import = Dta.ui.createButton("ImpExp_Import", expImp, 0, 150, nil, nil, Dta.Locale.Buttons.Import, nil, Dta.expimp.ImportClicked)
	expImp.ImportText = Dta.ui.createButton("ImpExp_ImportText", expImp, 165, 150, nil, nil, Dta.Locale.Buttons.ImportText, nil, Dta.expimp.ImportTextClicked)

	expImp.divider2 = Dta.ui.createTexture("ImpExp_divider2", expImp, "Rift", "divider_06.png.dds", 0, 180, expImp:GetWidth())

	local textView = Dta.ui.createTextfield("ImpExp_Text", expImp, 0, 200, 305)
	expImp.TextView = textView
	textView:SetHeight(70)
	textView:SetBackgroundColor(0, 0, 0, 0.5)
	textView.textHint = Dta.Locale.Prints.TextHint
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

	-- "abuse" cycle function for clearing input focus on 'return' key
	expImp.NewName:EventAttach(Event.UI.Input.Key.Down, Dta.ui.FocusCycleCallback, "ExpImp_TabFocusCycle")
	-- TODO: temp fix for new window hierarchy
	newWindow.ImportExport = expImp

	return newWindow
end

-- Show the toolbox window
function Dta.expimp_ui.showExpImpWindow(exim_window)
	exim_window:SetVisible(true)
	exim_window.ImportExport.ExportLoad:SetEnabled(true)
	exim_window.ImportExport.ImportLoad:SetEnabled(true)
	-- ??
	Dta.ui.loadExpImp = "Saved"
	Dta.expimp.refreshExportSelect()
end

-- Hide the toolbox window
function Dta.expimp_ui.hideExpImpWindow(exim_window)
	exim_window:SetVisible(false)
	exim_window:ClearKeyFocus()
	exim_window.ImportExport.ExportLoad:SetEnabled(false)
	exim_window.ImportExport.ImportLoad:SetEnabled(false)
end

Dta.RegisterTool("ExpImp", Dta.expimp_ui.buildExpImpWindow, Dta.expimp_ui.showExpImpWindow, Dta.expimp_ui.hideExpImpWindow)
