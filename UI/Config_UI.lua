local Dta = select(2, ...)

Dta.config_ui = {}

local langMenu = {
	"Auto",
	"Deutsch (in Arbeit)",
	"English",
	"Français "
}

local langID = {
	"Auto",
	"German",
	"English",
	"French"
}

local skinMenu = {
	"default",
	"classic"
}

local ConfigWindowSettings = {
	WIDTH = 325,
	HEIGHT = 300,
	CLOSABLE = true,
	MOVABLE = true,
}

function Dta.config_ui.buildConfigWindow()
	local x = (UIParent:GetWidth() - ConfigWindowSettings.WIDTH)/2
	local y = (UIParent:GetHeight() - ConfigWindowSettings.HEIGHT)/2
	local newWindow = Dta.ui.Window.Create("ConfigWindow",
							Dta.ui.context,
							Dta.Locale.Titles.Settings,
							ConfigWindowSettings.WIDTH,
							ConfigWindowSettings.HEIGHT,
							x,
							y,
							ConfigWindowSettings.CLOSABLE,
							ConfigWindowSettings.MOVABLE,
							nil, -- Dta.config_ui.ConfigWindowClosed,
							nil -- Dta.config_ui.ConfigWindowMoved
							)
	local Configwindow = newWindow.content

	Configwindow.LangLabel = Dta.ui.createText("ConfigLangLabel", Configwindow, 20, 25, "Language/Sprache/Langue", 14)
	Configwindow.Lang = UI.CreateFrame("SimpleSelect", "Language", Configwindow)
	Configwindow.Lang:SetPoint("TOPLEFT", Configwindow, "TOPLEFT", 190, 25)
	Configwindow.Lang:SetItems(langMenu)
	Configwindow.Lang:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	Configwindow.Lang:SetWidth(110)
	-- Skin
	Configwindow.SkinLabel = Dta.ui.createText("ConfigLangLabel", Configwindow, 20, 50, Dta.Locale.Text.WindowStyle, 14)
	Configwindow.Skin = UI.CreateFrame("SimpleSelect", "WindowStyle", Configwindow)
	Configwindow.Skin:SetPoint("TOPLEFT", Configwindow, "TOPLEFT", 190, 50)
	Configwindow.Skin:SetItems(Dta.Locale.Menus.WindowStyle)
	Configwindow.Skin:SetBackgroundColor(0.07, 0.05, 0.01, 0.85)
	Configwindow.Skin:SetWidth(110)
	-- Console Options:
	Configwindow.ConsoleLabel = Dta.ui.createText("ConsoleLabel", Configwindow, 20, 75, Dta.Locale.Text.ConsoleMessages, 14)
	Configwindow.Console = {}
	Configwindow.Console[1] = Dta.ui.createCheckbox("Console_1", Configwindow, 50, 100, "#1", true, nil, nil)
	Configwindow.Console[2] = Dta.ui.createCheckbox("Console_2", Configwindow, 50, 125, "#2", true, nil, nil)
	Configwindow.Console[3] = Dta.ui.createCheckbox("Console_3", Configwindow, 50, 150, "#3", true, nil, nil)
	Configwindow.Console[4] = Dta.ui.createCheckbox("Console_4", Configwindow, 50, 175, "#4", true, nil, nil)
	Configwindow.Console[5] = Dta.ui.createCheckbox("Console_5", Configwindow, 170, 100, "#5", true, nil, nil)
	Configwindow.Console[6] = Dta.ui.createCheckbox("Console_6", Configwindow, 170, 125, "#6", true, nil, nil)
	Configwindow.Console[7] = Dta.ui.createCheckbox("Console_7", Configwindow, 170, 150, "#7", true, nil, nil)

	Configwindow.Accept = Dta.ui.createButton("Config_Accept", Configwindow, 30, 260, nil, nil, Dta.Locale.Buttons.OK, nil, Dta.config_ui.applyButtonClicked)

	return newWindow
end

function Dta.config_ui.loadConfig()
	local Configwindow = Dta.ui.windowConfig.content
	local language = Dta.settings.get("Language")
	for idx, val in pairs(langID) do
		if val == language then
			Configwindow.Lang:SetSelectedIndex(idx, true)
			break
		end
	end
	local skin = Dta.settings.get("WindowStyle")
	if skin == "classic" then Configwindow.Skin:SetSelectedIndex(2, true)
	else Configwindow.Skin:SetSelectedIndex(1, true)
	end
	local consoles = Inspect.Console.Detail(Inspect.Console.List())
	local console_settings = Dta.settings.get("ConsoleOutput")
	for i = 1, 7, 1 do
		local console_id = string.format("v00000000%08x", i-1)
		local consoleName = consoles[console_id] and consoles[console_id].name or "Console "..tostring(i)
		Configwindow.Console[i].textFrame:SetText(consoleName)
		Configwindow.Console[i]:SetChecked(console_settings[i] == true)
	end
end

function Dta.config_ui.applyButtonClicked()
	local Configwindow = Dta.ui.windowConfig.content
	local langIndex = Configwindow.Lang:GetSelectedIndex()
	Dta.settings.set("Language", langID[langIndex])
	local skinIndex = Configwindow.Skin:GetSelectedIndex()
	Dta.settings.set("WindowStyle", skinMenu[skinIndex])
	local consoles = {}
	for i = 1, 7, 1 do
		if Configwindow.Console[i]:GetChecked() then
			consoles[i] = true
		end
	end
	local consoles = Dta.settings.set("ConsoleOutput", consoles)
	Dta.ui.windowConfig:SetVisible(false)
end

-- Show the config window
function Dta.config_ui.showConfigWindow()
	if Dta.ui.windowConfig == nil then
		Dta.ui.windowConfig = Dta.config_ui.buildConfigWindow()
	else
		Dta.ui.windowConfig:SetVisible(true)
	end
	-- Dta.ui.activeConfig = true
	Dta.config_ui.loadConfig()
end
