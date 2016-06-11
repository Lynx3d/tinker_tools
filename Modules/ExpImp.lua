local Dta = select(2, ...)
local Lang = Dta.Lang

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

function Dta.expimp.ImportTextClicked()
	local expimpUI = Dta.ui.windowExpImp.ImportExport
	Dta.expimp.ImportTbxSerialized(expimpUI.NewName:GetText(), expimpUI.TextView:GetText())
end

-------------------------------
-- LOAD IMPORT AND EXPORT DROPDOWN
-------------------------------

function Dta.expimp.loadExport()
	Dta.ExportSaved = Dta.settings.get_savedsets("SavedSets")--or {}
	Dta.ExportTbx = tbx_import.get("savedConstructions")
	local items = {}
	if Dta.ui.loadExpImp == "Saved" and Dta.ExportSaved then
		for name, _ in pairs(Dta.ExportSaved) do
			table.insert(items, name)
		end
	elseif Dta.ui.loadExpImp == "Tbx" and Dta.ExportTbx then
		for name, _ in pairs(Dta.ExportTbx) do
			table.insert(items, name)
		end
	end
	return items
end

function Dta.expimp.loadImport()
	Dta.ExportImport_Sets = Dta_export.get("ExportImport") --or {}
	local items = {}
	if Dta.ExportImport_Sets then
		for name, _ in pairs(Dta.ExportImport_Sets) do
		table.insert(items, name)
		end
	end
	return items
end

-------------------------------
-- EXPORT
-------------------------------
function Dta.expimp.ExportLoadAttributes(name)
	if not name or name == "" then
		Dta.CPrint(Lang[Dta.Language].Prints.SelectExport)
		return
	end
	if Dta.ui.loadExpImp == "Saved" then
		if Dta.ExportSaved[name] ~= nil then
			Dta.expimp.ExportGroupItemAttributes(name, Dta.ExportSaved[name])
		else
			Dta.CPrint(string.format(Lang[Dta.Language].Prints.SetNotFound, name))
		end
	elseif Dta.ui.loadExpImp == "Tbx" then
		if Dta.ExportTbx[name] ~= nil then
			Dta.expimp.ExportGroupItemAttributes(name, Dta.ExportTbx[name])
		else
			Dta.CPrint(string.format(Lang[Dta.Language].Prints.SetNotFound, name))
		end
	end
end


function Dta.expimp.ExportGroupItemAttributes(name, set_data)
	if #set_data > 0 then
		local groupDetails = {}
		for _, item in pairs(set_data) do
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
		Dta.CPrint(string.format(Lang[Dta.Language].Prints.Exported, name))
		Dta.expimp.refreshExportSelect()
	else
		Dta.CPrint("Something went wrong in set_data") --Debug
	end
end

-------------------------------
-- IMPORT
-------------------------------

function Dta.expimp.ImportLoadAttributes(name)
	if name ~= nil and name ~= "" then
		if Dta.ExportImport_Sets[name] ~= nil then
			Dta.expimp.ImportGroupItemAttributes(name, Dta.ExportImport_Sets[name])
		else
			Dta.CPrint(string.format(Lang[Dta.Language].Prints.SetNotFound, name))
		end
	else
		Dta.CPrint(Lang[Dta.Language].Prints.SelectImport)
	end
end

function Dta.expimp.ImportGroupItemAttributes(name, set_data)
	if name ~= nil and name ~= "" then
		if #set_data > 0 then
			local groupDetails = {}
			for _, item in pairs(set_data) do
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
			local constructions = Dta.settings.get_savedsets("SavedSets") or {}
			constructions[name] = groupDetails
			Dta.settings.set_savedsets("SavedSets", constructions)
			Dta.CPrint(string.format(Lang[Dta.Language].Prints.Imported, name))
			Dta.expimp.removeImportedSet(name)
		else
			--print("Something went wrong in set_data") --Debug
		end
	else
		--print("Something went wrong sending from Dta.expimp.ExportLoadAttributes") --Debug
	end
end

----------------------------------
--TOOLBOX STRING IMPORT
----------------------------------

function Dta.expimp.ImportTbxSerialized(name, data)
	local saved_sets = Dta.settings.get_savedsets("SavedSets") or {}
	if not name or name == "" then
		Dta.CPrint(Lang[Dta.Language].Prints.EnterName)
		return
	end
	if saved_sets[name] then
		Dta.CPrint(string.format(Lang[Dta.Language].Prints.SetExists, name))
		return
	end
	local deserialized = Dta.expimp.Tbx_DeserializeTable(data)
	if deserialized ~= nil and #deserialized > 0 then
		saved_sets[name] = deserialized
		Dta.settings.set_savedsets("SavedSets", saved_sets) -- in case it we didn't have any yet
		Dta.CPrint(string.format(Lang[Dta.Language].Prints.Imported, name))
		Dta.expimp.refreshExportSelect()
	end
end

function Dta.expimp.Tbx_DeserializeTable(data)
	local t = {}
	for item, _ in string.gsplit(data, "|") do
		local itemTable = {}
		item = string.split(item, ";")
		if #item < 9 then return nil end --Check we have 9 attributes
		if not tonumber(item[3]) or --Check x, y, z, yaw, pitch, roll, scale are numbers
		   not tonumber(item[4]) or
		   not tonumber(item[5]) or
		   not tonumber(item[6]) or
		   not tonumber(item[7]) or
		   not tonumber(item[8]) or
		   not tonumber(item[9]) then
		  return nil
		end
		itemTable.name = item[1]
		itemTable.type = item[2]
		itemTable.coordX = tonumber(item[3])
		itemTable.coordY = tonumber(item[4])
		itemTable.coordZ = tonumber(item[5])
		itemTable.yaw = tonumber(item[6])
		itemTable.pitch = tonumber(item[7])
		itemTable.roll = tonumber(item[8])
		itemTable.scale = tonumber(item[9])
		table.insert(t, itemTable)
	end
	return t
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
