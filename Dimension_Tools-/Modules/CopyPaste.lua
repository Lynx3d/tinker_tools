Dta.copa = {}

Dta.copa.CountedItems = 0

--------------------------------------
--COPY / PASTE BUTTON HANDLERS
--------------------------------------

function Dta.copa.CopaOffsetChanged()
    if Dta.ui.windowCopyPaste.copyPaste.multiplyOffsets:GetChecked() and Dta.ui.windowCopyPaste.copyPaste.NewItem:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetVisible(true)
        Dta.ui.windowCopyPaste.copyPaste.NewItemLabel:SetVisible(true)
      elseif not Dta.ui.windowCopyPaste.copyPaste.multiplyOffsets:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetVisible(false)
        Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetText("")
        Dta.ui.windowCopyPaste.copyPaste.NewItemLabel:SetVisible(false)
      end
end

function Dta.copa.CopaNewItemChanged()
    if Dta.ui.windowCopyPaste.copyPaste.NewItem:GetChecked() then
        if Dta.ui.windowCopyPaste.copyPaste.multiplyOffsets:GetChecked() then
            Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetVisible(true)
            Dta.ui.windowCopyPaste.copyPaste.NewItemLabel:SetVisible(true)
            Dta.ui.windowCopyPaste.copyPaste.Bags:SetVisible(true)
            Dta.ui.windowCopyPaste.copyPaste.Bank:SetVisible(true)
            Dta.ui.windowCopyPaste.copyPaste.Both:SetVisible(true)
        else
            Dta.ui.windowCopyPaste.copyPaste.Bags:SetVisible(true)
            Dta.ui.windowCopyPaste.copyPaste.Bank:SetVisible(true)
            Dta.ui.windowCopyPaste.copyPaste.Both:SetVisible(true)
        end
    elseif not Dta.ui.windowCopyPaste.copyPaste.NewItem:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetVisible(false)
        Dta.ui.windowCopyPaste.copyPaste.NewItemNr:SetText("")
        Dta.ui.windowCopyPaste.copyPaste.NewItemLabel:SetVisible(false)
        Dta.ui.windowCopyPaste.copyPaste.Bags:SetVisible(false)
        Dta.ui.windowCopyPaste.copyPaste.Bank:SetVisible(false)
        Dta.ui.windowCopyPaste.copyPaste.Both:SetVisible(false)

    end
end

function Dta.copa.CopaBagsChanged()
    if Dta.ui.windowCopyPaste.copyPaste.Bags:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.Bank:SetChecked(false)
        Dta.ui.windowCopyPaste.copyPaste.Both:SetChecked(false)
    elseif not Dta.ui.windowCopyPaste.copyPaste.Bank:GetChecked() and not Dta.ui.windowCopyPaste.copyPaste.Bank:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.Bags:SetChecked(true)
    end

end

function Dta.copa.CopaBankChanged()
    if Dta.ui.windowCopyPaste.copyPaste.Bank:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.Bags:SetChecked(false)
        Dta.ui.windowCopyPaste.copyPaste.Both:SetChecked(false)
    elseif not Dta.ui.windowCopyPaste.copyPaste.Bags:GetChecked() and not Dta.ui.windowCopyPaste.copyPaste.Both:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.Bank:SetChecked(true)
    end

end

function Dta.copa.CopaBothChanged()
    if Dta.ui.windowCopyPaste.copyPaste.Both:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.Bank:SetChecked(false)
        Dta.ui.windowCopyPaste.copyPaste.Bags:SetChecked(false)
    elseif not Dta.ui.windowCopyPaste.copyPaste.Bank:GetChecked() and not Dta.ui.windowCopyPaste.copyPaste.Bags:GetChecked() then
        Dta.ui.windowCopyPaste.copyPaste.Both:SetChecked(true)
    end

end

function Dta.copa.copyButtonClicked()
  Dta.copa.copyItemAttributes()
end

function Dta.copa.pasteButtonClicked()
  if Dta.ui.windowCopyPaste.copyPaste.NewItem:GetChecked() then
    Dta.copa.pasteMultipleNewItemAttributes(Dta.ui.windowCopyPaste.copyPaste.x:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.y:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.z:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.yaw:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.pitch:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.roll:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.scale:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.xOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.yOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.zOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.yawOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.pitchOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.rollOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.scaleOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.multiplyOffsets:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.NewItem:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.NewItemNr:GetText())
  else
    Dta.copa.pasteMultipleItemAttributes(Dta.ui.windowCopyPaste.copyPaste.x:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.y:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.z:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.yaw:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.pitch:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.roll:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.scale:GetChecked(),
    Dta.ui.windowCopyPaste.copyPaste.xOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.yOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.zOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.yawOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.pitchOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.rollOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.scaleOffset:GetText(),
    Dta.ui.windowCopyPaste.copyPaste.multiplyOffsets:GetChecked())
  end

end

--------------------------------------
--COPY ITEM
--------------------------------------

function Dta.copa.copyItemAttributes()
  if #Dta.selectedItems == 1 then
    Dta.clipboard = {
      type = Dta.selectedItems[1].type,
      x = Dta.selectedItems[1].coordX,
      y = Dta.selectedItems[1].coordY,
      z = Dta.selectedItems[1].coordZ,
      yaw = Dta.selectedItems[1].yaw,
      pitch = Dta.selectedItems[1].pitch,
      roll = Dta.selectedItems[1].roll,
      scale = Dta.selectedItems[1].scale,
    }
  elseif #Dta.selectedItems > 1 then
    print("Copy feature only works on single item selections at the moment")
  else
    print("Please select an item in order to copy attributes")
  end
end

--------------------------------------
--PASTE SELECTED ITEMS
--------------------------------------

function Dta.copa.pasteMultipleItemAttributes(x, y, z, yaw, pitch, roll, scale, xOffset, yOffset, zOffset, yawOffset, pitchOffset, rollOffset, scaleOffset, multiplyOffset)
  if #Dta.selectedItems > 0 then

    if xOffset == nil or xOffset == "" or not x then xOffset = 0 end
    if yOffset == nil or yOffset == "" or not y then yOffset = 0 end
    if zOffset == nil or zOffset == "" or not z then zOffset = 0 end
    if yawOffset == nil or yawOffset == "" or not yaw then yawOffset = 0 end
    if pitchOffset == nil or pitchOffset == ""  or not pitch then pitchOffset = 0 end
    if rollOffset == nil or rollOffset == "" or not roll then rollOffset = 0 end
    if scaleOffset == nil or scaleOffset == "" or not scale then scaleOffset = 0 end

    if not tonumber(xOffset) or
       not tonumber(yOffset) or
       not tonumber(zOffset) or
       not tonumber(yawOffset) or
       not tonumber(pitchOffset) or
       not tonumber(rollOffset) or
       not tonumber(scaleOffset) then
      print("Please enter numeric values only")
      return
    end

    if Dta.clipboard.type == nil then
        print("Please copy an item before pasting")
    else
        for k, details in pairs(Dta.selectedItems) do
            if multiplyOffset then
                Dta.copa.pasteItemAttributes(k, x, y, z, yaw, pitch, roll, scale, k*tonumber(xOffset), k*tonumber(yOffset), k*tonumber(zOffset), k*tonumber(yawOffset), k*tonumber(pitchOffset), k*tonumber(rollOffset), k*tonumber(scaleOffset))
            else
                Dta.copa.pasteItemAttributes(k, x, y, z, yaw, pitch, roll, scale, xOffset, yOffset, zOffset, yawOffset, pitchOffset, rollOffset, scaleOffset)
            end
        end
    end

  end
end

function Dta.copa.pasteItemAttributes(index, x, y, z, yaw, pitch, roll, scale, xOffset, yOffset, zOffset, yawOffset, pitchOffset, rollOffset, scaleOffset)
  if Dta.selectedItems[index] ~= nil and Dta.clipboard ~= nil then

    local FlickerReduc = Dta.FlickerReduc
    local newPlacement = {}
      if Dta.FlickerOffset then
          if x then newPlacement.coordX = Dta.clipboard.x + xOffset + FlickerReduc end
          if y then newPlacement.coordY = Dta.clipboard.y + yOffset + FlickerReduc end
          if z then newPlacement.coordZ = Dta.clipboard.z + zOffset + FlickerReduc end
          Dta.FlickerOffset = false
      else
          if x then newPlacement.coordX = Dta.clipboard.x + xOffset - FlickerReduc end
          if y then newPlacement.coordY = Dta.clipboard.y + yOffset - FlickerReduc end
          if z then newPlacement.coordZ = Dta.clipboard.z + zOffset - FlickerReduc end
          Dta.FlickerOffset = true
      end
    if yaw then newPlacement.yaw = Dta.clipboard.yaw + Dta.items.toRadians(yawOffset) end
    if pitch then newPlacement.pitch = Dta.clipboard.pitch + Dta.items.toRadians(pitchOffset) end
    if roll then newPlacement.roll = Dta.clipboard.roll + Dta.items.toRadians(rollOffset) end
    if scale then newPlacement.scale = Dta.clipboard.scale + scaleOffset end

    Dta.items.QueueCoPa(Dta.selectedItems[index].id, newPlacement.coordX, newPlacement.coordY, newPlacement.coordZ, newPlacement.pitch, newPlacement.roll, newPlacement.yaw, newPlacement.scale)

  elseif Dta.selectedItems[index] == nil then
    print("Please select an item in order to paste attributes")
  else
    print("You must copy an item's attributes before pasting")
  end
end

--------------------------------------
--PASTE NEW ITEMS
--------------------------------------

function Dta.copa.pasteMultipleNewItemAttributes(x, y, z, yaw, pitch, roll, scale, xOffset, yOffset, zOffset, yawOffset, pitchOffset, rollOffset, scaleOffset, multiplyOffset, NewItem, NewItemNr)
  if not NewItem then
    ItemNr = 0
    print("Please check the checkbox if you want to place a new item or use the paste button if you try to paste a existing item")
  elseif NewItemNr == nil or NewItemNr =="" then
    ItemNr = 1
  else
    ItemNr = tonumber(NewItemNr)
  end

  if ItemNr > 0 then

    if xOffset == nil or xOffset == "" or not x then xOffset = 0 end
    if yOffset == nil or yOffset == "" or not y then yOffset = 0 end
    if zOffset == nil or zOffset == "" or not z then zOffset = 0 end
    if yawOffset == nil or yawOffset == "" or not yaw then yawOffset = 0 end
    if pitchOffset == nil or pitchOffset == ""  or not pitch then pitchOffset = 0 end
    if rollOffset == nil or rollOffset == "" or not roll then rollOffset = 0 end
    if scaleOffset == nil or scaleOffset == "" or not scale then scaleOffset = 0 end

    if not tonumber(xOffset) or
       not tonumber(yOffset) or
       not tonumber(zOffset) or
       not tonumber(yawOffset) or
       not tonumber(pitchOffset) or
       not tonumber(rollOffset) or
       not tonumber(ItemNr) or
       not tonumber(scaleOffset) then
      print("Please enter numeric values only")
      return
    end


    if Dta.ui.windowCopyPaste.copyPaste.Bags:GetChecked() then
        local items = Inspect.Item.Detail(Inspect.Item.List(Utility.Item.Slot.Inventory()))
        local NewItemID = Dta.clipboard.type
        if NewItemID == nil then
            print("Please copy an item before pasting.")
            return
        end

        for _, details in pairs(items) do
            if details.type == NewItemID then
                Dta.copa.CountedItems = Dta.copa.CountedItems + details.stack
            end
        end
        if  Dta.copa.CountedItems < ItemNr then
            print("You only have " .. Dta.copa.CountedItems .. ", Please lower the items you want to paste or try Bank.")
            Dta.copa.CountedItems = 0
            return
        end

    elseif Dta.ui.windowCopyPaste.copyPaste.Bank:GetChecked() then
        local items = Inspect.Item.Detail(Inspect.Item.List(Utility.Item.Slot.Bank()))
        local NewItemID = Dta.clipboard.type
        if NewItemID == nil then
            print("Please copy an item before pasting.")
            return
        end

        for _, details in pairs(items) do
            if details.type == NewItemID then
                Dta.copa.CountedItems = Dta.copa.CountedItems + details.stack
            end
        end
        if  Dta.copa.CountedItems < ItemNr then
            print("You only have " .. Dta.copa.CountedItems .. ", Please lower the items you want to paste or try Bags.")
            Dta.copa.CountedItems = 0
            return
        end

    elseif Dta.ui.windowCopyPaste.copyPaste.Both:GetChecked() then
        local items = Inspect.Item.Detail(Inspect.Item.List())
        local NewItemID = Dta.clipboard.type
        if NewItemID == nil then
            print("Please copy an item before pasting.")
            return
        end

        for _, details in pairs(items) do
            if details.type == NewItemID then
                Dta.copa.CountedItems = Dta.copa.CountedItems + details.stack
            end
        end
        if  Dta.copa.CountedItems < ItemNr then
            print("You only have " .. Dta.copa.CountedItems .. ", Please lower the items you want to paste.")
            Dta.copa.CountedItems = 0
            return
        end
    end

    Dta.ItemsToPaste = ItemNr
    Dta.FinishedPaste = false
    Dta.PastingItems = true
    Dta.items.DeselectAll()

    if multiplyOffset then
        Dta.copa.Co_PlaceItem = coroutine.create(function ()
            for k = 1, ItemNr, 1 do
                Dta.copa.pasteNewItemAttributes(k, x, y, z, yaw, pitch, roll, scale, k*tonumber(xOffset), k*tonumber(yOffset), k*tonumber(zOffset), k*tonumber(yawOffset), k*tonumber(pitchOffset), k*tonumber(rollOffset), k*tonumber(scaleOffset))
                if k < ItemNr then
                    Dta.Copa_Co_Active = true
                else
                    Dta.Copa_Co_Active = false
                end
                coroutine.yield()
            end
        end)
        coroutine.resume(Dta.copa.Co_PlaceItem)
        Dta.copa.CountedItems = 0
    else
        Dta.copa.pasteNewItemAttributes(k, x, y, z, yaw, pitch, roll, scale, xOffset, yOffset, zOffset, yawOffset, pitchOffset, rollOffset, scaleOffset)
    end

  end
end

function Dta.copa.pasteNewItemAttributes(index, x, y, z, yaw, pitch, roll, scale, xOffset, yOffset, zOffset, yawOffset, pitchOffset, rollOffset, scaleOffset)
  if Dta.clipboard ~= nil then

    local FlickerReduc = Dta.FlickerReduc
    local newPlacement = {}
      if Dta.FlickerOffset then
          if x then newPlacement.coordX = Dta.clipboard.x + xOffset + FlickerReduc end
          if y then newPlacement.coordY = Dta.clipboard.y + yOffset + FlickerReduc end
          if z then newPlacement.coordZ = Dta.clipboard.z + zOffset + FlickerReduc end
          Dta.FlickerOffset = false
      else
          if x then newPlacement.coordX = Dta.clipboard.x + xOffset - FlickerReduc end
          if y then newPlacement.coordY = Dta.clipboard.y + yOffset - FlickerReduc end
          if z then newPlacement.coordZ = Dta.clipboard.z + zOffset - FlickerReduc end
          Dta.FlickerOffset = true
      end
    if yaw then newPlacement.yaw = Dta.clipboard.yaw + Dta.items.toRadians(yawOffset) end
    if pitch then newPlacement.pitch = Dta.clipboard.pitch + Dta.items.toRadians(pitchOffset) end
    if roll then newPlacement.roll = Dta.clipboard.roll + Dta.items.toRadians(rollOffset) end
    if scale then newPlacement.scale = Dta.clipboard.scale + scaleOffset end

    local NewItemID = Dta.clipboard.type


    if Dta.ui.windowCopyPaste.copyPaste.Bags:GetChecked() then
        local items = Inspect.Item.List(Utility.Item.Slot.Inventory())
        for slot, id in pairs(items) do
            if id ~= false then
                local data = Inspect.Item.Detail(id)
                if data.type == NewItemID then
                    Command.Dimension.Layout.Place(id, newPlacement)
                    return
                end
            end
        end
    elseif Dta.ui.windowCopyPaste.copyPaste.Bank:GetChecked() then
        local items = Inspect.Item.List(Utility.Item.Slot.Bank())
        for slot, id in pairs(items) do
            if id ~= false then
                local data = Inspect.Item.Detail(id)
                if data.type == NewItemID then
                    Command.Dimension.Layout.Place(id, newPlacement)
                    return
                end
            end
        end
    elseif Dta.ui.windowCopyPaste.copyPaste.Both:GetChecked() then
        local items = Inspect.Item.List()
        for slot, id in pairs(items) do
            if id ~= false then
                local data = Inspect.Item.Detail(id)
                if data.type == NewItemID then
                    Command.Dimension.Layout.Place(id, newPlacement)
                    return
                end
            end
        end
    end

    dump("You don't seem to have enough of this item here, Please try another option.")

  elseif Dta.selectedItems[index] == nil then
    print("Please select an item in order to paste attributes")
  else
    print("You must copy an item's attributes before pasting")
  end
end
