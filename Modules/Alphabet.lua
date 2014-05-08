Dta.alphabet = {}

Dta.alphabet.Fonts = {}
Dta.alphabet.Size = {}
Dta.alphabet.Letters = {}
Dta.alphabet.Skins = {}
Dta.alphabet.curentFonts = ""

Dta.alphabet.WordClipboard = {}
Dta.alphabet.LetterClipboard = {}
Dta.alphabet.TempClipboard = {}

Dta.alphabet.LastLetter = ""
Dta.alphabet.PastingWord = false

Dta.alphabet.PlaceWord_Co_Active = false
Dta.alphabet.PlaceLetter_Co_Active = false

function Dta.alphabet.AlphabetmodeHorizontalChanged()
      if Dta.ui.windowAlphabet.Alphabet.modeHorizontal:GetChecked() then
        Dta.ui.windowAlphabet.Alphabet.modeVertical:SetChecked(false)
      elseif not Dta.ui.windowAlphabet.Alphabet.modeVertical:GetChecked() then
        Dta.ui.windowAlphabet.Alphabet.modeHorizontal:SetChecked(true)
      end
end

function Dta.alphabet.AlphabetmodeVerticalChanged()
    if Dta.ui.windowAlphabet.Alphabet.modeVertical:GetChecked() then
        Dta.ui.windowAlphabet.Alphabet.modeHorizontal:SetChecked(false)
    elseif not Dta.ui.windowAlphabet.Alphabet.modeHorizontal:GetChecked() then
        Dta.ui.windowAlphabet.Alphabet.modeVertical:SetChecked(true)
    end
end

function Dta.alphabet.loadFonts()
        if Dta.alphabet.Fonts == nil or Dta.alphabet.Fonts == {} then
            return {}
        else
            local items = {}
            for name, _ in pairs(Dta.alphabet.Fonts) do
                table.insert(items, name)
        end
            return items
    end
end

function Dta.alphabet.FontSelected(font)
    Dta.alphabet.Size = {}
    Dta.alphabet.curentFonts = ""
    Dta.alphabet.Size = Dta.settings.get_alphabetSize("SavedAlphabets", font)
    Dta.alphabet.curentFonts = font
    Dta.ui.windowAlphabet.Alphabet.SizeLoad:SetItems(Dta.alphabet.loadSize())
    Dta.ui.windowAlphabet.Alphabet.SizeLoad:ResizeToFit()
    Dta.ui.windowAlphabet.Alphabet.SizeLoad:SetWidth(100)

end

function Dta.alphabet.SizeSelected(size)
    Dta.alphabet.Letters = {}
    Dta.alphabet.Letters = Dta.settings.get_alphabetLetters("SavedAlphabets", Dta.alphabet.curentFonts, size)
end

function Dta.alphabet.loadSize()
    if Dta.alphabet.Size == nil or Dta.alphabet.Size == {} then
        return {}
    else
        local items = {}
        for name, _ in pairs(Dta.alphabet.Size) do
            table.insert(items, name)
        end
        return items
    end
end

function Dta.alphabet.SkinSelected(item)
    if not Dta.alphabet.PlaceWord_Co_Active then
        Dta.Replacement.TableSetSkins(Dta.Replacement.Skins[item])
    end
end

function Dta.alphabet.alphabetPrintMaterials()
    local word = Dta.ui.windowAlphabet.Alphabet.Word:GetText()
    local font = Dta.ui.windowAlphabet.Alphabet.FontLoad:GetSelectedItem()
    local size = Dta.ui.windowAlphabet.Alphabet.SizeLoad:GetSelectedItem()
    local Skins = Dta.ui.windowAlphabet.Alphabet.TypeLoad:GetSelectedItem()

    if font == nil or font == "" then
        return print(Lang[Dta.Language].Prints.SelectFont)
    end

    if size == nil or size == "" then
        return print(Lang[Dta.Language].Prints.SelectSize)
    end

    if Skins == nil or Skins == "" then
        return print(Lang[Dta.Language].Prints.SelectSkin)
    end


    if word ~= "" then
        if(word:match("%d+")) then
            return print(Lang[Dta.Language].Prints.OnlyLetters)
        end
    end

    if word ~= "" then
        if(word:match("%W")) then
            print(Lang[Dta.Language].Prints.OnlyLetters)
        else
            Dta.alphabet.WordClipboard = {}
            for c in word:gmatch"." do
                Dta.alphabet.JoinWord(c)
            end
            Dta.alphabet.printShoppingList(word)
        end
    else
        print(Lang[Dta.Language].Prints.TypeWord)
    end
end

function Dta.alphabet.alphabetLoadClicked()
    local word = Dta.ui.windowAlphabet.Alphabet.Word:GetText()
    local font = Dta.ui.windowAlphabet.Alphabet.FontLoad:GetSelectedItem()
    local size = Dta.ui.windowAlphabet.Alphabet.SizeLoad:GetSelectedItem()
    local Skins = Dta.ui.windowAlphabet.Alphabet.TypeLoad:GetSelectedItem()

    if font == nil or font == "" then
        return print(Lang[Dta.Language].Prints.SelectFont)
    end

    if size == nil or size == "" then
        return print(Lang[Dta.Language].Prints.SelectSize)
    end

    if Skins == nil or Skins == "" then
        return print(Lang[Dta.Language].Prints.SelectSkin)
    end

    if word ~= "" then
        if(word:match("%d+")) then
            return print(Lang[Dta.Language].Prints.OnlyLetters)
        end
    end

    if word ~= "" then
        if(word:match("%W")) then
            print(Lang[Dta.Language].Prints.OnlyLetters)
        else
            Dta.alphabet.WordClipboard = {}
            for c in word:gmatch"." do
                Dta.alphabet.JoinWord(c)
            end

            local NrOfItems = #Dta.alphabet.WordClipboard
            Dta.ItemsToPlace = NrOfItems
            Dta.FinishedSet = false
            Dta.items.DeselectAll()
            Dta.alphabet.LastLetter = ""

            local shoppingList = Dta.alphabet.getWordShoppingList()
            local missingItems = Dta.alphabet.checkInventory(shoppingList)

            local player = Inspect.Unit.Detail("player")
            local PlayerCoordX = player.coordX
            local PlayerCoordY = player.coordY
            local PlayerCoordZ = player.coordZ
            local k = 1
            local offsetMulti = 0
            local Orientation = ""
            Dta.alphabet.PastingWord = true

            if Dta.ui.windowAlphabet.Alphabet.modeHorizontal:GetChecked() then
                word = word
                Orientation = "Horizontal"
            elseif Dta.ui.windowAlphabet.Alphabet.modeVertical:GetChecked() then
                word = string.reverse(word)
                Orientation = "Vertical"
            end

            if Dta.losa.tableLength(missingItems) > 0 then
                print(Lang[Dta.Language].Prints.WordMissingItems)
                for id, details in pairs(missingItems) do
                    print(string.format("%s: %d", details.name, details.amount))
                end
            else
                Dta.alphabet.Co_PlaceWord = coroutine.create(function ()
                    for c in word:gmatch"." do
                        if k < #word then
                            Dta.alphabet.PlaceWord_Co_Active = true
                            k = k + 1
                            offsetMulti = offsetMulti +1
                        else
                            Dta.alphabet.PlaceWord_Co_Active = false
                            offsetMulti = offsetMulti +1
                        end


                        Dta.alphabet.pasteLetter(c, size, PlayerCoordX, PlayerCoordY, PlayerCoordZ, offsetMulti, Orientation, font)
                        coroutine.yield()
                    end
                end)
                coroutine.resume(Dta.alphabet.Co_PlaceWord)

            end
        end
    else
        print(Lang[Dta.Language].Prints.TypeWord)
    end
end

--------------------------------------
--Shopping List
--------------------------------------
function Dta.alphabet.JoinWord(letter)
    local Upper = letter:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)

    Dta.alphabet.TempClipboard = {}
    Dta.alphabet.TempClipboard = Dta.alphabet.Letters[Upper]

    for k, details in pairs(Dta.alphabet.Letters[Upper]) do
        local Skins = details.name
        --print(test)
        --print(element)
        if string.find(Skins, "Tile") then
            details.name = Dta.Replacement.TileName
            details.type = Dta.Replacement.TileType
        end
        if string.find(Skins, "Rectangle") then
            details.name = Dta.Replacement.RectangleName
            details.type = Dta.Replacement.RectangleType
        end
        if string.find(Skins, "Plank") then
            details.name = Dta.Replacement.PlankName
            details.type = Dta.Replacement.PlankType
        end
        if string.find(Skins, "Cube") then
            details.name = Dta.Replacement.CubeName
            details.type = Dta.Replacement.CubeType
        end
        if string.find(Skins, "Triangle") then
            details.name = Dta.Replacement.TriangleName
            details.type = Dta.Replacement.TriangleType
        end
        if string.find(Skins, "Pole") then
            details.name = Dta.Replacement.PoleName
            details.type = Dta.Replacement.PoleType
        end
    end

    Dta.alphabet.JoinTables(Dta.alphabet.WordClipboard, Dta.alphabet.TempClipboard)
end


function Dta.alphabet.JoinTables(Table01, Table02)
    for k, v in pairs(Table02) do
        table.insert(Table01, v)
    end
    return Table01
end

function Dta.alphabet.getWordShoppingList()
  if #Dta.alphabet.WordClipboard > 0 then
    local shoppingList = {}
    for k, details in pairs(Dta.alphabet.WordClipboard) do
      if shoppingList[Dta.alphabet.WordClipboard[k].type] == nil then
        shoppingList[Dta.alphabet.WordClipboard[k].type] = {name = Dta.alphabet.WordClipboard[k].name, amount = 1}
      else
        shoppingList[Dta.alphabet.WordClipboard[k].type].amount = shoppingList[Dta.alphabet.WordClipboard[k].type].amount + 1
      end
    end
    return shoppingList
  end
end

function Dta.alphabet.printShoppingList(name)
    local list = Dta.alphabet.getWordShoppingList()
        if list ~= nil and Dta.losa.tableLength(list) > 0 then
            print(string.format(Lang[Dta.Language].Prints.WordNeededItems, name))
            for id, details in pairs(list) do
                print(string.format("%s: %d", details.name, details.amount))
            end
        else
            print(Lang[Dta.Language].Prints.WordCouldNotPrint)
        end
end

-----------------------------------
--Load Word
-----------------------------------

function Dta.alphabet.checkInventory(shoppingList) --ToDo Split up for Bag, Bank or Vault
  if #Dta.alphabet.WordClipboard > 0 then
    --loop through bags
    --print(#shoppingList)
    bagNo = 1
    for _, bag in pairs(Inspect.Item.Detail(Utility.Item.Slot.Inventory("bag"))) do
      --loop through each slot in the bag
      for slot = 1, bag.slots, 1 do
        local item = Inspect.Item.Detail(Utility.Item.Slot.Inventory(bagNo, slot))
        --if the item matches something in the shopping list
        if item ~= nil and shoppingList[item.type] ~= nil then
          if item.stack == nil then item.stack = 1 end --if the item has no stack value, set its stack to 1
          if shoppingList[item.type].amount <= item.stack then --if there are more items in the stack than needed
            shoppingList[item.type] = nil -- remove the item from the shopping list (we have enough)
            Dta.itemList[item.type] = item.id --add the item to the item list
          else --otherwise just remove the amount we have
            shoppingList[item.type].amount = shoppingList[item.type].amount - item.stack
          end
        end
      end
      bagNo = bagNo + 1
    end
    return shoppingList
  end
end

function Dta.alphabet.pasteLetter(letter, size, PlayerCoordX, PlayerCoordY, PlayerCoordZ, Offset, Orientation, Font)
    local Upper = letter:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
    Dta.alphabet.LetterClipboard = {}
    Dta.alphabet.LetterClipboard = Dta.alphabet.Letters[Upper]


    for k, details in pairs(Dta.alphabet.Letters[Upper]) do
        local Skins = details.name
        --print(test)
        --print(element)
        if string.find(Skins, "Tile") then
            details.name = Dta.Replacement.TileName
            details.type = Dta.Replacement.TileType
        end
        if string.find(Skins, "Rectangle") then
            details.name = Dta.Replacement.RectangleName
            details.type = Dta.Replacement.RectangleType
        end
        if string.find(Skins, "Plank") then
            details.name = Dta.Replacement.PlankName
            details.type = Dta.Replacement.PlankType
        end
        if string.find(Skins, "Cube") then
            details.name = Dta.Replacement.CubeName
            details.type = Dta.Replacement.CubeType
        end
        if string.find(Skins, "Triangle") then
            details.name = Dta.Replacement.TriangleName
            details.type = Dta.Replacement.TriangleType
        end
        if string.find(Skins, "Pole") then
            details.name = Dta.Replacement.PoleName
            details.type = Dta.Replacement.PoleType
        end
    end
    --print("last Letter: " .. Dta.alphabet.LastLetter)
    --print("Current Letter: " .. Upper)
    local XOffset = 0
    if Orientation == "Horizontal" then
        if size == "Large" then
            XOffset = 2.5 * (Offset - 1)
        elseif size == "Medium" then
            XOffset = 1.25 * (Offset - 1)
        elseif size == "Small" then
            XOffset = 0.75 * (Offset - 1)
        end
    elseif Orientation == "Vertical" then
        if size == "Large" then
            XOffset = 3.5 * (Offset - 1)
        elseif size == "Medium" then
            XOffset = 1.75 * (Offset - 1)
        elseif size == "Small" then
            XOffset = 1.20 * (Offset - 1)
        end
    end

    Dta.alphabet.LastLetter = Upper

    Dta.alphabet.Co_PlaceLetter = coroutine.create(function ()
        for k, details in pairs(Dta.alphabet.LetterClipboard) do
            if k < #Dta.alphabet.LetterClipboard then
                Dta.alphabet.PlaceLetter_Co_Active = true
            else
                Dta.alphabet.PlaceLetter_Co_Active = false
            end


            local item = details.type

            local newPlacement = {
                coordX = details.coordX,
                coordY = details.coordY,
                coordZ = details.coordZ,
                yaw = details.yaw,
                pitch = details.pitch,
                roll = details.roll,
                scale = details.scale,
            }

            local cp = Dta.items.getCentralPoint(Dta.alphabet.LetterClipboard)
            if Orientation == "Horizontal" then
                if Font == "Magneto" and Upper == "T" or Font == "Magneto" and Upper == "Y" then
                    if size == "Large" then
                        newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x) - XOffset + 0.45
                        newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1
                    elseif size == "Medium" then
                        newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x) - XOffset + 0.2
                        newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1
                    elseif size == "Small" then
                        newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x) - XOffset + 0.125
                        newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1
                    end
                else
                    newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x) - XOffset
                    newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1
                end
            elseif Orientation == "Vertical" then
                if Font == "Magneto" and Upper == "T" or Font == "Magneto" and Upper == "Y" then
                    if size == "Large" then
                        newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x) + 0.45
                        newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1 + XOffset
                    elseif size == "Medium" then
                        newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x) + 0.2
                        newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1 + XOffset
                    elseif size == "Small" then
                        newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x) + 0.125
                        newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1 + XOffset
                    end
                else
                    newPlacement.coordX = PlayerCoordX + (details.coordX - cp.x)
                    newPlacement.coordY = PlayerCoordY + (details.coordY - cp.minValuaY) + 1 + XOffset
                end
            end
            newPlacement.coordZ = PlayerCoordZ + (details.coordZ - cp.z) + 5

            Dta.alphabet.PasteWord(item, newPlacement.coordX, newPlacement.coordY, newPlacement.coordZ, newPlacement.yaw, newPlacement.pitch, newPlacement.roll, newPlacement.scale)
            coroutine.yield()

        end
    end)
       coroutine.resume(Dta.alphabet.Co_PlaceLetter)
end

function Dta.alphabet.PasteWord(item, Set_x, Set_y, Set_z, Set_yaw, Set_pitch, Set_roll, Set_scale) --ToDo Split up for Bag, Bank or Both

    local items = Inspect.Item.List(Utility.Item.Slot.Inventory())
    for slot, id in pairs(items) do
        if id ~= false then
            local data = Inspect.Item.Detail(id)
            if data.type == item then

                local newPlacement = {coordX = Set_x,
                    coordY = Set_y,
                    coordZ = Set_z,
                    yaw = Set_yaw,
                    pitch = Set_pitch,
                    roll = Set_roll,
                    scale = Set_scale,
                    }

                Command.Dimension.Layout.Place(id, newPlacement)
            end
        end
    end
end
