local Dta = select(2, ...)

--[[ shopping list structure:
list = { <type> = {	name = <item name>
					amount = <required number>,
					-- only ater ScanInventory():
					stock = <total available>,
					shelf = { <id> = <stack size>, ... }
				  },
		 ...
		}
 ]]

-- compile a list of inventory items available for requested items
function Dta.losa.ScanInventory(shoppingList, includeBags, includeBank)
	local slots = {}
	if includeBags then
		slots[Utility.Item.Slot.Inventory()] = true -- "si", means all inventory slots
	end
	if includeBank then
		slots[Utility.Item.Slot.Vault()] = true -- "sv", means all vault tabs
		slots[Utility.Item.Slot.Bank()] = true  -- "sb", means all slots of bank's bags,
	end                                         -- plus the 8 bag slots themselves
	local inventory = Inspect.Item.List(slots)
	for _s, id in pairs(inventory) do
		if id then -- empty slots are set to "false"...usually
			local item = Inspect.Item.Detail(id) -- sometimes empty slots have IDs but return nil here
			if item then
				local cart_item = shoppingList[item.type]
				if item ~= nil and cart_item ~= nil then
					if not cart_item.shelf then
						cart_item.shelf = {}
						cart_item.stock = 0
					end
					cart_item.stock = cart_item.stock + (item.stack or 1) --'stack' field only available for stackable items
					cart_item.shelf[id] = item.stack or 1
				end
			end
		end
	end
end

-- compile a list of selected items available for requested items
function Dta.losa.ScanSelection(shoppingList)
	for id, item in pairs(Dta.selectedItems) do
		local cart_item = shoppingList[item.type]
		if cart_item ~= nil then
			if not cart_item.shelf then
				cart_item.shelf = {}
				cart_item.stock = 0
			end
			cart_item.stock = cart_item.stock + 1
			cart_item.shelf[id] = 1
		end
	end
end


-- check availability and compile a list of missing items, if any
function Dta.losa.checkShoppingList(shoppingList, NrCopies)
	NrCopies = NrCopies or 1
	local missingItems = {}
	for item, entry in pairs(shoppingList) do
		if not entry.stock then
			missingItems[item] = entry.amount * NrCopies
		else
			local missing = entry.amount * NrCopies - entry.stock
			if missing > 0 then
				missingItems[item] = missing
			end
		end
	end
	return next(missingItems) and missingItems
end

-- print missing items to fullfill a shopping list
function Dta.losa.printMissingItems(missing, shoppingList, message)
	Dta.CPrint(message)
	for id, amount in pairs(missing) do
		local stock = shoppingList[id].stock or 0
		Dta.CPrint(string.format("%s: %d (%d/%d)", shoppingList[id].name, amount, stock, stock+amount))
	end
end
