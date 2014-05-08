Dta.rotate = {}

--------------------------------------
--ROTATE BUTTON HANDLERS
--------------------------------------

function Dta.rotate.modifyRotationModeAbsChanged()
  if Dta.ui.windowRotate.modifyRotation.modeAbs:GetChecked() then
    Dta.ui.windowRotate.modifyRotation.modeRel:SetChecked(false)
  elseif not Dta.ui.windowRotate.modifyRotation.modeRel:GetChecked() then
    Dta.ui.windowRotate.modifyRotation.modeAbs:SetChecked(true)
  end
end

function Dta.rotate.modifyRotationModeRelChanged()
  if Dta.ui.windowRotate.modifyRotation.modeRel:GetChecked() then
    Dta.ui.windowRotate.modifyRotation.modeAbs:SetChecked(false)
  elseif not Dta.ui.windowRotate.modifyRotation.modeAbs:GetChecked() then
    Dta.ui.windowRotate.modifyRotation.modeRel:SetChecked(true)
  end
end

function Dta.rotate.modifyRotationButtonClicked()
  Dta.rotate.setItemRotations(Dta.ui.windowRotate.modifyRotation.yaw:GetText(),
                      Dta.ui.windowRotate.modifyRotation.pitch:GetText(),
                      Dta.ui.windowRotate.modifyRotation.roll:GetText(),
                      Dta.ui.windowRotate.modifyRotation.modeRel:GetChecked())
end

function Dta.rotate.modifyRotationResetButtonClicked()
  Dta.rotate.resetItemRotations()
end

--------------------------------------
--ROTATE ITEMS (NO GROUP ROTATION YET)
--------------------------------------

function Dta.rotate.setItemRotations(yaw, pitch, roll, relative)
  if Dta.losa.tableLength(Dta.selectedItems) > 0 then
    Dta.rotate.Co_RotateItem = coroutine.create(function ()
        for k, details in pairs(Dta.selectedItems) do
            Dta.rotate.setItemRotation(k, yaw, pitch, roll, relative)
        end
    end)
    coroutine.resume(Dta.rotate.Co_RotateItem)
  end
end

--------------------------------------
--RESET ITEM ROTATION
--------------------------------------

function Dta.rotate.resetItemRotations()
  if Dta.losa.tableLength(Dta.selectedItems) > 0 then
    Dta.rotate.Co_RotateItemReset = coroutine.create(function ()
        for k, details in pairs(Dta.selectedItems) do
            Dta.rotate.setItemRotation(k, 0, 0, 0, false)
        end
    end)
    coroutine.resume(Dta.rotate.Co_RotateItemReset)
  end
end

--------------------------------------
--ROTATE AND RESET HANDLER
--------------------------------------

function Dta.rotate.setItemRotation(index, yaw, pitch, roll, relative)
  if Dta.selectedItems[index] ~= nil then
    local newPlacement = {}
    if relative ~= nil and relative then
      if yaw == nil or yaw == "" or not yaw then yaw = 0 end
      if pitch == nil or pitch == "" or not pitch then pitch = 0 end
      if roll == nil or roll == "" or not roll then roll = 0 end

      if not tonumber(yaw) or
         not tonumber(pitch) or
         not tonumber(roll) then
        print(Lang[Dta.Language].Prints.NumbersOnly)
        return
      end

      yaw = Dta.items.toRadians(yaw)
      pitch = Dta.items.toRadians(pitch)
      roll = Dta.items.toRadians(roll)

      newPlacement = {RotPitch = Dta.selectedItems[index].pitch + tonumber(pitch), RotYaw = Dta.selectedItems[index].yaw + tonumber(yaw), RotRoll = Dta.selectedItems[index].roll + tonumber(roll)}
    else

      if yaw == nil or yaw == "" or not yaw then yaw = Dta.selectedItems[index].yaw end
      if pitch == nil or pitch == "" or not pitch then pitch = Dta.selectedItems[index].pitch end
      if roll == nil or roll == "" or not roll then roll = Dta.selectedItems[index].roll end

      if not tonumber(yaw) or
         not tonumber(pitch) or
         not tonumber(roll) then
        print(Lang[Dta.Language].Prints.NumbersOnly)
        return
      end

      yaw = Dta.items.toRadians(yaw)
      pitch = Dta.items.toRadians(pitch)
      roll = Dta.items.toRadians(roll)

      newPlacement = {RotPitch = tonumber(pitch), RotYaw = tonumber(yaw), RotRoll = tonumber(roll)}
    end

    Dta.items.QueueRotate(Dta.selectedItems[index].id, newPlacement.RotPitch, newPlacement.RotRoll, newPlacement.RotYaw)
  else
    print(Lang[Dta.Language].Prints.ModifyRotation)
  end
end
