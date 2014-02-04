Dta.items = {}

--------------------------------------
--QUEUE FUNCTIONS
--------------------------------------

function Dta.items.QueueScale(id, amount)
  table.insert(Dta.pendingActions, {op="scale", amount=amount, id=id})
end

function Dta.items.QueueMove(id, x, y, z)
  table.insert(Dta.pendingActions, {op="move", x=x, y=y, z=z, id=id})
end

function Dta.items.QueueRotate(id, pitch, roll, yaw)
  table.insert(Dta.pendingActions, {op="rotate", pitch=pitch, yaw=yaw, roll=roll, id=id})
end

function Dta.items.QueueSelect(id)
  table.insert(Dta.pendingActions, {op="select", id=id})
end

function Dta.items.QueueCoPa(id, x, y, z, pitch, roll, yaw, amount)
  table.insert(Dta.pendingActions, {op="copa", x=x, y=y, z=z, pitch=pitch, roll=roll, yaw=yaw, amount=amount, id=id})
end

function Dta.items.QueueLoad(id, x, y, z, pitch, roll, yaw, amount)
  table.insert(Dta.pendingActions, {op="losa", x=x, y=y, z=z, pitch=pitch, roll=roll, yaw=yaw, amount=amount, id=id})
end

function Dta.items.QueueSelection(id)
  table.insert(Dta.SelectionQueue, {op="select",  id=id})
end

function Dta.items.QueueDeselection(id)
  table.insert(Dta.SelectionQueue, {op="deselect",  id=id})
end
--------------------------------------
--ITEM UPDATE
--------------------------------------

function Dta.items.updateItemDetails()
  if Dta.ui.windowtest ~= nil then
    if #Dta.selectedItems > 0 then
      if #Dta.selectedItems > 1 then
        Dta.ui.windowtest.itemDetails.icon:SetTexture("Dimtools", "textures/multiple.png")
        Dta.ui.windowtest.itemDetails.name:SetText("Multiple items selected")
        local cp = Dta.items.getCentralPoint(Dta.selectedItems)
        Dta.ui.windowtest.itemDetails.x:SetText(tostring(Dta.items.round(cp.x,4)))
        Dta.ui.windowtest.itemDetails.y:SetText(tostring(Dta.items.round(cp.y,4)))
        Dta.ui.windowtest.itemDetails.z:SetText(tostring(Dta.items.round(cp.z,4)))
        Dta.ui.windowtest.itemDetails.yaw:SetText("-")
        Dta.ui.windowtest.itemDetails.pitch:SetText("-")
        Dta.ui.windowtest.itemDetails.roll:SetText("-")
        Dta.ui.windowtest.itemDetails.scale:SetText("-")
        if Dta.ui.windowMove then Dta.ui.windowMove.modifyPosition.moveAsGrp:SetVisible(true) end
      else
        if Dta.selectedItems[1].icon == "" then
          Dta.ui.windowtest.itemDetails.icon:SetTexture("Dimtools", "textures/default.png")
        else
          Dta.ui.windowtest.itemDetails.icon:SetTexture("Rift", Dta.selectedItems[1].icon)
        end
        Dta.ui.windowtest.itemDetails.name:SetText(tostring(Dta.selectedItems[1].name))
        Dta.ui.windowtest.itemDetails.x:SetText(tostring(Dta.items.round(Dta.selectedItems[1].coordX,4)))
        Dta.ui.windowtest.itemDetails.y:SetText(tostring(Dta.items.round(Dta.selectedItems[1].coordY,4)))
        Dta.ui.windowtest.itemDetails.z:SetText(tostring(Dta.items.round(Dta.selectedItems[1].coordZ,4)))
        Dta.ui.windowtest.itemDetails.yaw:SetText(tostring(Dta.items.round(Dta.items.toDegrees(Dta.selectedItems[1].yaw),4)))
        Dta.ui.windowtest.itemDetails.pitch:SetText(tostring(Dta.items.round(Dta.items.toDegrees(Dta.selectedItems[1].pitch),4)))
        Dta.ui.windowtest.itemDetails.roll:SetText(tostring(Dta.items.round(Dta.items.toDegrees(Dta.selectedItems[1].roll),4)))
        Dta.ui.windowtest.itemDetails.scale:SetText(tostring(Dta.items.round(Dta.selectedItems[1].scale,4)))
        if Dta.ui.windowMove then Dta.ui.windowMove.modifyPosition.moveAsGrp:SetVisible(false) end
      end
    elseif Dta.ui.needsReset then
      Dta.ui.windowtest.itemDetails.icon:SetTexture("Dimtools", "textures/blank.png")
      Dta.ui.windowtest.itemDetails.name:SetText("Nothing selected")
      Dta.ui.windowtest.itemDetails.x:SetText("-")
      Dta.ui.windowtest.itemDetails.y:SetText("-")
      Dta.ui.windowtest.itemDetails.z:SetText("-")
      Dta.ui.windowtest.itemDetails.yaw:SetText("-")
      Dta.ui.windowtest.itemDetails.pitch:SetText("-")
      Dta.ui.windowtest.itemDetails.roll:SetText("-")
      Dta.ui.windowtest.itemDetails.scale:SetText("-")
      if Dta.ui.windowMove then Dta.ui.windowMove.modifyPosition.moveAsGrp:SetVisible(false) end
      Dta.ui.needsReset = false
    end
  end
end

function Dta.items.updateSelection()

    if Dta.ui ~= nil and Dta.ui.active then

        Dta.AllItems = Inspect.Dimension.Layout.List()
        Dta.selectedItems = {}
        for id,crate in pairs(Dta.AllItems) do
          if not crate then
            local detail = Inspect.Dimension.Layout.Detail(id)
                if detail ~= nil then
                    if detail.selected then
                        table.insert(Dta.selectedItems, detail)
                    end
                end
          end
        end

        if #Dta.selectedItems < 1 then
            Dta.ui.needsReset = true
            Dta.items.updateItemDetails()
        else
            Dta.items.updateItemDetails()
        end


    end

end

function Dta.items.DeselectAll()
    Dta.AllItems = Inspect.Dimension.Layout.List()
    Dta.selectedItems = {}
    for id,crate in pairs(Dta.AllItems) do
        if not crate then
            local detail = Inspect.Dimension.Layout.Detail(id)
            if detail ~= nil then
                if detail.selected then
                    Dta.items.QueueDeselection(id)
                end
            end
        end
    end
end

function Dta.items.round(num, dp)
  return tonumber(string.format("%." .. (dp or 0) .. "f", num))
end

function Dta.items.toRadians(num)
  return math.rad(num)
end

function Dta.items.toDegrees(num)
  return math.deg(num)
end

--------------------------------------
--GET CENTRAL POINT
--------------------------------------
function Dta.items.getCentralPoint(itemsList)
  local itemsList = itemsList or {}
  if #itemsList > 0 then
    local centralPoint = {x = 0, y = 0, z = 0}
    for k, details in pairs(itemsList) do
      centralPoint.x = centralPoint.x + details.coordX
      centralPoint.y = centralPoint.y + details.coordY
      centralPoint.z = centralPoint.z + details.coordZ
    end
    for k, v in pairs(centralPoint) do centralPoint[k] = v / #itemsList end
    return centralPoint
  end
end
