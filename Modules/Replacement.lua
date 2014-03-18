Dta.Replacement = {}

Dta.Replacement.Skins = {}

Dta.Replacement.TileName = ""
Dta.Replacement.TileType = ""
Dta.Replacement.RectangleName = ""
Dta.Replacement.RectangleType = ""
Dta.Replacement.PlankName = ""
Dta.Replacement.PlankType = ""
Dta.Replacement.CubeName = ""
Dta.Replacement.CubeType = ""
Dta.Replacement.TriangleName = ""
Dta.Replacement.TriangleType = ""
Dta.Replacement.PoleName = ""
Dta.Replacement.PoleType = ""

function Dta.Replacement.loadSkins()
    if Dta.Replacement.Skins == nil or Dta.Replacement.Skins == {} then
        return {}
    else
        local items = {}
        for name, _ in pairs(Dta.Replacement.Skins) do
            table.insert(items, name)
        end
        return items
    end
end

function Dta.Replacement.TableSetSkins(Table)
    for k, details in pairs(Table) do
        local Skins = details.name
        if string.find(Skins, "Tile") then
            Dta.Replacement.TileName = details.name
            Dta.Replacement.TileType = details.type
        end
        if string.find(Skins, "Rectangle") then
            Dta.Replacement.RectangleName = details.name
            Dta.Replacement.RectangleType = details.type
        end
        if string.find(Skins, "Plank") then
            Dta.Replacement.PlankName = details.name
            Dta.Replacement.PlankType = details.type
        end
        if string.find(Skins, "Cube") then
            Dta.Replacement.CubeName = details.name
            Dta.Replacement.CubeType = details.type
        end
        if string.find(Skins, "Triangle") then
            Dta.Replacement.TriangleName = details.name
            Dta.Replacement.TriangleType = details.type
        end
        if string.find(Skins, "Pole") then
            Dta.Replacement.PoleName = details.name
            Dta.Replacement.PoleType = details.type
        end
    end
end
