local Dta = select(2, ...)

Dta.Replacement = {}

function Dta.Replacement.GetItemForSkin(item_type, skin)
	local details = Dta.Defaults.ItemDB[item_type]
	if not details or not details.shape then
		return nil
	end
	return skin[details.shape]
end

--Dta.Replacement.Skins = {}

function Dta.Replacement.loadSkins()
	local items = {}
	for name, _ in pairs(Dta.Defaults.Skins) do
		table.insert(items, name)
	end
	return items
end

-- fonts need plank, tile and pole, not all skins have them:
function Dta.Replacement.loadAlphabetSkins()
	local items = {}
	for name, skin in pairs(Dta.Defaults.Skins) do
		if skin.tile and skin.plank and skin.pole then
			table.insert(items, name)
		end
	end
	return items
end
