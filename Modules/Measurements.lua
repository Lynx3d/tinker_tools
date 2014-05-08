Dta.measurements = {}

Dta.measurements.TypeIndex = {
		"Poles",
		"Cubes",
		"Tiles",
		"Planks",
		"Rectangles"
	}

Dta.measurements.OrientationIndex = {
		"Default",
		"Yaw 90",
		"Pitch 90",
		"Roll 90"
	}

function Dta.measurements.CalculationsClicked()
    local Size = Dta.ui.windowMeasurements.Measurements.Size:GetText()
    local Type = Dta.ui.windowMeasurements.Measurements.TypeLoad:GetSelectedItem()
    local Orientation = Dta.ui.windowMeasurements.Measurements.OrientationLoad:GetSelectedItem()

    if Type == nil or Type == "" then
        return print(Lang[Dta.Language].Prints.SelectType)
    end

    if Orientation == nil or Orientation == "" then
        return print(Lang[Dta.Language].Prints.SelectOrientation)
    end

    if Size == nil or Size == "" then
        return print(Lang[Dta.Language].Prints.TypeSize)
    else
        local NrSize = tonumber(Size)
        if Type == "Poles" then
            if NrSize > 12 or NrSize < 0.25 then
                return print(Lang[Dta.Language].Prints.SizeC)
            else
                if Orientation == "Default" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                elseif Orientation == "Yaw 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                elseif Orientation == "Pitch 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize ,4)))
                elseif Orientation == "Roll 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/8 ,4)))
                end
            end
        elseif Type == "Cubes" then
            if NrSize > 5 or NrSize < 0.25 then
                return print(Lang[Dta.Language].Prints.SizeA)
            else
                if Orientation == "Default" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                elseif Orientation == "Yaw 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                elseif Orientation == "Pitch 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                elseif Orientation == "Roll 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/10*7.5 ,4)))
                end
            end
        elseif Type == "Tiles" then
            if NrSize > 12 or NrSize < 0.25 then
                return print(Lang[Dta.Language].Prints.SizeC)
            else
                if Orientation == "Default" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                elseif Orientation == "Yaw 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                elseif Orientation == "Pitch 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                elseif Orientation == "Roll 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                end
            end
        elseif Type == "Planks" then
            if NrSize > 6 or NrSize < 0.25 then
                return print(Lang[Dta.Language].Prints.SizeB)
            else
                if Orientation == "Default" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize*2.25 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/20 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/4 ,4)))
                elseif Orientation == "Yaw 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/4 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/20 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize*2.25 ,4)))
                elseif Orientation == "Pitch 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize*2.25 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/4 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/20 ,4)))
                elseif Orientation == "Roll 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/20 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize*2.25 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/4 ,4)))
                end
            end
        elseif Type == "Rectangles" then
            if NrSize > 12 or NrSize < 0.25 then
                return print(Lang[Dta.Language].Prints.SizeC)
            else
                if Orientation == "Default" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize*1.125 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                elseif Orientation == "Yaw 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize*1.125 ,4)))
                elseif Orientation == "Pitch 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize*1.125 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                elseif Orientation == "Roll 90" then
                    Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(NrSize/100*3.75 ,4)))
                    Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(NrSize*1.125 ,4)))
                    Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(NrSize/4*3 ,4)))
                end
            end
        end
    end


end
