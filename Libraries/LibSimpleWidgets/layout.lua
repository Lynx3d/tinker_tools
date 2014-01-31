local SPACING = 8
local COLUMNS = 2
local TOP_LABEL_SPACING = 3


-- Helper Functions

local function addUpdateLabel(frame, id, config)
  local parent = frame:GetParent()
  if config.labelPos == "top" then
    local label = frame.label or UI.CreateFrame("Text", "widgetLabel_" .. id, parent)
    label:SetText(config.label)
    label:SetPoint("TOPLEFT", parent, "TOPLEFT")
    frame:ClearAll()
    if frame.ResizeToFit then
      frame:ResizeToFit()
    end
    parent:SetHeight(label:GetHeight() + frame:GetHeight() + TOP_LABEL_SPACING)
    frame:ClearWidth()
    frame:ClearHeight()
    frame:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, TOP_LABEL_SPACING)
    frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT")
    frame:SetVisible(true)
    frame.label = label
  elseif config.labelPos == "left" then
    local label = frame.label or UI.CreateFrame("Text", "widgetLabel_" .. id, parent)
    label:SetText(config.label..": ")
    label:SetPoint("TOPLEFT", parent, "TOPLEFT")
    frame:ClearAll()
    if frame.ResizeToFit then
      frame:ResizeToFit()
    end
    parent:SetHeight(frame:GetHeight())
    frame:ClearWidth()
    frame:ClearHeight()
    frame:SetPoint("TOPLEFT", label, "TOPRIGHT", 0, 0)
    frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT")
    frame:SetVisible(true)
    frame.label = label
  else
    if parent.label then
      parent.label:SetVisible(false)
    end
    frame:ClearAll()
    parent:SetHeight(frame:GetHeight())
    frame:SetAllPoints(parent)
  end
end

local function updateButton(widget, id, config, parent)
  widget:SetText(config.label)
  widget.Event.LeftClick = function(self)
    if config.func then config.func() end
  end
end

local function createButton(id, config, parent)
  local widget = UI.CreateFrame("RiftButton", "Button_" .. id, parent)
  updateButton(widget, id, config, parent)
  return widget
end

local function updateTextfield(widget, id, config, parent)
  local textfield = widget.textfield

  addUpdateLabel(textfield, id, config)

  textfield:SetBackgroundColor(0, 0, 0, 1)
  Library.LibSimpleWidgets.SetBorder(textfield, 1, 0.5, 0.5, 0.5, 1)
  if config.get then
    textfield.value = config.get()
  end
  textfield:SetText(textfield.value)
  local function InvokeSet()
    if config.set and textfield.value ~= textfield:GetText() then
      textfield.value = textfield:GetText()
      config.set(textfield.value)
    end
  end
  textfield.Event.KeyFocusLoss = InvokeSet()
  textfield.Event.KeyDown = function(self, key)
    if string.byte(key) == 13 then
      InvokeSet()
    end
  end
end

local function createTextfield(id, config, parent)
  local widget = UI.CreateFrame("Frame", "TextfieldContainer_" .. id, parent)
  local textfield = UI.CreateFrame("RiftTextfield", "Textfield_" .. id, widget)

  widget.textfield = textfield

  updateTextfield(widget, id, config, parent)

  return widget
end

local function updateHorizontalRule(widget, id, config, parent)
  -- nothing to do
end

local function createHorizontalRule(id, config, parent)
  local widget = UI.CreateFrame("Frame", "HorizontalRule_" .. id, parent)
  widget:SetBackgroundColor(0.5, 0.5, 0.5, 1)
  widget:SetHeight(2)
  return widget
end

local function updateCheckbox(widget, id, config, parent)
  widget.Event.CheckboxChange = nil
  if config.labelPos then
    widget:SetLabelPos(config.labelPos)
  end
  if config.get then
    widget:SetChecked(config.get())
  end
  widget:SetText(config.label)
  if config.labelFontSize then
    widget:SetFontSize(config.labelFontSize)
  end
  widget.Event.CheckboxChange = function(self)
    if config.set then
      config.set(widget:GetChecked())
    end
  end
end

local function createCheckbox(id, config, parent)
  local widget = UI.CreateFrame("SimpleCheckbox", "Checkbox_" .. id, parent)
  updateCheckbox(widget, id, config, parent)
  return widget
end

local function updateSelect(widget, id, config, parent)
  local select = widget.select

  addUpdateLabel(select, id, config)

  select.Event.ItemSelect = nil
  select:SetBorder(1, 0.5, 0.5, 0.5, 1)
  local items = config.items
  if items then
    if type(items) == "function" then
      items = items()
    end
    local values = config.values
    if values then
      if type(values) == "function" then
        values = values()
      end
    end
    select:SetItems(items, values)
  end
  if config.get then
    select:SetSelectedItem(config.get())
  elseif config.getvalue then
    select:SetSelectedValue(config.getvalue())
  elseif config.getindex then
    select:SetSelectedIndex(config.getindex())
  end
  select.Event.ItemSelect = function(self, item, value, index)
    if config.set then
      config.set(item, value, index)
    end
  end
end

local function createSelect(id, config, parent)
  local widget = UI.CreateFrame("Frame", "SelectContainer_" .. id, parent)
  local select = UI.CreateFrame("SimpleSelect", "Select_" .. id, widget)

  widget.select = select

  updateSelect(widget, id, config, parent)

  return widget
end

local function updateSlider(widget, id, config, parent)
  local slider = widget.slider
  
  addUpdateLabel(slider, id, config)

  slider.Event.SliderRelease = nil
  local min = config.min or 1
  local max = config.max or 100
  slider:SetRange(min, max)
  if config.get then
    slider:SetPosition(config.get())
  else
    slider:SetPosition(min)
  end
  slider.value = slider:GetPosition()
  if config.editable ~= nil then
    slider:SetEditable(config.editable)
  else
    slider:SetEditable(true)
  end
  slider.Event.SliderRelease = function(self)
    local value = slider:GetPosition()
    if slider.value ~= value then
      slider.value = value
      if config.set then
        config.set(value)
      end
    end
  end
end

local function createSlider(id, config, parent)
  local widget = UI.CreateFrame("Frame", "SliderContainer_" .. id, parent)
  local slider = UI.CreateFrame("SimpleSlider", "Slider_" .. id, widget)

  widget.slider = slider

  updateSlider(widget, id, config, parent)

  return widget
end

local function updateSpacer(widget, id, config, parent)
  -- nothing to do
end

local function createSpacer(id, config, parent)
  local widget = UI.CreateFrame("Frame", "Spacer_" .. id, parent)
  widget:SetHeight(25)
  return widget
end

local widgetConstructors = {
  button = createButton,
  textfield = createTextfield,
  hrule = createHorizontalRule,
  checkbox = createCheckbox,
  select = createSelect,
  slider = createSlider,
  spacer = createSpacer,
}

local widgetUpdators = {
  button = updateButton,
  textfield = updateTextfield,
  hrule = updateHorizontalRule,
  checkbox = updateCheckbox,
  select = updateSelect,
  slider = updateSlider,
  spacer = updateSpacer,
}

local widgetResizable = {
  button = false,
  textfield = true,
  hrule = true,
  checkbox = true,
  select = true,
  slider = true,
  spacer = true,
}

local widgetDefaultWidthSetting = {
  button = "default",
  textfield = "column",
  hrule = "full",
  checkbox = "column",
  select = "column",
  slider = "column",
  spacer = "column",
}

local widgetSpacing = {
  button = SPACING,
  textfield = SPACING,
  hrule = SPACING,
  checkbox = SPACING,
  select = SPACING,
  slider = SPACING,
  spacer = 0,
}

local widgetTopCompensation = {
  button = -6,
  textfield = 0,
  hrule = 0,
  checkbox = 0,
  select = 0,
  slider = 0,
  spacer = 0,
}

local widgetLeftCompensation = {
  button = -4,
  textfield = 0,
  hrule = 0,
  checkbox = 0,
  select = 0,
  slider = 0,
  spacer = 0,
}

local widgetHeightCompensation = {
  button = -12,
  textfield = 0,
  hrule = 0,
  checkbox = 0,
  select = 0,
  slider = 0,
  spacer = 0,
}

local widgetWidthCompensation = {
  button = 0,
  textfield = 0,
  hrule = 0,
  checkbox = 0,
  select = 0,
  slider = 0,
  spacer = 0,
}

local function calcMaxHeight(widgets)
  local maxHeight = 0
  for i, rw in ipairs(widgets) do
    maxHeight = math.max(maxHeight, rw:GetHeight() + widgetHeightCompensation[rw.LSW_WidgetType])
  end
  return maxHeight
end


-- Constructor Function

function Library.LibSimpleWidgets.Layout(configTable, parent)
  parent.layoutWidgets = parent.layoutWidgets or {}

  -- hide widgets which are no longer in the configTable
  for k, v in pairs(parent.layoutWidgets) do
    if not configTable[k] then
      v:SetVisible(false)
    end
  end

  -- layout widgets
  local nextX = 0
  local nextY = 0
  local columnWidth = parent:GetWidth() / COLUMNS
  local rowWidgets = {}

  -- validate configTable and sort entries according to their order attribute
  local sortedIDs = {}
  for id, config in pairs(configTable) do
    if not id then
      error("nil widget id")
      return
    end
    if not config then
      error("no config for widget id "..id)
      return
    end
    if not config.type then
      error("no type for widget id "..id)
      return
    end
    table.insert(sortedIDs, id)
  end

  table.sort(sortedIDs, function(a,b)
    local orderA = configTable[a].order or 100
    local orderB = configTable[b].order or 100
    return orderA < orderB
  end)

  -- widgets at the top have a higher layer than widgets further down
  -- so that things like dropdown popup frames overlay widgets below them
  local layer = #sortedIDs

  local tooltip = parent.layoutTooltip

  -- create or update widgets
  for _, id in ipairs(sortedIDs) do
    local config = configTable[id]
    local constructor = widgetConstructors[config.type]
    local updator = widgetUpdators[config.type]
    if not constructor then
      error("invalid widget type: "..config.type)
      return
    end

    -- lookup or create widget
    local widget = parent.layoutWidgets[id]
    if widget then
      updator(widget, id, config, parent)
    else
      widget = constructor(id, config, parent)
    end
    widget:SetLayer(layer)
    widget.LSW_WidgetType = config.type

    local spacing = widgetSpacing[config.type]
    local nextWidth = columnWidth

    local widthSetting = widgetDefaultWidthSetting[config.type]
    if widgetResizable[config.type] and config.width then
      widthSetting = config.width
    end

    local widthCompensation = widgetWidthCompensation[config.type]

    -- calculate widget width
    if widthSetting == "default" then
      -- leave widget at default width
    elseif widthSetting == "column" then
      if nextX + nextWidth >= parent:GetWidth() then
        widget:SetWidth(columnWidth - spacing*2 + widthCompensation)
      else
        widget:SetWidth(columnWidth - spacing + widthCompensation)
      end
    elseif widthSetting == "full" then
      if nextX > 0 then
        nextX = 0
        local maxHeight = calcMaxHeight(rowWidgets)
        nextY = nextY + maxHeight + SPACING
        rowWidgets = {}
      end
      widget:SetWidth(parent:GetWidth() - spacing*2 + widthCompensation)
      nextWidth = parent:GetWidth()
    end

    local topCompensation = widgetTopCompensation[config.type]
    local leftCompensation = widgetLeftCompensation[config.type]
    widget:SetPoint("TOPLEFT", parent, "TOPLEFT", nextX + spacing + leftCompensation, nextY + spacing + topCompensation)

    if config.tooltipText ~= nil then
      if tooltip == nil then
        tooltip = UI.CreateFrame("SimpleTooltip", "LayoutTooltip", parent)
        parent.layoutTooltip = tooltip
      end
      tooltip:InjectEvents(widget, function() return config.tooltipText end)
    end

    table.insert(rowWidgets, widget)
    parent.layoutWidgets[id] = widget

    -- next column or row
    nextX = nextX + nextWidth
    if nextX >= parent:GetWidth() then
      nextX = 0
      local maxHeight = calcMaxHeight(rowWidgets)
      nextY = nextY + maxHeight + SPACING
      rowWidgets = {}
    end

    layer = layer - 1
  end

end
