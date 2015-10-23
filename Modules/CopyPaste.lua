local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.copa = {}

Dta.copa.CountedItems = 0

--------------------------------------
--COPY / PASTE BUTTON HANDLERS
--------------------------------------

function Dta.copa.CopaOffsetChanged()
	if Dta.ui.windowCopyPaste.copyPaste.multiplyOffsets:GetChecked() then
		Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetVisible(true)
		Dta.ui.windowCopyPaste.copyPaste.NewItemNrLabel:SetVisible(true)
		--Dta.ui.windowCopyPaste.copyPaste.flickerReduce:SetVisible(true)
	elseif not Dta.ui.windowCopyPaste.copyPaste.multiplyOffsets:GetChecked() then
		Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetVisible(false)
		--Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetText("")
		Dta.ui.windowCopyPaste.copyPaste.NewItemNrLabel:SetVisible(false)
		--Dta.ui.windowCopyPaste.copyPaste.flickerReduce:SetVisible(false)
	end
end

function Dta.copa.CopaNewItemChanged()
	if Dta.ui.windowCopyPaste.copyPaste.NewItem:GetChecked() then
		Dta.ui.windowCopyPaste.copyPaste.Bags:SetVisible(true)
		Dta.ui.windowCopyPaste.copyPaste.Bank:SetVisible(true)
		Dta.ui.windowCopyPaste.copyPaste.SelectionPivot:SetVisible(true)
	else
		Dta.ui.windowCopyPaste.copyPaste.Bags:SetVisible(false)
		Dta.ui.windowCopyPaste.copyPaste.Bank:SetVisible(false)
		Dta.ui.windowCopyPaste.copyPaste.SelectionPivot:SetVisible(false)
	end
end

function Dta.copa.copyButtonClicked()
	Dta.copa.copyItemAttributes()
end

function Dta.copa.pasteButtonClicked()
	if not Dta.checkIdle() then
		return
	end

	local settings = Dta.copa.checkInput()
	if not settings then
		return
	end

	local shoppingList
	if Dta.clipboard.items then
		shoppingList = Dta.losa.getGroupShoppingList(Dta.clipboard.items)
		if settings.rotate or settings.scale then
			if settings.selection_pivot then
				settings.pivot = Dta.selectionCenter
			else
				settings.pivot = Dta.items.getCentralPoint(Dta.clipboard.items)
			end
		end
	else
		print(Lang[Dta.Language].Prints.CopyFirst)
		return
	end
	if settings.new_items then
		-- test
		Dta.losa.ScanInventory(shoppingList, settings.include_bags, settings.include_bank)
		local missing = Dta.losa.checkShoppingList(shoppingList, settings.n_copies)
		if missing then
			-- TODO: proper localized error msg
			print("missing items:")
			for id, amount in pairs(missing) do
				print(string.format("%s: %d", shoppingList[id].name, amount))
			end
			return
		end
		Dta.items.DeselectAll()
		Dta.Co_DoneMessage = Lang[Dta.Language].Prints.PasteFinished
		Dta.AddItem_Co = coroutine.create(Dta.copa.pasteClipboard)
		local ok, err = coroutine.resume(Dta.AddItem_Co, shoppingList, settings)
		if not ok then dump(err) end
	else
		if Dta.clipboard.itemCount > 1 or settings.n_copies then
			Dta.losa.ScanSelection(shoppingList)
			local missing = Dta.losa.checkShoppingList(shoppingList, settings.n_copies)
			if missing then
				-- TODO: proper localized error msg
				print("missing items:")
				for id, amount in pairs(missing) do
					print(string.format("%s: %d", shoppingList[id].name, amount))
				end
				return
			end
		else -- single item, ignore item type
			if Dta.selectionCount == 0 then return end
			local id = next(shoppingList)
			shoppingList[id].shelf = { [next(Dta.selectedItems)] = 1 }
			shoppingList[id].stock = 1
		end
		Dta.copa.pasteClipboard(shoppingList, settings)
	end
end

function Dta.copa.checkInput()
	local values = {}
	local success = {}
	local copa_ui = Dta.ui.windowCopyPaste.copyPaste

	if copa_ui.x:GetChecked() then
		values.coordX, success.x = Dta.ui.checkNumber(copa_ui.xOffset:GetText(), 0)
	else
		values.coordX = 0
	end
	if copa_ui.y:GetChecked() then
		values.coordY, success.y = Dta.ui.checkNumber(copa_ui.yOffset:GetText(), 0)
	else
		values.coordY = 0
	end
	if copa_ui.z:GetChecked() then
		values.coordZ, success.z = Dta.ui.checkNumber(copa_ui.zOffset:GetText(), 0)
	else
		values.coordZ = 0
	end
	if copa_ui.pitch:GetChecked() then
		values.pitch, success.pitch = Dta.ui.checkNumber(copa_ui.pitchOffset:GetText(), 0)
		values.rotate = values.pitch ~= 0
	end
	if copa_ui.yaw:GetChecked() then
		values.yaw, success.yaw = Dta.ui.checkNumber(copa_ui.yawOffset:GetText(), 0)
		values.rotate = values.rotate or values.yaw ~= 0
	end
	if copa_ui.roll:GetChecked() then
		values.roll, success.roll = Dta.ui.checkNumber(copa_ui.rollOffset:GetText(), 0)
		values.rotate = values.rotate or values.roll ~= 0
	end
	if copa_ui.scale:GetChecked() then
		values.scale, success.scale = Dta.ui.checkNumber(copa_ui.scaleOffset:GetText(), nil)
	end
	values.new_items = copa_ui.NewItem:GetChecked()
	values.include_bags = copa_ui.Bags:GetChecked()
	values.include_bank = copa_ui.Bank:GetChecked()
	if values.new_items then
		values.selection_pivot = Dta.ui.windowCopyPaste.copyPaste.SelectionPivot:GetChecked()
								and  Dta.selectionCount > 0
		if not values.include_bags and not values.include_bank then
			print(Lang[Dta.Language].Prints.SelectItemSource)
			return false
		end
	end

	values.flicker_reduce = copa_ui.flickerReduce:GetChecked()
	if copa_ui.multiplyOffsets:GetChecked() then
		values.n_copies, success.n_copies = Dta.ui.checkNumber(copa_ui.NewItemNr:GetText(), 1)
	end

	for k, v in pairs(success) do
		if not v then
			print(Lang[Dta.Language].Prints.NumbersOnly)
			return false
		end
	end
	if values.rotate then
		values.pitch = math.rad(values.pitch or 0)
		values.yaw = math.rad(values.yaw or 0)
		values.roll = math.rad(values.roll or 0)
	end
	return values
end

--------------------------------------
--COPY ITEMS
--------------------------------------

function Dta.copa.copyItemAttributes()
	if Dta.selectionCount > 0 then
		Dta.clipboard = { itemCount = Dta.selectionCount, items = {} }
		for k, details in pairs(Dta.selectedItems) do
			table.insert(Dta.clipboard.items, {
				name = details.name,
				type = details.type,
				coordX = details.coordX,
				coordY = details.coordY,
				coordZ = details.coordZ,
				yaw = details.yaw,
				pitch = details.pitch,
				roll = details.roll,
				scale = details.scale
			})
		end
	else
		print(Lang[Dta.Language].Prints.Copy_SelectItem)
	end
end

--------------------------------------
--PASTE CLIPBOARD ITEMS
--------------------------------------

local function copyTable(tbl)
	local t_copy = {}
	for k, v in pairs(tbl) do t_copy[k] = v end
	return t_copy
end

function Dta.copa.pasteSingleItem(details, shoppingList, newItem)
	-- find item in "shelf" info of our shopping list
	local list_entry = shoppingList[details.type]
	local id, stacksize = next(list_entry.shelf)
	if newItem then
		Dta.items.QueueAdd(id, details.coordX, details.coordY, details.coordZ,
							details.pitch, details.yaw, details.roll, details.scale)
		coroutine.yield()
	else
		Dta.items.QueueTransform(id, details.coordX, details.coordY, details.coordZ,
							details.pitch, details.yaw, details.roll, details.scale)
	end
	if stacksize > 1 then
		list_entry.shelf[id] = stacksize - 1
	else
		-- shelf stack used up, remove
		list_entry.shelf[id] = nil
	end
end

function Dta.copa.pasteSet(itemSet, shoppingList, offset, newItems)
	local rot_matrix, pos_rel
	if offset.rotate then -- rotate
		rot_matrix = Dta.Matrix.createZYX(offset.pitch, offset.yaw, offset.roll, true)
	end

	for k, details in pairs(itemSet) do
		local new_details = copyTable(details)
		--TEST: apply move offset before rotate/scale
		new_details.coordX = new_details.coordX + offset.coordX
		new_details.coordY = new_details.coordY + offset.coordY
		new_details.coordZ = new_details.coordZ + offset.coordZ
		local new_rot
		if offset.pivot then
			if offset.rotate then
				new_rot, pos_rel = Dta.rotate.rotateItem(new_details, rot_matrix, offset.pivot)
				new_details.pitch = new_rot.pitch
				new_details.yaw = new_rot.yaw
				new_details.roll = new_rot.roll
			else
				pos_rel = {	new_details.coordX - offset.pivot.x,
							new_details.coordY - offset.pivot.y, 
							new_details.coordZ - offset.pivot.z }
			end
			if offset.scale then
				new_details.scale = details.scale * (1 + offset.scale)
				for i = 1, 3, 1 do
					pos_rel[i] = pos_rel[i] * (1 + offset.scale)
				end
			end
			new_details.coordX = offset.pivot.x + pos_rel[1]
			new_details.coordY = offset.pivot.y + pos_rel[2]
			new_details.coordZ = offset.pivot.z + pos_rel[3]
		end

		Dta.copa.pasteSingleItem(new_details, shoppingList, newItems)
	end
end

-- flicker reduction: alternate between adding and substracting a small offset
function Dta.copa.applyFlickerOffset(details, settings)
	if settings.flicker_reduce then
		local FlickerReduc = Dta.FlickerOffset and Dta.FlickerReduc or -Dta.FlickerReduc
		details.coordX = details.coordX + FlickerReduc
		details.coordY = details.coordY + FlickerReduc
		details.coordZ = details.coordZ + FlickerReduc
		Dta.FlickerOffset = not Dta.FlickerOffset
	end
end

function Dta.copa.pasteArray(clipboard, shoppingList, settings, new_items)
	for k = 1, settings.n_copies, 1 do
		local offset = { coordX = k * settings.coordX, coordY = k * settings.coordY,
						coordZ = k * settings.coordZ, pivot = settings.pivot }
		if settings.rotate then
			offset.rotate = true
			offset.pitch = k * settings.pitch
			offset.yaw = k * settings.yaw
			offset.roll = k * settings.roll
		end
		if settings.scale then offset.scale = k * settings.scale end
		Dta.copa.applyFlickerOffset(offset, settings)
		if #clipboard > 1 or settings.selection_pivot then
			Dta.copa.pasteSet(Dta.clipboard.items, shoppingList, offset, new_items)
		else
			local new_details = copyTable(clipboard[1])
			for k, v in pairs(new_details) do
				if type(offset[k]) == "number" then
					new_details[k] = v + offset[k]
				end
			end
			Dta.copa.pasteSingleItem(new_details, shoppingList, new_items)
		end
	end
end

-- selectively copy items values
function Dta.copa.genNewDetails(details, settings)
	local new_details = { type = details.type }
	local copa_ui = Dta.ui.windowCopyPaste.copyPaste
	new_details.coordX = copa_ui.x:GetChecked() and details.coordX + settings.coordX or nil
	new_details.coordY = copa_ui.y:GetChecked() and details.coordY + settings.coordY or nil
	new_details.coordZ = copa_ui.z:GetChecked() and details.coordZ + settings.coordZ or nil
	new_details.pitch = copa_ui.pitch:GetChecked() and details.pitch + settings.pitch or nil
	new_details.yaw = copa_ui.yaw:GetChecked() and details.yaw + settings.yaw or nil
	new_details.roll = copa_ui.roll:GetChecked() and details.roll + settings.roll or nil
	new_details.scale = copa_ui.scale:GetChecked() and details.scale + (settings.scale or 0) or nil
	return new_details
end

function Dta.copa.pasteClipboard(shoppingList, settings)
	if settings.n_copies then
		Dta.copa.pasteArray(Dta.clipboard.items, shoppingList, settings, settings.new_items)
	elseif Dta.clipboard.itemCount > 1 or settings.selection_pivot then
		-- reminder: overwrites settings, but they don't get reused currently
		Dta.copa.applyFlickerOffset(settings, settings)
		Dta.copa.pasteSet(Dta.clipboard.items, shoppingList, settings, settings.new_items)
	else
		local new_details
		if settings.new_items then
			new_details = copyTable(Dta.clipboard.items[1])
			for k, v in pairs(new_details) do
				if type(settings[k]) == "number" then
					new_details[k] = v + settings[k]
				end
			end
		else
			new_details  = Dta.copa.genNewDetails(Dta.clipboard.items[1], settings)
		end
		Dta.copa.applyFlickerOffset(new_details, settings)
		Dta.copa.pasteSingleItem(new_details, shoppingList, settings.new_items)
	end
end
