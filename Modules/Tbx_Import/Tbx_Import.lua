
tbx_import = {}

tbx_import.Imported = {}
tbx_import.Default = {
	savedConstructions = {
	}
}


function tbx_import.main()
-- Load/save settings event listeners
  Command.Event.Attach(Event.Addon.SavedVariables.Load.End, tbx_import.load, "Import")
  Command.Event.Attach(Event.Addon.SavedVariables.Save.Begin, tbx_import.save, "Export")
end

-- Load the settings into the settings table
function tbx_import.load(hEvent, addon)
  if tbx_Settings ~= nil then tbx_import.Imported = tbx_Settings end
end

function tbx_import.save(addon)
  tbx_Settings = tbx_import.Imported
end

function tbx_import.get(setting)
  if tbx_import.Imported[setting] ~= nil then
    return tbx_import.Imported[setting]
  elseif tbx_import.Default[setting] ~= nil then
    return tbx_import.Default[setting]
  else
    return nil
  end
end

function tbx_import.set(setting, value)
    tbx_import.Imported[setting] = value
  return tbx_import.Imported[setting]
end

tbx_import.main()
