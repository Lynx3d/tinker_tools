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
