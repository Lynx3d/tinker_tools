Dta.scale = {}

--------------------------------------
--SCALE BUTTON HANDLERS
--------------------------------------

function Dta.scale.modifyScaleModeAbsChanged()
  if Dta.ui.windowScale.modifyScale.modeAbs:GetChecked() then
    Dta.ui.windowScale.modifyScale.modeRel:SetChecked(false)
  elseif not Dta.ui.windowScale.modifyScale.modeRel:GetChecked() then
    Dta.ui.windowScale.modifyScale.modeAbs:SetChecked(true)
  end
end

function Dta.scale.modifyScaleModeRelChanged()
  if Dta.ui.windowScale.modifyScale.modeRel:GetChecked() then
    Dta.ui.windowScale.modifyScale.modeAbs:SetChecked(false)
  elseif not Dta.ui.windowScale.modifyScale.modeAbs:GetChecked() then
    Dta.ui.windowScale.modifyScale.modeRel:SetChecked(true)
  end
end

function Dta.scale.modifyScaleButtonClicked()
  Dta.scale.setItemScales(Dta.ui.windowScale.modifyScale.scale:GetText(),
                   Dta.ui.windowScale.modifyScale.modeRel:GetChecked())
end

function Dta.scale.modifyScaleResetButtonClicked()
  Dta.scale.resetItemScales()
end

--------------------------------------
--SCALE ITEMS
--------------------------------------

function Dta.scale.setItemScales(scale, relative)
  if Dta.losa.tableLength(Dta.selectedItems) > 0 then
    Dta.scale.Co_setScale = coroutine.create(function()
      for k, details in pairs(Dta.selectedItems) do
        Dta.scale.setItemScale(k, scale, relative)
      end
    end)
    coroutine.resume(Dta.scale.Co_setScale)
  end
end

--------------------------------------
--RESET SCALE TO 1
--------------------------------------

function Dta.scale.resetItemScales()
  if Dta.losa.tableLength(Dta.selectedItems) > 0 then
    Dta.scale.Co_ResetScale = coroutine.create(function ()
      for k, details in pairs(Dta.selectedItems) do
        Dta.scale.setItemScale(k, 1, false)
      end
    end)
    coroutine.resume(Dta.scale.Co_ResetScale)
  end
end

--------------------------------------
--SCALE AND RESET SCALE HANDLER
--------------------------------------

function Dta.scale.setItemScale(index, scale, relative)
  if Dta.selectedItems[index] ~= nil then
    local newPlacement = {}
    if relative ~= nil and relative then
      if scale == nil or scale == "" then scale = 0 end

      if not tonumber(scale) then
        print(Lang[Dta.Language].Prints.NumbersOnly)
        return
      end

      newPlacement = Dta.selectedItems[index].scale + tonumber(scale)
    else -- absolute positioning
      if scale == nil or scale == "" then scale = Dta.selectedItems[index].scale end

      if not tonumber(scale) then
        print(Lang[Dta.Language].Prints.NumbersOnly)
        return
      end

      newPlacement = tonumber(scale)
    end
    Dta.items.QueueScale(Dta.selectedItems[index].id, newPlacement)
  else
    print(Lang[Dta.Language].Prints.ModifyScale)
  end
end
