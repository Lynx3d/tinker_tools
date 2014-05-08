Dta.expimp = {}

-------------------------------
-- IMPORT AND EXPORT BUTTON HANDLERS
-------------------------------
function Dta.expimp.ExportSavedCheckboxChanged()
    if Dta.ui.windowExpImp.ImportExport.ExportSavedCheckbox:GetChecked() then
        Dta.ui.loadExpImp = "Saved"
        Dta.ui.windowExpImp.ImportExport.ExportTbxCheckbox:SetChecked(false)
        Dta.expimp.refreshExportSelect()
    elseif not Dta.ui.windowExpImp.ImportExport.ExportTbxCheckbox:GetChecked() then
        Dta.ui.windowExpImp.ImportExport.ExportSavedCheckbox:SetChecked(true)
    end
end

function Dta.expimp.ExportTbxCheckboxChanged()
    if Dta.ui.windowExpImp.ImportExport.ExportTbxCheckbox:GetChecked() then
        Dta.ui.loadExpImp = "Tbx"
        Dta.ui.windowExpImp.ImportExport.ExportSavedCheckbox:SetChecked(false)
        Dta.expimp.refreshExportSelect()
    elseif not Dta.ui.windowExpImp.ImportExport.ExportSavedCheckbox:GetChecked() then
        Dta.ui.windowExpImp.ImportExport.ExportTbxCheckbox:SetChecked(true)
    end
end

function Dta.expimp.ImportExport_ExportClicked ()
    Dta.expimp.ExportLoadAttributes(Dta.ui.windowExpImp.ImportExport.ExportLoad:GetSelectedItem())
    Dta.expimp.refreshImportSelect()
end

function Dta.expimp.ImportExport_ImportClicked ()
    Dta.expimp.ImportLoadAttributes(Dta.ui.windowExpImp.ImportExport.ImportLoad:GetSelectedItem())
    Dta.expimp.refreshImportSelect()
    Dta.expimp.refreshExportSelect()
end

function Dta.expimp.refreshImportSelect()
  Dta.ui.windowExpImp.ImportExport.ImportLoad:SetItems(Dta.expimp.loadImport())
  Dta.ui.windowExpImp.ImportExport.ImportLoad:ResizeToFit()
  Dta.ui.windowExpImp.ImportExport.ImportLoad:SetWidth(245)
end

function Dta.expimp.refreshExportSelect()
  Dta.ui.windowExpImp.ImportExport.ExportLoad:SetItems(Dta.expimp.loadExport())
  Dta.ui.windowExpImp.ImportExport.ExportLoad:ResizeToFit()
  Dta.ui.windowExpImp.ImportExport.ExportLoad:SetWidth(245)
  if Dta.ui.windowLoSa then
      Dta.ui.windowLoSa.constructions.nameLoad:SetItems(Dta.losa.loadConstructions())
      Dta.ui.windowLoSa.constructions.nameLoad:ResizeToFit()
      Dta.ui.windowLoSa.constructions.nameLoad:SetWidth(245)
  end
end

-------------------------------
-- LOAD IMPORT AND EXPORT DROPDOWN
-------------------------------

function Dta.expimp.loadExport()
    Dta.ExportSaved = Dta.settings.get_savedsets("SavedSets")--or {}
    Dta.ExportTbx = tbx_import.get("savedConstructions")
    if Dta.ui.loadExpImp == "Saved" then
        if Dta.ExportSaved == nil or Dta.ExportSaved == {} then
            return {}
        else
            local items = {}
            for name, _ in pairs(Dta.ExportSaved) do
                table.insert(items, name)
            end
            return items
        end
    elseif Dta.ui.loadExpImp == "Tbx" then
        if Dta.ExportTbx == nil or Dta.ExportTbx == {} then
            return {}
        else
            local items = {}
            for name, _ in pairs(Dta.ExportTbx) do
                table.insert(items, name)
            end
            return items
        end
    end
end

function Dta.expimp.loadImport()
    Dta.ExportImport_Sets = Dta_export.get("ExportImport") --or {}
    if Dta.ExportImport_Sets == nil or Dta.ExportImport_Sets == {} then
        return {}
    else
        local items = {}
        for name, _ in pairs(Dta.ExportImport_Sets) do
        table.insert(items, name)
        end
        return items
    end
end

-------------------------------
-- EXPORT
-------------------------------
function Dta.expimp.ExportLoadAttributes(name)
    if Dta.ui.loadExpImp == "Saved" then
        if name ~= nil and name ~= "" then
            if Dta.ExportSaved[name] ~= nil then
                Dta.ExportSet = {}
                Dta.ExportSet = Dta.ExportSaved[name]
                Dta.expimp.ExportGroupItemAttributes(name)
            else
                print(string.format(Lang[Dta.Language].Prints.SetNotFound, name))
            end
        else
            print(Lang[Dta.Language].Prints.SelectExport)
        end
    elseif Dta.ui.loadExpImp == "Tbx" then
        if name ~= nil and name ~= "" then
            if Dta.ExportTbx[name] ~= nil then
                Dta.ExportSet = {}
                Dta.ExportSet = Dta.ExportTbx[name]
                Dta.expimp.ExportGroupItemAttributes(name)
            else
                print(string.format(Lang[Dta.Language].Prints.SetNotFound, name))
            end
        else
            print(Lang[Dta.Language].Prints.SelectExport)
        end
    end
end


function Dta.expimp.ExportGroupItemAttributes(name)
    if name ~= nil and name ~= "" then
        if #Dta.ExportSet > 0 then
            local groupDetails = {}
            for _, item in pairs(Dta.ExportSet) do
                table.insert(groupDetails, {name = item.name,
                                            type = item.type,
                                            coordX = item.coordX,
                                            coordY = item.coordY,
                                            coordZ = item.coordZ,
                                            yaw = item.yaw,
                                            pitch = item.pitch,
                                            roll = item.roll,
                                            scale = item.scale})
            end
            Dta.ExportImport_Sets[name] = groupDetails
            Dta_export.set("ExportImport", Dta.ExportImport_Sets)
            print(string.format(Lang[Dta.Language].Prints.Exported, name))
            Dta.expimp.refreshExportSelect()
        else
            print("Something went wrong saving to Dta.ExportSet") --Debug
        end
    else
        print("Something went wrong sending from Dta.expimp.ExportLoadAttributes") --Debug
    end
end

-------------------------------
-- IMPORT
-------------------------------

function Dta.expimp.ImportLoadAttributes(name)
    if name ~= nil and name ~= "" then
        if Dta.ExportImport_Sets[name] ~= nil then
            Dta.ImportSet = {}
            Dta.ImportSet = Dta.ExportImport_Sets[name]
            Dta.expimp.ImportGroupItemAttributes(name)
        else
            print(string.format(Lang[Dta.Language].Prints.SetNotFound, name))
        end
    else
        print(Lang[Dta.Language].Prints.SelectImport)
    end
end

function Dta.expimp.ImportGroupItemAttributes(name)
    if name ~= nil and name ~= "" then
        if #Dta.ImportSet > 0 then
            local groupDetails = {}
            for _, item in pairs(Dta.ImportSet) do
                table.insert(groupDetails, {name = item.name,
                                            type = item.type,
                                            coordX = item.coordX,
                                            coordY = item.coordY,
                                            coordZ = item.coordZ,
                                            yaw = item.yaw,
                                            pitch = item.pitch,
                                            roll = item.roll,
                                            scale = item.scale})
            end
            Dta.constructions[name] = groupDetails
            Dta.settings.set_savedsets("SavedSets", Dta.constructions)
            print(string.format(Lang[Dta.Language].Prints.Imported, name))
            Dta.expimp.removeImportedSet(name)
        else
            --print("Something went wrong saving to Dta.ExportSet") --Debug
        end
    else
        --print("Something went wrong sending from Dta.expimp.ExportLoadAttributes") --Debug
    end
end

----------------------------------
--REMOVE IMPORTED SET
----------------------------------

function Dta.expimp.removeImportedSet(name)
    if name ~= nil and name ~= "" then
        if Dta.ExportImport_Sets[name] ~= nil then
            Dta.ExportImport_Sets[name] = nil
            Dta_export.set("ExportImport", Dta.ExportImport_Sets)
            Dta.expimp.refreshImportSelect()
        else
            --print("Something went wrong getting name from Dta.ExportImport_Sets") --Debug
        end
    else
        --print("Something went wrong sending from Dta.expimp.ImportGroupItemAttributes") --Debug
    end
end
