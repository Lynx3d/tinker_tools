Dta.flying = {}

--------------------------------------
--SCALE BUTTON HANDLERS
--------------------------------------

function Dta.flying.AdjustPitch(newVal)
	for i = 1, 9, 1 do
		if i == newVal then
		    Dta.pitchButtons[i]:SetEnabled(false)
		else
		    Dta.pitchButtons[i]:SetEnabled(true)
		end
	end
	Dta.desiredPitch = (-5+newVal)/10
end

function Dta.flying.PlaceFlying()
	local items = Inspect.Item.List(Utility.Item.Slot.Inventory())
	for slot, id in pairs(items) do
	    if id ~= false then
			local data = Inspect.Item.Detail(id)
			if data.type == Dta.FlyingType then
				Dta.ui.windowFlying.DFlying.placeButton:SetEnabled(false)
				Dta.ui.windowFlying.DFlying.pickupButton:SetEnabled(true)
				Dta.waitingForCarpet = true
				Command.Dimension.Layout.Place(id, {scale=1})
				return

			end
		end
    end
    dump(Lang[Dta.Language].Prints.NoRoundTable)
end

function Dta.flying.PickUpFlying()
	Dta.ui.windowFlying.DFlying.placeButton:SetEnabled(true)
	Dta.ui.windowFlying.DFlying.pickupButton:SetEnabled(false)

	if Dta.carpetId ~= "d" then
		Command.Dimension.Layout.Pickup(Dta.carpetId)
		Dta.carpetId = "d"
	end
end

function Dta.flying.dimensionItemAdded(hEvent, dimensionItem)
	if Dta.waitingForCarpet == true then
	    for id, value in pairs(dimensionItem) do
			local data = Inspect.Dimension.Layout.Detail(id)
			if data ~= nil then
				if data.type == rugType then
					Dta.carpetId = id
					Dta.waitingForCarpet = false

					Dta.magicYOffset = Inspect.Unit.Detail("player").coordY - Inspect.Dimension.Layout.Detail(id).coordY
					Dta.magicYOffset = magicYOffset + 0.47
				end
			end
		end
	end
end
