local Dta = select(2, ...)

Dta.help_ui = {}

local HelpWindowSettings = {
	WIDTH = 820,
	HEIGHT = 520,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "HelpwindowPosX",
	POS_Y = "HelpwindowPosY"
}

function Dta.help_ui.buildHelpWindow()
	local x = Dta.settings.get("HelpwindowPosX")
	local y = Dta.settings.get("HelpwindowPosY")
	local newWindow = Dta.ui.Window.Create("HelpWindow",
							Dta.ui.context,
							Dta.Locale.Titles.Help,
							HelpWindowSettings.WIDTH,
							HelpWindowSettings.HEIGHT,
							x,
							y,
							HelpWindowSettings.CLOSABLE,
							HelpWindowSettings.MOVABLE,
							Dta.help_ui.HelpWindowClosed,
							Dta.ui.WindowMoved
							)
	newWindow.settings = HelpWindowSettings
	if Dta.settings.get("WindowStyle") == "classic" then
		newWindow:SetBackground("Rift", "dimension_window_background_large.png.dds", {14, 12, 14, 14}, 0)
	else
		newWindow:SetBackground("Rift", "dimension_window_background_large.png.dds", {18, 26, 1006, 996}, 0)
	end
	local Helpwindow = newWindow.content
	-------------------------------
	--HELP CONTENT
	-------------------------------
	Helpwindow.IndexWindow = UI.CreateFrame("Texture", "IndexWindow_Background", Helpwindow)
	Helpwindow.IndexWindow:SetPoint("TOPLEFT", Helpwindow, "TOPLEFT", 3, 8)
	Helpwindow.IndexWindow:SetPoint("BOTTOMRIGHT", Helpwindow, "BOTTOMLEFT", 200, -5)
	Helpwindow.IndexWindow:SetTexture("Rift", "dimension_window_itemlist_bg2.png.dds")
	Helpwindow.IndexWindow:SetLayer(40)

	Helpwindow.ScrollIndexLoad = UI.CreateFrame("SimpleScrollView", "HelpScrollIndexLoad", Helpwindow.IndexWindow)
	Helpwindow.ScrollIndexLoad:SetPoint("TOPLEFT", Helpwindow.IndexWindow, "TOPLEFT", 15, 10)
	Helpwindow.ScrollIndexLoad:SetPoint("BOTTOMRIGHT", Helpwindow.IndexWindow, "BOTTOMRIGHT", -15, -10)
	Helpwindow.ScrollIndexLoad:SetLayer(50)
	Helpwindow.ScrollIndexLoad:SetBackgroundColor(0, 0, 0, 0)

	Helpwindow.HelpIndex = UI.CreateFrame("SimpleList", "HelpIndex", Helpwindow.ScrollIndexLoad)
	Helpwindow.HelpIndex.Event.ItemSelect = function(view, item, val, index) Dta.Help.InfoHandler(index) end
	local HelpIndex = Dta.Help.helpIndex
	Helpwindow.HelpIndex:SetItems(HelpIndex)
	Helpwindow.HelpIndex:SetBackgroundColor(0, 0, 0, 0)
	Helpwindow.HelpIndex:SetSelectionBackgroundColor(0, 0.5, 0.5, 0.5)
	Helpwindow.HelpIndex:SetFontSize(15)

	Helpwindow.ScrollIndexLoad:SetContent(Helpwindow.HelpIndex)

	-------------------------------------------------------------------
	Helpwindow.InfoWindow = UI.CreateFrame("Texture", "InfoWindow_Background", Helpwindow)
	Helpwindow.InfoWindow:SetPoint("TOPLEFT", Helpwindow, "TOPLEFT", 175, 0)
	Helpwindow.InfoWindow:SetPoint("BOTTOMRIGHT", Helpwindow, "BOTTOMRIGHT", 16, 4)
	Helpwindow.InfoWindow:SetTexture("Rift", "dimensions_itemlist_window_bottom.png.dds")
	Helpwindow.InfoWindow:SetLayer(40)

	Helpwindow.ScrollInfoLoad = UI.CreateFrame("SimpleScrollView", "HelpScrollInfoLoad", Helpwindow.InfoWindow)
	Helpwindow.ScrollInfoLoad:SetPoint("TOPLEFT", Helpwindow.InfoWindow, "TOPLEFT", 40, 20)
	Helpwindow.ScrollInfoLoad:SetPoint("BOTTOMRIGHT", Helpwindow.InfoWindow, "BOTTOMRIGHT", -40, -20)
	Helpwindow.ScrollInfoLoad:SetBackgroundColor(0, 0, 0, 0)

	Helpwindow.HelpInfo = UI.CreateFrame("Frame", "HelpInfo", Helpwindow.ScrollInfoLoad)

	Helpwindow.HeaderInfo = UI.CreateFrame("Text", "HeaderInfo", Helpwindow.HelpInfo)
	Helpwindow.TextInfo01 = UI.CreateFrame("Text", "TextInfo01", Helpwindow.HelpInfo)
	Helpwindow.TextInfo02 = UI.CreateFrame("Text", "TextInfo02", Helpwindow.HelpInfo)
	Helpwindow.TextInfo03 = UI.CreateFrame("Text", "TextInfo03", Helpwindow.HelpInfo)
	Helpwindow.PicInfo01 = UI.CreateFrame("Texture", "PicInfo01", Helpwindow.HelpInfo)
	Helpwindow.PicInfo02 = UI.CreateFrame("Texture", "PicInfo02", Helpwindow.HelpInfo)
	Helpwindow.PicInfo03 = UI.CreateFrame("Texture", "PicInfo03", Helpwindow.HelpInfo)

	Helpwindow.ScrollInfoLoad:SetContent(Helpwindow.HelpInfo)

	return newWindow
end

-- Show the toolbox window
function Dta.help_ui.showHelpWindow()
	if Dta.ui.windowHelp == nil then
		Dta.Help.Init()
		Dta.ui.windowHelp = Dta.help_ui.buildHelpWindow()
	else
		Dta.ui.windowHelp:SetVisible(true)
	end
	Dta.ui.windowHelp.content.HelpIndex:SetSelectedIndex(1, false)
	Dta.ui.activeHelp = true
	-- sync mainwindo_help button when closed by other means (e.g. own close button)
	if Dta.ui.windowtest and Dta.ui.windowtest.help then
		Dta.ui.windowtest.help:Toggle(true)
	end
end

-- Hide the toolbox window
function Dta.help_ui.hideHelpWindow()
	Dta.ui.windowHelp:SetVisible(false)
--	Dta.ui.windowHelp = nil
	Dta.ui.activeHelp = false
	-- sync mainwindo_help button when closed by other means (e.g. own close button)
	if Dta.ui.windowtest and Dta.ui.windowtest.help then
		Dta.ui.windowtest.help:Toggle(false)
	end
end

-- Toggle the toolbox window
function Dta.help_ui.toggleHelpWindow(frame, hEvent)
	if Dta.ui.activeHelp then Dta.help_ui.hideHelpWindow()
	else Dta.help_ui.showHelpWindow() end
end

--Called when the window has been closed
function Dta.help_ui.HelpWindowClosed()
	Dta.help_ui.hideHelpWindow()
end
