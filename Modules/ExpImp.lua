local Dta = select(2, ...)

Dta.expimp = {}

-------------------------------
-- IMPORT AND EXPORT BUTTON HANDLERS
-------------------------------
function Dta.expimp.ExportSavedCheckboxChanged()
	if Dta.Tools.ExpImp.window.ImportExport.ExportSavedCheckbox:GetChecked() then
		Dta.ui.loadExpImp = "Saved"
		Dta.Tools.ExpImp.window.ImportExport.ExportTbxCheckbox:SetChecked(false)
		Dta.expimp.refreshExportSelect()
	elseif not Dta.Tools.ExpImp.window.ImportExport.ExportTbxCheckbox:GetChecked() then
		Dta.Tools.ExpImp.window.ImportExport.ExportSavedCheckbox:SetChecked(true)
	end
end

function Dta.expimp.ExportTbxCheckboxChanged()
	if Dta.Tools.ExpImp.window.ImportExport.ExportTbxCheckbox:GetChecked() then
		Dta.ui.loadExpImp = "Tbx"
		Dta.Tools.ExpImp.window.ImportExport.ExportSavedCheckbox:SetChecked(false)
		Dta.expimp.refreshExportSelect()
	elseif not Dta.Tools.ExpImp.window.ImportExport.ExportSavedCheckbox:GetChecked() then
		Dta.Tools.ExpImp.window.ImportExport.ExportTbxCheckbox:SetChecked(true)
	end
end

function Dta.expimp.ExportClicked()
	Dta.expimp.ExportLoadAttributes(Dta.Tools.ExpImp.window.ImportExport.ExportLoad:GetSelectedItem())
	Dta.expimp.refreshImportSelect()
end

function Dta.expimp.ImportClicked ()
	local expimpUI = Dta.Tools.ExpImp.window.ImportExport
	local cr = coroutine.wrap(Dta.expimp.ImportLoadAttributes)
	cr(expimpUI.ImportLoad:GetSelectedItem(), expimpUI.NewName:GetText())
	Dta.expimp.refreshImportSelect()
	Dta.expimp.refreshExportSelect()
end

function Dta.expimp.refreshImportSelect()
	Dta.Tools.ExpImp.window.ImportExport.ImportLoad:SetItems(Dta.expimp.loadImport())
end

function Dta.expimp.refreshExportSelect()
	Dta.Tools.ExpImp.window.ImportExport.ExportLoad:SetItems(Dta.expimp.loadExport())
	if Dta.Tools.LoSa.window then
		Dta.Tools.LoSa.window.constructions.nameLoad:SetItems(Dta.losa.loadConstructions())
	end
end

function Dta.expimp.ExportTextClicked()
	local name = Dta.Tools.ExpImp.window.ImportExport.ExportLoad:GetSelectedItem()
	local savedSets = Dta.settings.get_savedsets("SavedSets")
	if not name or name == "" then
		Dta.CPrint(Dta.Locale.Prints.SelectExport)
		return
	end
	local text = "--[[TT " .. Dta.Version .. "]]\nset = {\n"
	for i, details in ipairs(savedSets[name]) do
		local item = { details.name, details.type, details.coordX, details.coordY, details.coordZ,
						details.pitch, details.yaw, details.roll, details.scale }
		if i > 1 then
			text = text .. ",\n"
		end
		text = text .. Utility.Serialize.Inline(item)
	end
	local rp = savedSets[name].referencePoint
	if rp then
		text = text .. ",\nreferencePoint = { " .. rp.x .. ", " .. rp.y .. ", " .. rp.z .. "}"
	end
	text = text .. "\n}"
	Dta.Tools.ExpImp.window.ImportExport.TextView:SetText(text)
	Dta.Tools.ExpImp.window.ImportExport.TextView.hint_active = false
end

function Dta.expimp.ImportTextClicked()
	local expimpUI = Dta.Tools.ExpImp.window.ImportExport
	local cr = coroutine.wrap(Dta.expimp.ImportSerializedSet)
	cr(expimpUI.NewName:GetText(), expimpUI.TextView:GetText())
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
		Dta.CPrint(Dta.Locale.Prints.SelectExport)
		return
	end
	if Dta.ui.loadExpImp == "Saved" then
		if Dta.ExportSaved[name] ~= nil then
			Dta.expimp.ExportGroupItemAttributes(name, Dta.ExportSaved[name])
		else
			Dta.CPrint(string.format(Dta.Locale.Prints.SetNotFound, name))
		end
	elseif Dta.ui.loadExpImp == "Tbx" then
		if Dta.ExportTbx[name] ~= nil then
			Dta.expimp.ExportGroupItemAttributes(name, Dta.ExportTbx[name])
		else
			Dta.CPrint(string.format(Dta.Locale.Prints.SetNotFound, name))
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
		Dta.CPrint(string.format(Dta.Locale.Prints.Exported, name))
		Dta.expimp.refreshExportSelect()
	else
		Dta.CPrint("Something went wrong in set_data") --Debug
	end
end

-------------------------------
-- IMPORT
-------------------------------

function Dta.expimp.ImportLoadAttributes(name, new_name, overwrite)
	if not new_name or new_name == "" then
		new_name = name
	end
	local saved_sets = Dta.settings.get_savedsets("SavedSets") or {}
	if saved_sets[new_name] and not overwrite then
		Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmOverwrite, new_name),
								true, false, coroutine.running())
		local ok = coroutine.yield()
		if ok then
			-- recurse to re-run previous checks
			Dta.expimp.ImportLoadAttributes(name, new_name, true)
		end
		return
	end
	if name and name ~= "" then
		if Dta.ExportImport_Sets[name] ~= nil then
			local new_set = Dta.expimp.ImportGroupItemAttributes(Dta.ExportImport_Sets[name])
			Dta.settings.ConvertOldItems(new_set)
			saved_sets[new_name] = new_set
			Dta.settings.set_savedsets("SavedSets", saved_sets)
			Dta.CPrint(string.format(Dta.Locale.Prints.Imported, name))
			Dta.expimp.removeImportedSet(name)
		else
			Dta.CPrint(string.format(Dta.Locale.Prints.SetNotFound, name))
		end
	else
		Dta.CPrint(Dta.Locale.Prints.SelectImport)
	end
end

function Dta.expimp.ImportGroupItemAttributes(set_data)
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
		return groupDetails
	else
		--print("Something went wrong in set_data") --Debug
	end
end

----------------------------------
-- STRING IMPORT
----------------------------------

function Dta.expimp.ImportSerializedSet(name, data, overwrite)
	local saved_sets = Dta.settings.get_savedsets("SavedSets") or {}
	if not name or name == "" then
		Dta.CPrint(Dta.Locale.Prints.EnterName)
		return
	end
	if saved_sets[name] and not overwrite then
		Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmOverwrite, name),
								true, false, coroutine.running())
		local ok = coroutine.yield()
		if ok then
			-- recurse to re-run previous checks
			Dta.expimp.ImportSerializedSet(name, data, true)
		end
		return
	end
	local ok, deserialized
	-- search for semi-colon delimited item string to detect Toolbox data
	if string.match(data, ";I[%x,]+,,;") then
		deserialized = Dta.expimp.Tbx_DeserializeTable(data)
	else
		ok, deserialized = pcall(Dta.expimp.DeserializeSet, data)
		if not ok then
			Dta.CPrint(deserialized)
			return
		end
	end
	if deserialized and #deserialized > 0 then
		Dta.settings.ConvertOldItems(deserialized)
		saved_sets[name] = deserialized
		Dta.settings.set_savedsets("SavedSets", saved_sets) -- in case it we didn't have any yet
		Dta.CPrint(string.format(Dta.Locale.Prints.Imported, name))
		Dta.expimp.refreshExportSelect()
	end
end

function Dta.expimp.DeserializeSet(data)
	local env_tbl = {}
	local import_func, err = load(data, "tt_set", "t", env_tbl)
	assert(import_func, err)
	import_func()

	if type(env_tbl.set) ~= "table" then
		return nil
	end
	local new_set = {}
	for i, item in ipairs(env_tbl.set) do
		-- integrity check
		assert(type(item) == "table", "'set' is not a table!")
		assert(type(item[1]) == "string" and type(item[2]) == "string", "Value is not a string!")
		for j = 3, 9, 1 do
			assert (type(item[j]) == "number", "Value is not a number!")
		end
		-- restore item details
		new_set[i] = { name = item[1], type = item[2],
					  coordX = item[3], coordY = item[4], coordZ = item[5],
					  pitch = item[6], yaw = item[7], roll = item[8], scale = item[9] }
	end
	local rp = env_tbl.set.referencePoint
	if type(rp) == "table" then
		assert(type(rp[1]) == "number" and type(rp[2]) == "number" and type(rp[3]) == "number")
		new_set.referencePoint = { x = rp[1], y = rp[2], z = rp[3] }
	end
	return new_set
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
