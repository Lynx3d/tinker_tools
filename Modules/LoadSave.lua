local Dta = select(2, ...)

Dta.losa = {}

--------------------------------------
--LOAD / SAVE BUTTON HANDLERS
--------------------------------------

function Dta.losa.constructionLoadDeafaultSetsChanged()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	if losa_ui.loadDeafaultSets:GetChecked() then
		Dta.ui.loadLoSa = "Default"
		losa_ui.loadSavedSets:SetChecked(false)
		losa_ui.loadTbxSets:SetChecked(false)
		losa_ui.remove:SetVisible(false)
		losa_ui.loadAtOriginalLoc:SetVisible(false)
		losa_ui.loadAtOriginalLoc:SetChecked(false)
		Dta.losa.constructionLoadNewItemsChanged()
		Dta.losa.refreshLoadSelect()
	elseif not losa_ui.loadSavedSets:GetChecked() and not losa_ui.loadTbxSets:GetChecked()then
		losa_ui.loadDeafaultSets:SetChecked(true)
	end
end

function Dta.losa.constructionLoadSavedSetsChanged()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	if losa_ui.loadSavedSets:GetChecked() then
		Dta.ui.loadLoSa = "Saved"
		losa_ui.loadDeafaultSets:SetChecked(false)
		losa_ui.loadTbxSets:SetChecked(false)
		losa_ui.remove:SetVisible(true)
		losa_ui.loadAtOriginalLoc:SetVisible(true)
		losa_ui.loadAtOriginalLoc:SetChecked(false)
		Dta.losa.constructionLoadNewItemsChanged()
		Dta.losa.refreshLoadSelect()
	elseif not losa_ui.loadDeafaultSets:GetChecked() and not losa_ui.loadTbxSets:GetChecked()then
		losa_ui.loadSavedSets:SetChecked(true)
	end
end

function Dta.losa.constructionLoadTbxSetsChanged()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	if losa_ui.loadTbxSets:GetChecked() then
		Dta.ui.loadLoSa = "Tbx"
		losa_ui.loadSavedSets:SetChecked(false)
		losa_ui.loadDeafaultSets:SetChecked(false)
		losa_ui.remove:SetVisible(false)
		losa_ui.loadAtOriginalLoc:SetVisible(true)
		losa_ui.loadAtOriginalLoc:SetChecked(false)
		Dta.losa.constructionLoadNewItemsChanged()
		Dta.losa.refreshLoadSelect()
	elseif not losa_ui.loadSavedSets:GetChecked() and not losa_ui.loadDeafaultSets:GetChecked()then
		losa_ui.loadTbxSets:SetChecked(true)
	end
end

function Dta.losa.constructionLoadNewItemsChanged()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	if losa_ui.LoadNewItems:GetChecked() and losa_ui.loadSavedSets:GetChecked() then
		losa_ui.LoadMultipleSets:SetVisible(true)
	elseif losa_ui.LoadNewItems:GetChecked() and losa_ui.loadTbxSets:GetChecked() then
		losa_ui.LoadMultipleSets:SetVisible(true)
	else
		losa_ui.LoadMultipleSets:SetVisible(false)
		losa_ui.LoadMultipleSets:SetChecked(false)
	end
end

function Dta.losa.constructionLoadMultipleSetsChanged()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	if losa_ui.LoadMultipleSets:GetChecked() then
		losa_ui.NrCopiesLabel:SetVisible(true)
		losa_ui.OffsetLabel:SetVisible(true)
		losa_ui.xLabel:SetVisible(true)
		losa_ui.yLabel:SetVisible(true)
		losa_ui.zLabel:SetVisible(true)
		losa_ui.NrCopies:SetVisible(true)
		losa_ui.x:SetVisible(true)
		losa_ui.y:SetVisible(true)
		losa_ui.z:SetVisible(true)
	elseif not losa_ui.LoadMultipleSets:GetChecked() then
		losa_ui.NrCopiesLabel:SetVisible(false)
		losa_ui.OffsetLabel:SetVisible(false)
		losa_ui.xLabel:SetVisible(false)
		losa_ui.yLabel:SetVisible(false)
		losa_ui.zLabel:SetVisible(false)
		losa_ui.NrCopies:SetVisible(false)
		losa_ui.NrCopies:SetText("")
		losa_ui.x:SetVisible(false)
		losa_ui.x:SetText("")
		losa_ui.y:SetVisible(false)
		losa_ui.y:SetText("")
		losa_ui.z:SetVisible(false)
		losa_ui.z:SetText("")
	end
end

function Dta.losa.constructionSaveClicked()
	local cr = coroutine.wrap(Dta.losa.saveGroupItemAttributes)
	cr(Dta.Tools.LoSa.window.constructions.name:GetText())
	Dta.losa.refreshLoadSelect()
end

function Dta.losa.constructionLoadClicked()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	local cr = coroutine.wrap(Dta.losa.loadItemSet)
	cr(losa_ui.nameLoad:GetSelectedItem(), losa_ui.loadAtOriginalLoc:GetChecked(), losa_ui.LoadNewItems:GetChecked())
end

function Dta.losa.constructionRemoveClicked()
	Dta.losa.removeGroupItem(Dta.Tools.LoSa.window.constructions.nameLoad:GetSelectedItem())
end

function Dta.losa.refreshLoadSelect()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	losa_ui.nameLoad:SetItems(Dta.losa.loadConstructions())
	losa_ui.nameLoad:ResizeToFit()
	losa_ui.nameLoad:SetWidth(245)
	if Dta.Tools.ExpImp.window then
		Dta.Tools.ExpImp.window.ImportExport.ExportLoad:SetItems(Dta.expimp.loadExport())
		Dta.Tools.ExpImp.window.ImportExport.ExportLoad:ResizeToFit()
		Dta.Tools.ExpImp.window.ImportExport.ExportLoad:SetWidth(245)
	end
end

function Dta.losa.constructionPrintMaterials()
	Dta.losa.printShoppingList(Dta.Tools.LoSa.window.constructions.nameLoad:GetSelectedItem())
end

function Dta.losa.constructionToClipboard()
	local cr = coroutine.wrap(Dta.losa.copyToClipboard)
	cr(Dta.Tools.LoSa.window.constructions.nameLoad:GetSelectedItem())
end

function Dta.losa.constructionSearchKeyUp(frame, hEvent, key)
	if key == "Return" then
		Dta.Tools.LoSa.window.constructions.nameLoad:SetItems(Dta.losa.filterConstructions())
	end
end

-- sort alphabetically rather than by ASCII value
-- if strings only differ in case, use default < operator
local function sortAlphabet(str1, str2)
	local s1, s2 = string.lower(str1), string.lower(str2)
	if s1 < s2 then
		return true
	elseif s1 > s2 then
		return false
	else
		return str1 < str2
	end
end

function Dta.losa.getConstructionSet()
	if Dta.ui.loadLoSa == "Default" then
		return Dta.constructionsdefaults, false
	elseif Dta.ui.loadLoSa == "Saved" then
		return Dta.settings.get_savedsets("SavedSets"), true
	elseif Dta.ui.loadLoSa == "Tbx" then
		return Dta.constructionstbx, true
	end
end

function Dta.losa.loadConstructions()
	local constructs = Dta.losa.getConstructionSet()

	-- TODO: cache for all 3 sources, and only redo on demand
	Dta.losa.sortedConstructions = {}
	local itemsets = Dta.losa.sortedConstructions

	if not constructs then
		return itemsets
	end

	for name, _ in pairs(constructs) do
		table.insert(itemsets, name)
	end
	table.sort(itemsets, sortAlphabet)
	return itemsets
end

function Dta.losa.filterConstructions()
	local searchString = string.lower(Dta.Tools.LoSa.window.constructions.search:GetText())
	if searchString == "" then
		return Dta.losa.sortedConstructions
	end
	local filteredSets = {}

	for _, name in pairs(Dta.losa.sortedConstructions) do
		if string.find(string.lower(name), searchString, 1, true) then
			table.insert(filteredSets, name)
		end
	end
	return filteredSets
end

function Dta.losa.confirmPlayerDistance(player, cp)
	local vec = { cp.x - player.coordX, cp.y - player.coordY, cp.z - player.coordZ }
	local distance = math.sqrt(vec[1] * vec[1] + vec[2] * vec[2] + vec[3] * vec[3])
	if distance > 200 then
		Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmUsePosition, distance), true, false, coroutine.running())
		return coroutine.yield()
	end
	return true
end

--------------------------------------
-- COPY SET TO CLIPBOARD
--------------------------------------

function Dta.losa.copyToClipboard(name)
	local losa_ui = Dta.Tools.LoSa.window.constructions
	local constructionSet, atOriginalLoc = Dta.losa.getConstructionSet()
	atOriginalLoc = atOriginalLoc and losa_ui.loadAtOriginalLoc:GetChecked()

	if constructionSet and constructionSet[name] ~= nil then
		local cp = Dta.items.getCentralPoint(constructionSet[name])
		local player = Inspect.Unit.Detail("player")
		-- check if set location is reasonably near
		if atOriginalLoc and not Dta.losa.confirmPlayerDistance(player, cp) then
			return
		end
		-- TODO: check if clipboard empty
		Dta.clipboard.items = Dta.copyTable(constructionSet[name], true)
		Dta.clipboard.itemCount = #Dta.clipboard.items
		if not atOriginalLoc then
			local offset_x = player.coordX - cp.x + 15
			local offset_y = player.coordY - cp.minValuaY + 0.05
			local offset_z = player.coordZ - cp.z
			for _, item in pairs(Dta.clipboard.items) do
				item.coordX = item.coordX + offset_x
				item.coordY = item.coordY + offset_y
				item.coordZ = item.coordZ + offset_z
			end
		end
		Dta.CPrint(string.format(Dta.Locale.Prints.CopiedClipboard, name))
	end
end

--------------------------------------
--SAVESET
--------------------------------------

function Dta.losa.saveGroupItemAttributes(name, overwrite)
	if Dta.selectionCount < 1 then
		Dta.CPrint(Dta.Locale.Prints.MinOneItem)
		return
	end
	if name and name ~= "" then
		local constructions = Dta.settings.get_savedsets("SavedSets") or {}
		if constructions[name] and not overwrite then
			Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmOverwrite, name),
									true, false, coroutine.running())
			local ok = coroutine.yield()
			if ok then
				-- recurse to re-run previous checks
				Dta.losa.saveGroupItemAttributes(name, true)
			end
			return
		end

		local groupDetails = {}
		for _, item in pairs(Dta.selectedItems) do
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
		constructions[name] = groupDetails
		Dta.settings.set_savedsets("SavedSets", constructions)
		Dta.CPrint(string.format(Dta.Locale.Prints.Saved, name))
	else
		Dta.CPrint(Dta.Locale.Prints.EnterName)
	end
end

---------------------------------
--SHOPPINGLIST
---------------------------------

function Dta.losa.printShoppingList(name)
	local constructionSet = Dta.losa.getConstructionSet()

	if name ~= nil and name ~= "" then
		if constructionSet and constructionSet[name] ~= nil then
			local list = Dta.losa.getGroupShoppingList(constructionSet[name])
			if list ~= nil and Dta.losa.tableLength(list) > 0 then
				Dta.CPrint(string.format(Dta.Locale.Prints.LoadNeededItems, name))
				for id, details in pairs(list) do
					Dta.CPrint(string.format("%s: %d", details.name, details.amount))
				end
			else
				Dta.CPrint(Dta.Locale.Prints.WordCouldNotPrint)
			end
		else
			Dta.CPrint(string.format(Dta.Locale.Prints.SetNotFound, name))
		end
	else
		Dta.CPrint(Dta.Locale.Prints.LoadPrintMats)
	end
end

function Dta.losa.tableLength(t)
	if t ~= nil then
		local count = 0
		for _ in pairs(t) do count = count + 1 end
		return count
	else
		return 0
	end
end

function Dta.losa.getGroupShoppingList(itemlist)
	if #itemlist > 0 then
		local shoppingList = {}
		for k, details in pairs(itemlist) do
			if shoppingList[details.type] == nil then
				shoppingList[details.type] = {name = details.name, amount = 1}
			else
				shoppingList[details.type].amount = shoppingList[details.type].amount + 1
			end
		end
		return shoppingList
	end
end

----------------------------------
--LOADSET
----------------------------------

function Dta.losa.loadItemSet(name, atOriginalLoc, newItems)
	if not Dta.checkIdle() then
		return
	end
	-- check input
	if not name then
		Dta.CPrint(Dta.Locale.Prints.LoadSelectSet)
		return
	end
	local settings = {}
	local success = {}
	local losa_ui = Dta.Tools.LoSa.window.constructions
	settings.coordX, success.x = Dta.ui.checkNumber(losa_ui.x:GetText(), 0)
	settings.coordY, success.y = Dta.ui.checkNumber(losa_ui.y:GetText(), 0)
	settings.coordZ, success.z = Dta.ui.checkNumber(losa_ui.z:GetText(), 0)
	settings.n_copies, success.n_copies = Dta.ui.checkNumber(losa_ui.NrCopies:GetText(), 1)

	if not success.x or
		not success.y or
		not success.z or
		not success.n_copies then
		Dta.CPrint(Dta.Locale.Prints.NumbersOnly)
		return
	end

	local constructionSet = Dta.losa.getConstructionSet()

	if constructionSet and constructionSet[name] ~= nil then
		settings.cp = Dta.items.getCentralPoint(constructionSet[name])
		settings.player = Inspect.Unit.Detail("player")
		-- check if set location is reasonably near
		if atOriginalLoc and not Dta.losa.confirmPlayerDistance(settings.player, settings.cp) then
			return
		end
		-- check available items
		local shoppingList = Dta.losa.getGroupShoppingList(constructionSet[name])
		if newItems then
			Dta.losa.ScanInventory(shoppingList, true, false) -- settings.include_bags, settings.include_bank)
			local missing = Dta.losa.checkShoppingList(shoppingList, settings.n_copies)
			if missing then
				Dta.losa.printMissingItems(missing, shoppingList, Dta.Locale.Prints.NotLoadedBags)
				return
			end
			Dta.items.DeselectAll()
			Dta.Co_DoneMessage = string.format(Dta.Locale.Prints.SetLoaded, name)
			Dta.AddItem_Co = coroutine.create(Dta.losa.pasteGroup)
			local ok, err = coroutine.resume(Dta.AddItem_Co, constructionSet[name], shoppingList, settings, newItems, atOriginalLoc)
			if not ok then dump(err) end
		else
			Dta.losa.ScanSelection(shoppingList)
			local missing = Dta.losa.checkShoppingList(shoppingList, settings.n_copies)
			if missing then
				Dta.losa.printMissingItems(missing, shoppingList, Dta.Locale.Prints.NotLoadedSelection)
				return
			end
			Dta.losa.pasteGroup(constructionSet[name], shoppingList, settings, newItems, atOriginalLoc)
		end
	else
		Dta.CPrint(string.format(Dta.Locale.Prints.SetNotFound, name))
	end
end

function Dta.losa.pasteGroup(itemSet, shoppingList, settings, new_items, atOriginalLoc)
	if new_items then
		Dta.StartRecordingAdds()
	end
	-- determine new position unless at pasting at original position
	local newPlacement = { coordX = 0, coordY = 0, coordZ = 0 }
	if not atOriginalLoc then
		local player = settings.player
		newPlacement.coordX = player.coordX - settings.cp.x + 15
		newPlacement.coordY = player.coordY - settings.cp.minValuaY + 0.05
		newPlacement.coordZ = player.coordZ - settings.cp.z
	end
	-- paste the requested number of copies
	for k = 0, settings.n_copies - 1, 1 do
		local offset = { coordX = newPlacement.coordX + k * settings.coordX,
						coordY = newPlacement.coordY + k * settings.coordY,
						coordZ = newPlacement.coordZ + k * settings.coordZ }
		Dta.copa.pasteSet(itemSet, shoppingList, offset, new_items)
	end
	if new_items then
		local paste_selection = Dta.FinishRecordingAdds()
		Dta.Selections.SaveSelection("<last loaded set>", paste_selection, true)
	end
end

----------------------------------
--REMOVESET
----------------------------------

function Dta.losa.deleteItemSet(name)
	local constructions = Dta.settings.get_savedsets("SavedSets")
	constructions[name] = nil
	Dta.losa.refreshLoadSelect()
	Dta.CPrint(string.format(Dta.Locale.Prints.SetRemoved, name))
end

function Dta.losa.removeGroupItem(name)
	local constructions = Dta.settings.get_savedsets("SavedSets")
	if name ~= nil and name ~= "" then
		if constructions and constructions[name] ~= nil then
			Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmDeleteSet, name),
									Dta.losa.deleteItemSet, nil, name)
		else
			Dta.CPrint(string.format(Dta.Locale.Prints.NotRemoved, name))
		end
	else
		Dta.CPrint(Dta.Locale.Prints.RemoveSelectSet)
	end
end
