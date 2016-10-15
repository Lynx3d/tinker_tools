local Dta = select(2, ...)

Dta.alphabet = {}

Dta.alphabet.Size = {}

function Dta.alphabet.AlphabetmodeHorizontalChanged()
	if Dta.Tools.Alfiebet.window.Alphabet.modeHorizontal:GetChecked() then
		Dta.Tools.Alfiebet.window.Alphabet.modeVertical:SetChecked(false)
	elseif not Dta.Tools.Alfiebet.window.Alphabet.modeVertical:GetChecked() then
		Dta.Tools.Alfiebet.window.Alphabet.modeHorizontal:SetChecked(true)
	end
end

function Dta.alphabet.AlphabetmodeVerticalChanged()
	if Dta.Tools.Alfiebet.window.Alphabet.modeVertical:GetChecked() then
		Dta.Tools.Alfiebet.window.Alphabet.modeHorizontal:SetChecked(false)
	elseif not Dta.Tools.Alfiebet.window.Alphabet.modeHorizontal:GetChecked() then
		Dta.Tools.Alfiebet.window.Alphabet.modeVertical:SetChecked(true)
	end
end

function Dta.alphabet.loadFonts()
	local items = {}
	local fonts = Dta.settings.get_defaults("SavedAlphabets")
	if fonts then
		for name, _ in pairs(fonts) do
			table.insert(items, name)
		end
	end
	return items
end

function Dta.alphabet.FontSelected(font)
	Dta.alphabet.Size = Dta.settings.get_defaults("SavedAlphabets")[font]
	Dta.Tools.Alfiebet.window.Alphabet.SizeLoad:SetItems(Dta.alphabet.loadSize())
	Dta.Tools.Alfiebet.window.Alphabet.SizeLoad:ResizeToFit()
	Dta.Tools.Alfiebet.window.Alphabet.SizeLoad:SetWidth(100)

end

function Dta.alphabet.FilterChanged()
	local alphabet_ui = Dta.Tools.Alfiebet.window.Alphabet
	local category = alphabet_ui.FilterSelect:GetSelectedValue()
	alphabet_ui.TypeLoad:SetItems(Dta.Replacement.loadAlphabetSkins(category))
end

function Dta.alphabet.loadSize()
	local items = {}
	if Dta.alphabet.Size then
		for name, _ in pairs(Dta.alphabet.Size) do
			table.insert(items, name)
		end
	end
	return items
end

function Dta.alphabet.CheckInput()
	local alphabet_ui = Dta.Tools.Alfiebet.window.Alphabet
	local settings = {}
	settings.word = alphabet_ui.Word:GetText()
	settings.font = alphabet_ui.FontLoad:GetSelectedItem()
	settings.size = alphabet_ui.SizeLoad:GetSelectedItem()
	settings.skin = alphabet_ui.TypeLoad:GetSelectedValue()

	if settings.font == nil or settings.font == "" then
		Dta.CPrint(Dta.Locale.Prints.SelectFont)
		return false
	end

	if settings.size == nil or settings.size == "" then
		Dta.CPrint(Dta.Locale.Prints.SelectSize)
		return false
	end

	if settings.skin == nil or settings.skin == "" then
		Dta.CPrint(Dta.Locale.Prints.SelectSkin)
		return false
	end
	settings.skin_data = Dta.Defaults.Skins[settings.skin]

	if settings.word ~= "" then
		if(settings.word:match("%d+")) then
			Dta.CPrint(Dta.Locale.Prints.OnlyLetters)
			return false
		elseif(settings.word:match("%W")) then
			Dta.CPrint(Dta.Locale.Prints.OnlyLetters)
			return false
		end
	else
		Dta.CPrint(Dta.Locale.Prints.TypeWord)
		return false
	end
	if alphabet_ui.modeHorizontal:GetChecked() then
		settings.orientation = "Horizontal"
	elseif alphabet_ui.modeVertical:GetChecked() then
		settings.orientation = "Vertical"
	end
	settings.letters = Dta.settings.get_defaults("SavedAlphabets")[settings.font][settings.size]
	return settings
end

function Dta.alphabet.AlphabetPrintMaterials()
	local settings = Dta.alphabet.CheckInput()
	if not settings then
		return
	end

	local shoppingList = {}
	for c in settings.word:gmatch"." do
		Dta.alphabet.AddLetterToList(c, settings, shoppingList)
	end
	Dta.alphabet.PrintShoppingList(shoppingList, settings.word)
end

function Dta.alphabet.AlphabetLoadClicked()
	if not Dta.checkIdle() then
		return
	end

	local settings = Dta.alphabet.CheckInput()
	if not settings then
		return
	end

	local shoppingList = {}
	for c in settings.word:gmatch"." do
		Dta.alphabet.AddLetterToList(c, settings, shoppingList)
	end
	Dta.losa.ScanInventory(shoppingList, true, false) -- only inventory currently
	local missing = Dta.losa.checkShoppingList(shoppingList, settings.n_copies)
	if missing then
		Dta.losa.printMissingItems(missing, shoppingList, Dta.Locale.Prints.WordMissingItems)
		return
	end
	local player = Inspect.Unit.Detail("player")
	settings.player = { coordX = player.coordX, coordY = player.coordY, coordZ = player.coordZ }
	Dta.items.DeselectAll()
	Dta.Co_DoneMessage = Dta.Locale.Prints.WordFinished
	Dta.AddItem_Co = coroutine.create(Dta.alphabet.LoadWord)
	local ok, err = coroutine.resume(Dta.AddItem_Co, shoppingList, settings)
	if not ok then dump(err) end
end

function Dta.alphabet.LoadWord(shoppingList, settings)
	local letter_index = 1
	if settings.orientation == "Vertical" then
		settings.word = string.reverse(settings.word)
	end
	for c in settings.word:gmatch"." do
		Dta.alphabet.PasteLetter(c, shoppingList, settings, letter_index)
		letter_index = letter_index + 1
	end
end

--------------------------------------
--Shopping List
--------------------------------------

function Dta.alphabet.AddLetterToList(letter, settings, shoppingList)
	local Upper = string.upper(letter)

	for k, details in pairs(settings.letters[Upper]) do
		local item = Dta.Replacement.GetItemForSkin(details.type, settings.skin_data)
		if shoppingList[item.type] == nil then
				shoppingList[item.type] = {name = item.name, amount = 1}
		else
			shoppingList[item.type].amount = shoppingList[item.type].amount + 1
		end
	end
end

function Dta.alphabet.PrintShoppingList(list, word)
	if list ~= nil and Dta.losa.tableLength(list) > 0 then
		Dta.CPrint(string.format(Dta.Locale.Prints.WordNeededItems, word))
		for id, details in pairs(list) do
			Dta.CPrint(string.format("%s: %d", details.name, details.amount))
		end
	else
		Dta.CPrint(Dta.Locale.Prints.WordCouldNotPrint)
	end
end

-----------------------------------
--Load Word
-----------------------------------

function Dta.alphabet.PasteLetter(letter, shoppingList, settings, Offset)
	local Upper = string.upper(letter)

	local letterClipboard = settings.letters[Upper]
	local size = settings.size

	local XOffset = 0
	if settings.orientation == "Horizontal" then
		if size == "Large" then
			XOffset = 2.5 * (Offset - 1)
		elseif size == "Medium" then
			XOffset = 1.25 * (Offset - 1)
		elseif size == "Small" then
			XOffset = 0.75 * (Offset - 1)
		end
	else -- if settings.orientation == "Vertical" then
		if size == "Large" then
			XOffset = 3.5 * (Offset - 1)
		elseif size == "Medium" then
			XOffset = 1.75 * (Offset - 1)
		elseif size == "Small" then
			XOffset = 1.20 * (Offset - 1)
		end
	end

	local cp = Dta.items.getCentralPoint(letterClipboard)
	local player = settings.player

	for k, details in pairs(letterClipboard) do
		local item = Dta.Replacement.GetItemForSkin(details.type, settings.skin_data)

		local newPlacement = {
			--coordX = details.coordX,
			--coordY = details.coordY,
			--coordZ = details.coordZ,
			yaw = details.yaw,
			pitch = details.pitch,
			roll = details.roll,
			scale = details.scale,
			type = item.type
		}

		if settings.orientation == "Horizontal" then
			newPlacement.coordX = player.coordX + (details.coordX - cp.x) - XOffset
			newPlacement.coordY = player.coordY + (details.coordY - cp.minValuaY) + 1
		else --if Orientation == "Vertical" then
			newPlacement.coordX = player.coordX + (details.coordX - cp.x)
			newPlacement.coordY = player.coordY + (details.coordY - cp.minValuaY) + 1 + XOffset
		end
		newPlacement.coordZ = player.coordZ + (details.coordZ - cp.z) + 5
		-- fix a few specific letters
		if settings.font == "Magneto" and (Upper == "T" or Upper == "Y") then
			if size == "Large" then
				newPlacement.coordX = newPlacement.coordX + 0.45
			elseif size == "Medium" then
				newPlacement.coordX = newPlacement.coordX + 0.2
			elseif size == "Small" then
				newPlacement.coordX = newPlacement.coordX + 0.125
			end
		end

		-- This will coroutine.yield() for new items:
		Dta.copa.pasteSingleItem(newPlacement, shoppingList, true)

	end
end
