local Dta = select(2, ...)

Dta.Replacement = {}

function Dta.Replacement.GetItemForSkin(item_type, skin)
	local details = Dta.Defaults.ItemDB[item_type]
	if not details or not details.shape then
		return nil
	end
	return skin[details.shape]
end

local function sortSkins(skins, translation)
	table.sort(skins)
	local value_table = {}
	for index, name in pairs(skins) do
		value_table[index] = translation[name]
	end
	return skins, value_table
end

function Dta.Replacement.loadSkins(category)
	local skins, translation = {}, {}
	local skin_table = category and Dta.Defaults.Skin_Category_Index[category] or Dta.Defaults.Skins
	for name, data in pairs(skin_table) do
		local name_local = data[Dta.Language] or name
		table.insert(skins, name_local)
		translation[name_local] = name
	end
	return sortSkins(skins, translation)
end

-- fonts need plank, tile and pole, not all skins have them:
function Dta.Replacement.loadAlphabetSkins()
	local skins, translation = {}, {}
	for name, skin in pairs(Dta.Defaults.Skins) do
		if skin.tile and skin.plank and skin.pole then
			local name_local = skin[Dta.Language] or name
			table.insert(skins, name_local)
			translation[name_local] = name
		end
	end
	return sortSkins(skins, translation)
end

function Dta.Replacement.loadSkinCategories()
	local categories, categories_loc = {}, {}
	for idx, category in pairs(Dta.Defaults.Skin_Categories) do
		categories[idx] = category.name
		categories_loc[idx] = category[Dta.Language] or category.name
	end
	return categories_loc, categories
end

function Dta.Replacement.FilterOldChanged()
	local reskinWindow = Dta.ui.windowReskin
	local category = reskinWindow.oldFilterSelect:GetSelectedValue()
	reskinWindow.oldSkinSelect:SetItems(Dta.Replacement.loadSkins(category))
end

function Dta.Replacement.FilterNewChanged()
	local reskinWindow = Dta.ui.windowReskin
	local category = reskinWindow.newFilterSelect:GetSelectedValue()
	reskinWindow.newSkinSelect:SetItems(Dta.Replacement.loadSkins(category))
end

function Dta.Replacement.ReplaceClicked()
	local settings = {}
	local reskinWindow = Dta.ui.windowReskin
	local old_skin = reskinWindow.oldSkinSelect:GetSelectedValue()
	local new_skin = reskinWindow.newSkinSelect:GetSelectedValue()

	if not old_skin or not Dta.Defaults.Skins[old_skin] or
	   not new_skin or not Dta.Defaults.Skins[new_skin] then
		Dta.CPrint(Dta.Locale.Prints.SelectSkin)
		return
	end
	settings.old_skin_lookup = {}
	for shape, details in pairs(Dta.Defaults.Skins[old_skin]) do
		if type(details) == "table" then -- skip the language entries
			settings.old_skin_lookup[details.type] = shape
		end
	end
	--dump(settings.old_skin_lookup) -- TEMP
	settings.skin_data = Dta.Defaults.Skins[new_skin]
	settings.replace_shape = {
		tile = reskinWindow.tile:GetChecked(),
		rectangle = reskinWindow.rectangle:GetChecked(),
		triangle = reskinWindow.triangle:GetChecked(),
		plank = reskinWindow.plank:GetChecked(),
		cube = reskinWindow.cube:GetChecked(),
		sphere = reskinWindow.sphere:GetChecked(),
		pole = reskinWindow.pole:GetChecked(),
		disc = reskinWindow.disc:GetChecked(),
	}

	Dta.Replacement.ReplaceClipboard(settings)
end

function Dta.Replacement.ReplaceClipboard(settings)
	local Locale = Dta.Locale
	if not Dta.clipboard.items then
		Dta.CPrint(Locale.Prints.ClipboardEmpty)
		return
	end
	local stats = {}
	for i, details in pairs(Dta.clipboard.items) do
		local shape = settings.old_skin_lookup[details.type]
		if shape and settings.replace_shape[shape] and settings.skin_data[shape] then
			details.type = settings.skin_data[shape].type
			details.name = settings.skin_data[shape].name
			stats[shape] = (stats[shape] or 0) + 1
			--Dta.CPrint("replaced:" .. details.name)
		end
	end
	-- print statistics:
	Dta.CPrint(Locale.Prints.Summary)
	if stats.tile then 		Dta.CPrint(Locale.Text.Tile .. string.format(": %i", stats.tile)) end
	if stats.rectangle then	Dta.CPrint(Locale.Text.Rectangle .. string.format(": %i", stats.rectangle)) end
	if stats.triangle then	Dta.CPrint(Locale.Text.Triangle .. string.format(": %i", stats.triangle)) end
	if stats.plank then		Dta.CPrint(Locale.Text.Plank .. string.format(": %i", stats.plank)) end
	if stats.cube then		Dta.CPrint(Locale.Text.Cube .. string.format(": %i", stats.cube)) end
	if stats.sphere then	Dta.CPrint(Locale.Text.Sphere .. string.format(": %i", stats.sphere)) end
	if stats.pole then		Dta.CPrint(Locale.Text.Pole .. string.format(": %i", stats.pole)) end
	if stats.disc then		Dta.CPrint(Locale.Text.Disc .. string.format(": %i", stats.disc)) end
end
