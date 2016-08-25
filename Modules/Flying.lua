local Dta = select(2, ...)

Dta.flying = {}

--------------------------------------
-- TRIBAL MAGIC BUTTON HANDLERS
--------------------------------------

function Dta.flying.PitchWheelBack(slider, hEvent)
	local min, max = slider:GetRange()
	local pos = slider:GetPosition()
	if pos > min then
		slider:SetPosition(pos - 1)
	end
end

function Dta.flying.PitchWheelForward(slider, hEvent)
	local min, max = slider:GetRange()
	local pos = slider:GetPosition()
	if pos < max then
		slider:SetPosition(pos + 1)
	end
end

function Dta.flying.SliderMoved(slider)
	local newVal = slider:GetPosition()
	Dta.ui.windowFlying.pitchLabels[Dta.flying.pitchPosition+5]:SetFontColor(1, 1, 1)
	Dta.ui.windowFlying.pitchLabels[newVal+5]:SetFontColor(107/255, 203/255, 189/255)
	Dta.flying.pitchPosition = newVal
	Dta.desiredPitch = -newVal/8
end

function Dta.flying.PlaceFlying()
	local items = Inspect.Item.List(Utility.Item.Slot.Inventory())
	for slot, id in pairs(items) do
		if id ~= false then
			local data = Inspect.Item.Detail(id)
			if data and data.type == Dta.FlyingType then
				Dta.ui.windowFlying.DFlying.placeButton:SetEnabled(false)
				Dta.ui.windowFlying.DFlying.pickupButton:SetEnabled(true)
				Dta.waitingForCarpet = true
				Command.Dimension.Layout.Place(id, {scale=1})
				return
			end
		end
	end
	Dta.CPrint(Dta.Locale.Prints.NoRoundTable)
end

function Dta.flying.PickUpFlying()
	if Dta.carpetId then
		Command.Dimension.Layout.Pickup(Dta.carpetId)
		Dta.flying.FlyingRemoved()
	end
end

--------------------------------------
-- OTHER CALLBACKS
--------------------------------------

function Dta.flying.FlyingRemoved()
	Dta.ui.windowFlying.DFlying.placeButton:SetEnabled(true)
	Dta.ui.windowFlying.DFlying.pickupButton:SetEnabled(false)
	Dta.carpetId = false
end

function Dta.flying.UpdateCarpet()
	local playerDetails = Inspect.Unit.Detail("player")
	if playerDetails.coordX == nil then -- unit availability ~= "full" => loading screen
		Dta.flying.FlyingRemoved()
		return
	end

	-- don't move carpet if we're less than 2cm from old pos in all directions
	if not Dta.lastPlayerPos or
		math.abs(Dta.lastPlayerPos.coordX - playerDetails.coordX) > 0.02 or
		math.abs(Dta.lastPlayerPos.coordY - playerDetails.coordY) > 0.02 or
		math.abs(Dta.lastPlayerPos.coordZ - playerDetails.coordZ) > 0.02
	then
		local spacing = 0.3
		local xDiff = playerDetails.coordX - Dta.savePosNew.coordX
		--local yDiff = playerDetails.coordY - Dta.savePosNew.coordY
		local zDiff = playerDetails.coordZ - Dta.savePosNew.coordZ

		local hDiff = math.sqrt(xDiff * xDiff + zDiff * zDiff)

		local xDiffOld = playerDetails.coordX - Dta.savePosOld.coordX
		--local yDiffOld = playerDetails.coordY - Dta.savePosOld.coordY
		local zDiffOld = playerDetails.coordZ - Dta.savePosOld.coordZ

		local hDiffOld = math.sqrt(xDiffOld * xDiffOld + zDiffOld * zDiffOld)

		local weightN = math.min(hDiff, spacing) / spacing
		local weightO = 1.0 - weightN

		local dirX = xDiff * weightN + xDiffOld * weightO
		local dirZ = zDiff * weightN + zDiffOld * weightO
		local dirLen = math.sqrt(dirX * dirX + dirZ * dirZ)

		-- TODO: if dirLen << spacing: inbetween savePosOld and savePosNew, rotation is somewhat random

		-- finally have a direction
		local update = {}
		update["coordX"] = playerDetails["coordX"]
		update["coordY"] = playerDetails["coordY"] - Dta.magicYOffset/math.cos(Dta.desiredPitch * 1.05)
		update["coordZ"] = playerDetails["coordZ"]
		update["pitch"] = 0
		update["yaw"] = math.atan2(dirZ, dirX)
		update["roll"] = Dta.desiredPitch

		Command.Dimension.Layout.Place(Dta.carpetId, update)
		--Dta.lastCarpetPos = update
		Dta.lastPlayerPos.coordX = playerDetails.coordX
		Dta.lastPlayerPos.coordY = playerDetails.coordY
		Dta.lastPlayerPos.coordZ = playerDetails.coordZ

		-- if we moved more than <spacing> horizontally, save new position
		if hDiff > spacing then
			local posNew = Dta.savePosOld
			Dta.savePosOld = Dta.savePosNew
			posNew.coordX = playerDetails.coordX
			posNew.coordY = playerDetails.coordY
			posNew.coordZ = playerDetails.coordZ
			Dta.savePosNew = posNew
		end
	end
end
