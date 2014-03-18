Dta_export = {}

Dta_export.savedsets = {}
Dta_export.saveddefaults = {
    ExportImport = {},
}

function Dta_export.main()
  Command.Event.Attach(Event.Addon.SavedVariables.Load.End, Dta_export.load, "Import")
  Command.Event.Attach(Event.Addon.SavedVariables.Save.Begin, Dta_export.save, "Export")
end

function Dta_export.load(hEvent, addon)
  if Dt_Export ~= nil then Dta_export.savedsets = Dt_Export end
end

--Save the settings table
function Dta_export.save(hEvent, addon)
  Dt_Export = Dta_export.savedsets
end

function Dta_export.get(setting)
  if Dta_export.savedsets[setting] ~= nil then
    return Dta_export.savedsets[setting]
  elseif Dta_export.saveddefaults[setting] ~= nil then
    return Dta_export.saveddefaults[setting]
  else
    return nil
  end
end

function Dta_export.set(setting, value)
    Dta_export.savedsets[setting] = value
  return Dta_export.savedsets[setting]
end

Dta_export.main()
