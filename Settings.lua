local addon, Dta = ...
local Lang = Dta.Lang
-- Set English as Default and fallback
function addLangFallback(language)
	setmetatable(Lang[language], { __index = Lang["English"] })
	for k, v in pairs(Lang[language]) do
		if type(v) == "table" then
			setmetatable(v, { __index = Lang["English"][k] })
		end
	end
end

if not Lang[Dta.Language] or Dta.Language == "German" then -- german is w.i.p.
	Dta.Language = "English"
end
addLangFallback("French")
addLangFallback("German")
Dta.Locale = Lang[Dta.Language]

Dta.settings = {}

--------------------------------------
--SAVE AND LOAD SETTINGS
--------------------------------------

Dta.settings.savedsets = {}
Dta.settings.saveddefaults = {
	SavedSets = {},
}
Dta.settings.settings = {}
Dta.settings.defaults = {
	MainbuttonPosX = 10,
	MainbuttonPosY = 100,
	MainwindowPosX = 0,
	MainwindowPosY = 32,
	MovewindowPosX = 0,
	MovewindowPosY = 370,
	ScalewindowPosX = 0,
	ScalewindowPosY = 450,
	CopyPastewindowPosX = 320,
	CopyPastewindowPosY = 410,
	RotatewindowPosX = 0,
	RotatewindowPosY = 410,
	LoSawindowPosX = 320,
	LoSawindowPosY = 450,
	ExpImpwindowPosX = 320,
	ExpImpwindowPosY  = 370,
	HelpwindowPosX = 650,
	HelpwindowPosY  = 335,
	FlyingwindowPosX = 475,
	FlyingwindowPosY = 32,
	AlphabetwindowPosX = 0,
	AlphabetwindowPosY = 530,
	MeasurementswindowPosX = 0,
	MeasurementswindowPosY = 490,
	ReskinwindowPosX = 5,
	ReskinwindowPosY = 400,
	SelectionwindowPosX = 320,
	SelectionwindowPosY = 100,
	Language = "Auto",
	WindowStyle = "default",
	ConsoleOutput = { [1] = true },
	RestoreTools = false
}

Dta.settings.revisions = {
	[1] = "DT v1.9.10",
	[2] = "v1.2.7"
}

function Dta.settings.main()
	Command.Event.Attach(Event.Addon.SavedVariables.Load.End, Dta.settings.loadEnd, "Loaded settings")
	Command.Event.Attach(Event.Addon.SavedVariables.Save.Begin, Dta.settings.saveBegin, "Save settings")
end

-- Load the settings into the settings table
function Dta.settings.loadEnd(hEvent, addonID)
	if addonID ~= addon.toc.Identifier then return end

	if TinkerT_Settings ~= nil then Dta.settings.settings = TinkerT_Settings end
	if TinkerT_Sets ~= nil then Dta.settings.savedsets = TinkerT_Sets end

	local language = Dta.settings.get("Language")
	if language ~= "Auto" then
		if not Lang[language] then
			Dta.CPrint("Language '" .. language .. "' is not available.")
		else
			Dta.Language = language
			Dta.Locale = Lang[Dta.Language]
		end
	end
	-- correct unintended cross-reference of saved sets in settings
	if Dta.settings.settings["SavedSets"] then
		Dta.settings.settings["SavedSets"] = nil
	end
	-- check if outdated item type IDs need to be replaced
	local revision = Dta.settings.get("Revision")
	local savedSets = Dta.settings.savedsets and Dta.settings.savedsets.SavedSets
	if savedSets and (not revision or revision < Dta.SettingsRevision) then
		local replaced = 0
		for name, set in pairs(savedSets) do
			replaced = replaced + Dta.settings.ConvertOldItems(set)
		end
		print(string.format("Converted %i outdated items", replaced))
	end
end

--Save the settings table
function Dta.settings.saveBegin(hEvent, addonID)
	if addonID ~= addon.toc.Identifier then return end
	-- set a revision to track changes in setting data layout
	Dta.settings.set("Revision", Dta.SettingsRevision)
	TinkerT_Settings = Dta.settings.settings
	TinkerT_Sets = Dta.settings.savedsets
end

function Dta.settings.ConvertOldItems(set)
	local outdated_IDs = Dta.Defaults.ItemDB_outdated
	local replaced = 0
	for idx, item in pairs(set) do
		if outdated_IDs[item.type] then
			item.type = outdated_IDs[item.type]
			replaced = replaced + 1
		end
	end
	return replaced
end

--------------------------------------
--GET AND SET SETTINGS
--------------------------------------

function Dta.settings.get(setting)
	if Dta.settings.settings[setting] ~= nil then
		return Dta.settings.settings[setting]
	elseif Dta.settings.defaults[setting] ~= nil then
		return Dta.settings.defaults[setting]
	else
		return nil
	end
end

function Dta.settings.set(setting, value)
	if type(value) ~= "table" and Dta.settings.defaults[setting] == value then
		Dta.settings.settings[setting] = nil
	else
		Dta.settings.settings[setting] = value
	end

	return Dta.settings.settings[setting]
end

--------------------------------------
--GET AND SET SETS
--------------------------------------

function Dta.settings.get_savedsets(setting)
	if Dta.settings.savedsets[setting] ~= nil then
		return Dta.settings.savedsets[setting]
	elseif Dta.settings.saveddefaults[setting] ~= nil then
		return Dta.settings.saveddefaults[setting]
	else
		return nil
	end
end

function Dta.settings.get_defaults(setting)
	return Dta.Defaults[setting]
end

function Dta.settings.set_savedsets(setting, value)
	if Dta.Defaults[setting] == value then
		Dta.settings.savedsets[setting] = nil
	else
		Dta.settings.savedsets[setting] = value
	end

	return Dta.settings.savedsets[setting]
end

Dta.settings.main()

--------------------------------------
-- Import Dimension Tools settings
--------------------------------------

function Dta.settings.import_dimtools()
	if not Dta.settings.savedsets.SavedSets then
		Dta.settings.savedsets.SavedSets = {}
	end
	local tinker_sets = Dta.settings.savedsets.SavedSets

	if type(Dta_Sets) == "table" and type(Dta_Sets.SavedSets) == "table" then
		for set_name, set_data in pairs(Dta_Sets.SavedSets) do
			if tinker_sets[set_name] then
				Dta.CPrint(string.format("skipped: %s", set_name))
			else
				tinker_sets[set_name] = Dta.copyTable(set_data, true)
				Dta.CPrint(string.format("copied: %s", set_name))
			end
		end
	end
	-- refresh load/save list if window exists
	if Dta.ui.windowLoSa then
		Dta.losa.refreshLoadSelect()
	end
end
