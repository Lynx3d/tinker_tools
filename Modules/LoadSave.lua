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
		Dta.losa.refreshLoadSelect()
	elseif not losa_ui.loadSavedSets:GetChecked() and not losa_ui.loadDeafaultSets:GetChecked()then
		losa_ui.loadTbxSets:SetChecked(true)
	end
end

function Dta.losa.useReferencePointChanged(self)
	local losa_ui = Dta.Tools.LoSa.window.constructions
	losa_ui.referencePick:SetVisible(self:GetChecked())
	losa_ui.refPointCoords:SetAlpha(self:GetChecked() and 1.0 or 0.5)
end

function Dta.losa.constructionSaveClicked()
	local losa_ui = Dta.Tools.LoSa.window.constructions
	local cr = coroutine.wrap(Dta.losa.saveGroupItemAttributes)
	cr(losa_ui.name:GetText(), losa_ui.useReferencePoint:GetChecked())
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

function Dta.losa.pickButtonClicked()
	if Dta.selectionCenter then
		Dta.losa.updateRefPoint(Dta.selectionCenter)
	end
end

function Dta.losa.updateRefPoint(refPoint)
	if refPoint then
		Dta.losa.referencePoint = Dta.copyTable(Dta.selectionCenter)
	else
		Dta.losa.referencePoint = nil
	end
	local losa_ui = Dta.Tools.LoSa.window
	if losa_ui then
		if refPoint then
			losa_ui.constructions.refPointCoords:SetText(string.format("x: %.3f  y: %.3f  z: %.3f",
														 refPoint.x, refPoint.y, refPoint.z))
		else
			losa_ui.constructions.refPointCoords:SetText("x: - y: - z: -")
		end
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

function Dta.losa.calculateOffset(itemSet, useRefPoint, centerPoint, player)
	local offset = {}
	if useRefPoint then
		if not Dta.losa.referencePoint then
			Dta.CPrint(Dta.Locale.Prints.PickRefPoint)
			return nil
		elseif not itemSet.referencePoint then
			Dta.CPrint(Dta.Locale.Prints.NoRefPointWarn)
		end
		local savedRefPoint = itemSet.referencePoint or centerPoint
		offset.coordX = Dta.losa.referencePoint.x - savedRefPoint.x
		offset.coordY = Dta.losa.referencePoint.y - savedRefPoint.y
		offset.coordZ = Dta.losa.referencePoint.z - savedRefPoint.z
	else
		offset.coordX = player.coordX - centerPoint.x + 15
		offset.coordY = player.coordY - centerPoint.minValuaY + 0.05
		offset.coordZ = player.coordZ - centerPoint.z
	end
	return offset
end

--------------------------------------
-- COPY SET TO CLIPBOARD
--------------------------------------

function Dta.losa.copyToClipboard(name)
	local losa_ui = Dta.Tools.LoSa.window.constructions
	local constructionSet, atOriginalLoc = Dta.losa.getConstructionSet()
	atOriginalLoc = atOriginalLoc and losa_ui.loadAtOriginalLoc:GetChecked()
	local useRefPoint = losa_ui.useReferencePoint:GetChecked()

	local itemSet = constructionSet and constructionSet[name]
	if not itemSet then return end

	local cp = Dta.items.getCentralPoint(constructionSet[name])
	local player = Inspect.Unit.Detail("player")
	local offset = false

	if atOriginalLoc then
		-- check if set location is reasonably near
		if not Dta.losa.confirmPlayerDistance(player, cp) then
			return
		end
	else
		offset = Dta.losa.calculateOffset(itemSet, useRefPoint, cp, player)
		if not offset then
			return
		end
	end
	-- TODO: check if clipboard empty
	Dta.clipboard.items = Dta.copyTable(constructionSet[name], true)
	Dta.clipboard.itemCount = #Dta.clipboard.items
	if offset then
		for _, item in ipairs(Dta.clipboard.items) do
			item.coordX = item.coordX + offset.coordX
			item.coordY = item.coordY + offset.coordY
			item.coordZ = item.coordZ + offset.coordZ
		end
	end
	Dta.CPrint(string.format(Dta.Locale.Prints.CopiedClipboard, name))
end

--------------------------------------
--SAVESET
--------------------------------------

function Dta.losa.saveGroupItemAttributes(name, useRefPoint, overwrite)
	if Dta.selectionCount < 1 then
		Dta.CPrint(Dta.Locale.Prints.MinOneItem)
		return
	elseif useRefPoint and not Dta.losa.referencePoint then
		Dta.CPrint(Dta.Locale.Prints.PickRefPoint)
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
				Dta.losa.saveGroupItemAttributes(name, useRefPoint, true)
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
		if useRefPoint then
			groupDetails.referencePoint = Dta.copyTable(Dta.losa.referencePoint)
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

	if name then
		if constructionSet and constructionSet[name] then
			local list = Dta.losa.getGroupShoppingList(constructionSet[name])
			if list then
				Dta.ui.ShowMaterialList(list)
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
		for k, details in ipairs(itemlist) do
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
	local losa_ui = Dta.Tools.LoSa.window.constructions

	local constructionSet, allowOriginalLoc = Dta.losa.getConstructionSet()
	local itemSet = constructionSet and constructionSet[name]
	if not itemSet then
		Dta.CPrint(string.format(Dta.Locale.Prints.SetNotFound, name))
		return
	end

	atOriginalLoc = allowOriginalLoc and atOriginalLoc

	settings.cp = Dta.items.getCentralPoint(itemSet)
	settings.player = Inspect.Unit.Detail("player")
	if atOriginalLoc then
		-- check if set location is reasonably near
		if not Dta.losa.confirmPlayerDistance(settings.player, settings.cp) then
			return
		end
		settings.offset = { coordX = 0, coordY = 0, coordZ = 0 }
	else
		-- check we can calculate the offset
		local useRefPoint = losa_ui.useReferencePoint:GetChecked()
		settings.offset = Dta.losa.calculateOffset(itemSet, useRefPoint, settings.cp, settings.player)
		if not settings.offset then
			return
		end
	end
	-- check available items
	local shoppingList = Dta.losa.getGroupShoppingList(itemSet)
	if newItems then
		Dta.losa.ScanInventory(shoppingList, true, false) -- settings.include_bags, settings.include_bank)
		local missing = Dta.losa.checkShoppingList(shoppingList)
		if missing then
			Dta.losa.printMissingItems(missing, shoppingList, Dta.Locale.Prints.NotLoadedBags)
			return
		end
		Dta.items.DeselectAll()
		Dta.Co_DoneMessage = string.format(Dta.Locale.Prints.SetLoaded, name)
		Dta.AddItem_Co = coroutine.create(Dta.losa.pasteGroup)
		local ok, err = coroutine.resume(Dta.AddItem_Co, itemSet, shoppingList, settings, newItems)
		if not ok then dump(err) end
	else
		Dta.losa.ScanSelection(shoppingList)
		local missing = Dta.losa.checkShoppingList(shoppingList)
		if missing then
			Dta.losa.printMissingItems(missing, shoppingList, Dta.Locale.Prints.NotLoadedSelection)
			return
		end
		Dta.losa.pasteGroup(itemSet, shoppingList, settings, newItems)
	end
end

function Dta.losa.pasteGroup(itemSet, shoppingList, settings, new_items)
	if new_items then
		Dta.StartRecordingAdds()
	end
	-- determine new position unless at pasting at original position
	--[[local newPlacement = settings.offset or { coordX = 0, coordY = 0, coordZ = 0 }
	if not atOriginalLoc then
		local player = settings.player
		newPlacement.coordX = player.coordX - settings.cp.x + 15
		newPlacement.coordY = player.coordY - settings.cp.minValuaY + 0.05
		newPlacement.coordZ = player.coordZ - settings.cp.z
	end]]
	-- paste the set at final location
	Dta.copa.pasteSet(itemSet, shoppingList, settings.offset, new_items)

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
