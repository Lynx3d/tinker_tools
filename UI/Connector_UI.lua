local Dta = select(2, ...)

local ConnectorWindowSettings = {
	WIDTH = 305,
	HEIGHT = 250,
	POS_X = "ConnectorwindowPosX",
	POS_Y = "ConnectorwindowPosY"
}

function Dta.ui.buildConnectorWindow()
	local x = Dta.settings.get("ConnectorwindowPosX") or 0
	local y = Dta.settings.get("ConnectorwindowPosY") or 0

	local newWindow = Dta.ui.Window.Create("ConnectorWindow",
							Dta.ui.context,
							"<Connector>",
							ConnectorWindowSettings.WIDTH,
							ConnectorWindowSettings.HEIGHT,
							x, y, true, true,
							Dta.ui.hideConnectorWindow,
							Dta.ui.WindowMoved
							)
	newWindow.settings = ConnectorWindowSettings
	local winContent = newWindow.content

	-- Connector Controls --
	newWindow.corner = {}
	local cornerX = {12, 70, 128, 140, 140, 140, 128, 70, 12, 0, 0, 0}
	local cornerY = {0, 0, 0, 12, 70, 128, 140, 140, 140, 128, 70, 12}
	for i = 1,12 do
		local checkbox = UI.CreateFrame("RiftCheckbox", "ConCorner" .. i, winContent)
		checkbox:SetPoint("TOPLEFT", winContent, "TOPLEFT", 10 + cornerX[i], cornerY[i])
		checkbox.link = i
		checkbox:EventAttach(Event.UI.Checkbox.Change, Dta.Connector.LinkChanged, "connector_link_changed")
		newWindow.corner[i] = checkbox
	end
	newWindow.corner[Dta.Connector.link]:SetChecked(true)
	newWindow.shapeDisplay = UI.CreateFrame("Canvas", "ConShapeDisplay", winContent)
	newWindow.shapeDisplay:SetPoint("TOPLEFT", winContent, "TOPLEFT", 10+17, 19)
	newWindow.shapeDisplay:SetPoint("BOTTOMRIGHT", winContent, "TOPLEFT", 10+138, 140)
	newWindow.shapeDisplay:SetBackgroundColor(0.07, 0.01, 0, 0.5) -- test
	--
	newWindow.shapeAxisH = UI.CreateFrame("Frame", "ConShapeXAxis", winContent)
	newWindow.shapeAxisH:SetPoint("TOPLEFT", winContent, "TOPLEFT", 10+17, 19+60)
	newWindow.shapeAxisH:SetPoint("BOTTOMRIGHT", winContent, "TOPLEFT", 10+138, 19+61)
	newWindow.shapeAxisH:SetBackgroundColor(0.9, 0.9, 0.9, 0.4)
	newWindow.shapeAxisH:SetLayer(10)

	newWindow.shapeAxisV = UI.CreateFrame("Frame", "ConShapeXAxis", winContent)
	newWindow.shapeAxisV:SetPoint("TOPLEFT", winContent, "TOPLEFT", 10+17+60, 19)
	newWindow.shapeAxisV:SetPoint("BOTTOMRIGHT", winContent, "TOPLEFT", 10+17+61, 140)
	newWindow.shapeAxisV:SetBackgroundColor(0.9, 0.9, 0.9, 0.4)
	newWindow.shapeAxisV:SetLayer(10)
	--
	newWindow.axisLabelH = Dta.ui.createText("ConnectorAxisLabelH", newWindow.shapeAxisH, 107, 3, "-", 14)
	newWindow.axisLabelV = Dta.ui.createText("ConnectorAxisLabelV", newWindow.shapeAxisV, 5, 3, "-", 14)
	newWindow.angleLabel = Dta.ui.createText("ConnectorAngleLabel", winContent, 170, 15, "<angle>", 14)
	newWindow.angle = Dta.ui.createTextfield("ConnectorAngle", winContent, 245, 15, 50)
	newWindow.angleLabel = Dta.ui.createText("ConnectorAxisLabel", winContent, 170, 40, "<axis>", 14)
	newWindow.axis = Dta.ui.createDropdown("ConnectorAxisSelect", winContent, 245, 40, 50)
	newWindow.axis:SetItems({"x", "y", "z"})
	newWindow.axis:SetSelectedIndex(1)
	newWindow.axis.Event.ItemSelect = Dta.ui.ConnectorAxisChanged
	Dta.ui.ConnectorSetAxis(newWindow, 1)

	newWindow.repeatToggle = Dta.ui.createCheckbox("ConnectorRepeatCbx", winContent, 10, 165, "<repeat>", false, nil, Dta.ui.ConnectorRepeatChanged)
	newWindow.repeatCount = Dta.ui.createTextfield("ConnectorRepeatCount", winContent, 170, 165, 40)
	newWindow.repeatCount:SetVisible(false)

	newWindow.pasteBtn = Dta.ui.createButton("connectorApplyBtn", winContent, 10, 210, nil, nil,
											"<paste>", nil, Dta.Connector.ConnectClicked)
	return newWindow
end

function Dta.ui.showConnectorWindow(conWindow)
	conWindow:SetVisible(true)
	conWindow.axis:SetEnabled(true)
	Dta.ui.ConnectorUpdateUI()
	Command.Event.Attach(Event[Dta.AddonID].Selection, Dta.ui.ConnectorUpdateUI, "TT_Connector_Update")
end

function Dta.ui.hideConnectorWindow(conWindow)
	conWindow:SetVisible(false)
	conWindow.axis:SetEnabled(false)
	Command.Event.Detach(Event[Dta.AddonID].Selection, Dta.ui.ConnectorUpdateUI, "TT_Connector_Update")
end

function Dta.ui.ConnectorDrawShape(canvas, shapeIdx, axis)
	local dimensions = Dta.measurements.Dimensions[shapeIdx]
	local center = Dta.Connector.Center[shapeIdx]
	local axisMap = Dta.Connector.AxisMap[axis]
	local z_down = Dta.Connector.GetExtent(dimensions, center, axisMap[1], -1)
	local z_up = Dta.Connector.GetExtent(dimensions, center, axisMap[1], 1)
	local left = Dta.Connector.GetExtent(dimensions, center, axisMap[2], -1)
	local right = Dta.Connector.GetExtent(dimensions, center, axisMap[2], 1)
	local bottom = Dta.Connector.GetExtent(dimensions, center, axisMap[3], -1)
	local top = Dta.Connector.GetExtent(dimensions, center, axisMap[3], 1)

	local cRad = 0.5 * canvas:GetWidth()
	local scale =  cRad * 0.95 / math.max(-left, -bottom, -z_down, right, top, z_up)
	local shapePath

	if shapeIdx == 3 and axis == 2 then -- pole, y axis
		shapePath = { {x = math.floor(cRad + left * scale), y = math.floor(cRad)},
					  {x = math.floor(cRad), y = math.floor(cRad - top * scale),
						xControl = math.floor(cRad + left * scale), yControl = math.floor(cRad - top * scale)},
					  {x = math.floor(cRad + right * scale), y = math.floor(cRad),
						xControl = math.floor(cRad + right * scale), yControl = math.floor(cRad - top * scale)},
					  {x = math.floor(cRad), y = math.floor(cRad - bottom * scale),
						xControl = math.floor(cRad + right * scale), yControl = math.floor(cRad - bottom * scale)},
					  {x = math.floor(cRad + left * scale), y = math.floor(cRad),
						xControl = math.floor(cRad + left* scale), yControl = math.floor(cRad - bottom * scale)},
					}
	else
		shapePath = {	{x = math.floor(cRad + left * scale), y = math.floor(cRad - top * scale)},
						{x = math.floor(cRad + right * scale), y = math.floor(cRad - top * scale)},
						{x = math.floor(cRad + right * scale), y = math.floor(cRad - bottom * scale)},
						{x = math.floor(cRad + left * scale), y = math.floor(cRad - bottom * scale)},
						{x = math.floor(cRad + left * scale), y = math.floor(cRad - top * scale)} }
	end

	canvas:SetShape(shapePath, {type = "solid", r=0.07, g=0.01, b=0, a=0.6}, {r=0.65, g=0.58, b=0.4, a=1, thickness=1})
end

-- TODO: turn into event handler when temp button is gone
function Dta.ui.ConnectorUpdateUI()
	local con_ui = Dta.Tools.Connector.window
	local available = false
	local shapeIdx, axis
	if Dta.selectionCount == 1 then
		-- TODO: make sure an axis is selected
		axis = con_ui.axis:GetSelectedIndex() or 1
		local _, details = next(Dta.selectedItems)
		local entry = Dta.Defaults.ItemDB[details.type]
		if entry and entry.shape then
			shapeIdx = Dta.Connector.ShapeIndex[entry.shape]
			if shapeIdx then
				available = true
			end
		end
	end
	con_ui.pasteBtn:SetEnabled(available)
	if available then
		Dta.Connector.currentShapeIdx = shapeIdx
		Dta.ui.ConnectorDrawShape(con_ui.shapeDisplay, shapeIdx, axis)
	else
		Dta.Connector.currentShapeIdx = nil
		con_ui.shapeDisplay:SetShape(nil, nil, nil)
	end
end

local axisColor = {
	x = {1, 0, 0},
	y = {0, 1, 0},
	z = {0, 0.75, 1}
}

function Dta.ui.ConnectorSetAxis(con_ui, axis)
	local axisMap = Dta.Connector.AxisMap[axis]
	con_ui.axisLabelH:SetText(axisMap[2]:upper())
	con_ui.axisLabelH:SetFontColor(unpack(axisColor[axisMap[2]]))
	con_ui.axisLabelV:SetText(axisMap[3]:upper())
	con_ui.axisLabelV:SetFontColor(unpack(axisColor[axisMap[3]]))

	if Dta.Connector.currentShapeIdx then
		Dta.ui.ConnectorDrawShape(con_ui.shapeDisplay, Dta.Connector.currentShapeIdx, axis)
	end
end

function Dta.ui.ConnectorAxisChanged(self, axisName, _, axis)
	if not axis then return end

	local con_ui = Dta.Tools.Connector.window
	Dta.ui.ConnectorSetAxis(con_ui, axis)
end

function Dta.ui.ConnectorRepeatChanged(self)
	local con_ui = Dta.Tools.Connector.window
	con_ui.repeatCount:SetVisible(self:GetChecked())
end

Dta.RegisterTool("Connector", Dta.ui.buildConnectorWindow, Dta.ui.showConnectorWindow, Dta.ui.hideConnectorWindow)
