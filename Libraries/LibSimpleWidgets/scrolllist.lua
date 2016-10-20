-- Private Functions

local function UpdateScrollbarVisiblity(self)
  self.scrollbar:SetVisible(self:GetVisible() and self.showScrollbar and self.scrollbarNeeded)
end

local function SetupItemFrame(self, itemFrame, i)
  if itemFrame.index == i then
    return
  end

  itemFrame.index = i

  local indent = 0
  local fontSize = self.fontSize
  local fontColor = {1, 1, 1}
  local backgroundColor
  if self.itemSelected[i] then
    backgroundColor = self.selectionBgColor
  else
    backgroundColor = {0, 0, 0, 0}
  end

  local level = self.levels[i]
  if level ~= nil then
    indent = self.indentSize * (level-1)
    fontSize = self.levelFontSizes[level] or fontSize
    fontColor = self.levelFontColors[level] or fontColor
    backgroundColor = self.levelBackgroundColors[level] or backgroundColor
  end

  local item = self.items[i]

  if item == nil then
    item = ""
  end

  itemFrame:SetText(item)
  itemFrame:SetPoint("LEFT", self, "LEFT", indent, nil)
  itemFrame:SetFontSize(fontSize)
  itemFrame:SetFontColor(unpack(fontColor))
  itemFrame:SetVisible(true)
  itemFrame.bgFrame:SetBackgroundColor(unpack(backgroundColor))
  --itemFrame.bgFrame:SetBackgroundColor((i % 10) / 10, (i % 10) / 10, (i % 10) / 10, 1)
  itemFrame.bgFrame:SetVisible(true)
end

local function GetFrameRelTop(frame)
  local layout, position, offset = frame:ReadPoint("TOP")
  return offset
end

local function PositionContent(self, offset)
  if #self.itemFrames > 0 then
    local diff = offset - self.offset

    local topFrame = self.itemFrames[1]
    local itemHeight = topFrame:GetHeight()

    if math.abs(diff) > self:GetHeight() then
      local index = 1 + math.floor(offset / itemHeight)
      for _, f in ipairs(self.itemFrames) do
        SetupItemFrame(self, f, index)
        index = index + 1
      end
      topFrame:SetPoint("TOP", self, "TOP", nil, -(offset % itemHeight))
    elseif diff > 0 then
      topFrame:SetPoint("TOP", self, "TOP", nil, GetFrameRelTop(topFrame) - diff)
      while GetFrameRelTop(self.itemFrames[1]) < -itemHeight do
        local f = table.remove(self.itemFrames, 1)
        self.itemFrames[1]:SetPoint("TOP", self, "TOP", nil, GetFrameRelTop(f) + itemHeight)
        local bottomFrame = self.itemFrames[#self.itemFrames]
        f:SetPoint("TOP", bottomFrame, "BOTTOM")
        SetupItemFrame(self, f, bottomFrame.index + 1)
        table.insert(self.itemFrames, f)
      end
    elseif diff < 0 then
      topFrame:SetPoint("TOP", self, "TOP", nil, GetFrameRelTop(topFrame) - diff)
      while GetFrameRelTop(self.itemFrames[1]) > 0 do
        local f = table.remove(self.itemFrames)
        f:SetPoint("TOP", self, "TOP", nil, GetFrameRelTop(self.itemFrames[1]) - itemHeight)
        self.itemFrames[1]:SetPoint("TOP", f, "BOTTOM")
        SetupItemFrame(self, f, self.itemFrames[1].index - 1)
        table.insert(self.itemFrames, 1, f)
      end
    end
  end

  self.offset = offset
end

local function PositionScrollbar(self)
  if self.scrollbar:GetVisible() then
    self.scrollbar:SetPosition(self.offset)
  end
end

local function UpdateSelection(self)
  for _, itemFrame in ipairs(self.itemFrames) do
    local index = itemFrame.index
    if self.itemSelected[index] then
      itemFrame.bgFrame:SetBackgroundColor(unpack(self.selectionBgColor))
    else
      local level = self.levels[index]
      local backgroundColor = {0, 0, 0, 0}
      if level then
        backgroundColor = self.levelBackgroundColors[level] or backgroundColor
      end
      itemFrame.bgFrame:SetBackgroundColor(unpack(backgroundColor))
    end
  end
end

local function ItemIsSelectable(self, index)
  local selectable = self.levelSelectable[self.levels[index]]
  return selectable == nil or selectable
end

local function WheelForward(self)
  if self.contentHeight <= self:GetHeight() then
    return
  end

  local interval = self.scrollInterval * self.itemFrames[1]:GetHeight()
  PositionContent(self, math.max(0, self.offset - interval))
  PositionScrollbar(self)
end

local function WheelBack(self)
  if self.contentHeight <= self:GetHeight() then
    return
  end

  local _, maxOffset = self.scrollbar:GetRange()
  local interval = self.scrollInterval * self.itemFrames[1]:GetHeight()
  PositionContent(self, math.min(maxOffset, self.offset + interval))
  PositionScrollbar(self)
end

local function ItemClick(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  local index = self.index
  if widget.Event.ItemClick then
    local item = widget.items[index]
    local value = widget.values[index]
    widget.Event.ItemClick(item, value, index)
  end
  if not ItemIsSelectable(widget, index) then return end
  if widget.selectionMode == "single" then
    widget:SetSelectedIndex(index)
  elseif widget.selectionMode == "multi" then
    if widget.itemSelected[index] then
      widget:RemoveSelectedIndex(index)
    else
      widget:AddSelectedIndex(index)
    end
  end
end

local function ItemMouseIn(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  local index = self.index
  if not ItemIsSelectable(widget, index) then return end
  if not widget.itemSelected[index] then
    self.bgFrame:SetBackgroundColor(0.3, 0.3, 0.3, 1)
  end
end

local function ItemMouseOut(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  local index = self.index
  if not ItemIsSelectable(widget, index) then return end
  if not widget.itemSelected[index] then
    local level = widget.levels[index]
    local backgroundColor = {0, 0, 0, 0}
    if level then
      backgroundColor = widget.levelBackgroundColors[level] or backgroundColor
    end
    self.bgFrame:SetBackgroundColor(unpack(backgroundColor))
  end
end

local function AcquireItemFrame(self)
  if #self.itemFramePool > 0 then
    return table.remove(self.itemFramePool)
  else
    local i = #self.itemFramePool + 1
    local itemFrame = UI.CreateFrame("Text", self:GetName().."Item"..i, self)
    itemFrame:SetBackgroundColor(0, 0, 0, 0)
    local bgFrame = UI.CreateFrame("Frame", self:GetName().."ItemBG"..i, self)
    bgFrame:SetLayer(itemFrame:GetLayer()-1)
    bgFrame:SetPoint("TOP", itemFrame, "TOP")
    bgFrame:SetPoint("BOTTOM", itemFrame, "BOTTOM")
    bgFrame:SetPoint("LEFT", itemFrame, "LEFT")
    bgFrame:SetPoint("RIGHT", itemFrame, "RIGHT")
    bgFrame.Event.LeftClick = function() ItemClick(itemFrame) end
    bgFrame.Event.MouseIn = function() ItemMouseIn(itemFrame) end
    bgFrame.Event.MouseOut = function() ItemMouseOut(itemFrame) end
    itemFrame.bgFrame = bgFrame
    return itemFrame
  end
end

local function ReleaseItemFrame(self, itemFrame)
  itemFrame:SetVisible(false)
  itemFrame.bgFrame:SetVisible(false)
  itemFrame.index = nil
  table.insert(self.itemFramePool, itemFrame)
end

local function SetupItemFrames(self)
  for _, itemFrame in ipairs(self.itemFrames) do
    ReleaseItemFrame(self, itemFrame)
  end
  self.itemFrames = {}

  if #self.items == 0 then
    self.contentHeight = 0
    return
  end

  local f = AcquireItemFrame(self)
  f:SetText("X")
  local itemHeight = f:GetHeight()
  ReleaseItemFrame(self, f)

  local height = self:GetHeight()
  local prevItemFrame
  local i = 1

  while height > -itemHeight and i <= #self.items do
    local itemFrame = AcquireItemFrame(self)
    table.insert(self.itemFrames, itemFrame)

    if prevItemFrame then
      itemFrame:SetPoint("TOP", prevItemFrame, "BOTTOM")
    else
      itemFrame:SetPoint("TOP", self, "TOP")
    end
    itemFrame:SetPoint("RIGHT", self, "RIGHT")

    SetupItemFrame(self, itemFrame, i)

    height = height - itemFrame:GetHeight()
    prevItemFrame = itemFrame
    i = i + 1
  end

  if prevItemFrame ~= nil then
    self.contentHeight = prevItemFrame:GetHeight() * #self.items
  else
    self.contentHeight = 0
  end
end

local function SetupScrolling(self)
  local maxOffset = self:GetMaxOffset()
  local offset = self.offset

  if maxOffset == 0 then
    offset = 0
    self.scrollbarNeeded = false
  else
    if offset > maxOffset then
      offset = maxOffset
    end
    self.scrollbarNeeded = true
    self.scrollbar:SetRange(0, maxOffset)
    self.scrollbar:SetThickness(math.max(self:GetHeight() / self.contentHeight * maxOffset, maxOffset / 10))
  end

  UpdateScrollbarVisiblity(self)
  PositionContent(self, offset)
  PositionScrollbar(self)

  local itemRightOffset = 0
  if self.scrollbar:GetVisible() then
    itemRightOffset = -self.scrollbar:GetWidth()
  end

  for _, itemFrame in ipairs(self.itemFrames) do
    itemFrame:SetPoint("RIGHT", self, "RIGHT", itemRightOffset, nil)
  end
end

local function ScrollViewResized(self)
  if self.lastHeight ~= self:GetHeight() then
    SetupItemFrames(self)
    SetupScrolling(self)
    self.lastHeight = self:GetHeight()
  end
end

local function ScrollbarChange(self)
  PositionContent(self:GetParent(), math.floor(self:GetPosition()))
end


-- Public ScrollView Functions

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self, width, r, g, b, a)
end

local function SetBackgroundColor(self, r, g, b, a)
  self.bg:SetBackgroundColor(r, g, b, a)
end

local function SetVisible(self, visible)
  assert(type(visible) == "boolean", "param 1 must be a boolean!")

  self:SavedSetVisible(visible)
  UpdateScrollbarVisiblity(self)
end

local function GetScrollInterval(self)
  return self.scrollInterval
end

local function SetScrollInterval(self, interval)
  assert(type(interval) == "number", "param 1 must be a number!")

  self.scrollInterval = interval
end

local function GetShowScrollbar(self)
  return self.showScrollbar
end

local function SetShowScrollbar(self, show)
  assert(type(show) == "boolean", "param 1 must be a boolean!")

  self.showScrollbar = show
  UpdateScrollbarVisiblity(self)
end

local function GetScrollbarWidth(self)
  return self.scrollbar:GetWidth()
end

local function SetScrollbarWidth(self, width)
  assert(type(width) == "number", "param 1 must be a number!")

  self.scrollbar:SetWidth(width)
end

local function GetScrollOffset(self)
  return self.offset
end

local function ScrollToOffset(self, offset)
  assert(type(offset) == "number", "param 1 must be a number!")
  local min, max = self.scrollbar:GetRange()
  assert(offset >= min and offset <= max, "param 1 must be in the range ["..min..","..max.."]")

  PositionContent(self, offset)
  PositionScrollbar(self)
end

local function GetMaxOffset(self)
  return math.max(0, self.contentHeight - self:GetHeight())
end

local function EnsureIndexVisible(self, index)
  assert(type(index) == "number", "param 1 must be a number!")
  assert(index >= 1 and index <= #self.items, "param 1 must be in the range [1,"..#self.items.."]")

  local itemHeight = self.itemFrames[1]:GetHeight()
  local offset = (index - 1) * itemHeight
  if offset > self.offset + self:GetHeight() - itemHeight then
    offset = offset - self:GetHeight() + itemHeight
  elseif offset > self.offset then
    offset = self.offset
  end

  self:ScrollToOffset(math.max(0, offset))
end


-- Public List Functions

local function GetFontSize(self)
  return self.fontSize
end

local function SetFontSize(self, size)
  assert(type(size) == "number", "param 1 must be a number!")

  self.fontSize = size
  SetupItemFrames(self)
  SetupScrolling(self)
end

local function GetSelectionBackgroundColor(self)
  return unpack(self.selectionBgColor)
end

local function SetSelectionBackgroundColor(self, r, g, b, a)
  self.selectionBgColor = {r, g, b, a}
  UpdateSelection(self)
end

local function SetLevelIndentSize(self, size)
  assert(type(size) == "number", "param 1 must be a number!")

  self.indentSize = size
  SetupItemFrames(self)
end

local function SetLevelFontSize(self, level, size)
  assert(type(level) == "number", "param 1 must be a number!")
  assert(type(size) == "number", "param 2 must be a number!")

  self.levelFontSizes[level] = size
  SetupItemFrames(self)
  SetupScrolling(self)
end

local function SetLevelFontColor(self, level, r, g, b)
  self.levelFontColors[level] = {r, g, b}
  SetupItemFrames(self)
end

local function SetLevelBackgroundColor(self, level, r, g, b, a)
  self.levelBackgroundColors[level] = {r, g, b, a}
  SetupItemFrames(self)
end

local function SetLevelSelectable(self, level, selectable)
  assert(type(level) == "number", "param 1 must be a number!")
  assert(type(selectable) == "boolean", "param 2 must be a boolean!")

  self.levelSelectable[level] = selectable
end

local function GetEnabled(self)
  return self.enabled
end

local function SetEnabled(self, enabled)
  assert(type(enabled) == "boolean", "param 1 must be a boolean!")

  self.enabled = enabled
  if enabled then
    for _, itemFrame in ipairs(self.itemFrames) do
      itemFrame:SetFontColor(1, 1, 1, 1)
    end
  else
    for _, itemFrame in ipairs(self.itemFrames) do
      itemFrame:SetFontColor(0.5, 0.5, 0.5, 1)
    end
  end
end

local function GetItems(self)
  return self.items
end

local function SetItems(self, items, values, levels)
  assert(type(items) == "table", "param 1 must be a table!")
  assert(values == nil or type(values) == "table", "param 2 must be a table!")
  assert(levels == nil or type(levels) == "table", "param 3 must be a table!")

  self:ClearSelection(true)

  self.items = items
  self.values = values or {}
  self.levels = levels or {}

  self.offset = 0

  SetupItemFrames(self)
  SetupScrolling(self)
end

local function GetValues(self)
  return self.values
end

local function SetSelectionMode(self, mode)
  assert(type(mode) == "string", "param 1 must be a string!")
  assert(mode == "single" or mode == "multi", "param 1 must be one of: single, multi")

  self:ClearSelection()

  self.selectionMode = mode
end

local function GetSelectedItem(self)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  return self.items[self.selectedIndex]
end

local function SetSelectedItem(self, item, silent)
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  if item then
    for i, v in ipairs(self.items) do
      if v == item then
        self:SetSelectedIndex(i, silent)
        return
      end
    end
  end

  self:SetSelectedIndex(nil, silent)
end

local function GetSelectedValue(self)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  return self.values[self.selectedIndex]
end

local function SetSelectedValue(self, value, silent)
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  if value then
    for i, v in ipairs(self.values) do
      if v == value then
        self:SetSelectedIndex(i, silent)
        return
      end
    end
  end

  self:SetSelectedIndex(nil, silent)
end

local function GetSelectedIndex(self)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  return self.selectedIndex
end

local function SetSelectedIndex(self, index, silent)
  assert(index == nil or type(index) == "number", "param 1 must be a number!")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end

  if index == nil then
    self:ClearSelection(silent)
    return
  end

  if index and (index < 1 or index > #self.items) then
    index = nil
  end

  if index == self.selectedIndex then
    return
  end

  if self.selectedIndex then
    self.itemSelected[self.selectedIndex] = false
  end

  if index then
    self.itemSelected[index] = true
  end

  self.selectedIndex = index

  if not silent and self.Event.ItemSelect then
    local item = self.items[index]
    local value = self.values[index]
    self.Event.ItemSelect(self, item, value, index)
  end

  UpdateSelection(self)

  if not silent and self.Event.SelectionChange then
    self.Event.SelectionChange(self)
  end
end

local function AddSelectedIndex(self, index, silent)
  assert(type(index) == "number", "param 1 must be a number!")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if index and (index < 1 or index > #self.items) then
    return
  end

  if not self.itemSelected[index] then
    self.itemSelected[index] = true

    UpdateSelection(self)

    if not silent and self.Event.SelectionChange then
      self.Event.SelectionChange(self)
    end
  end
end

local function RemoveSelectedIndex(self, index, silent)
  assert(type(index) == "number", "param 1 must be a number!")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if index and (index < 1 or index > #self.items) then
    return
  end

  if self.itemSelected[index] then
    self.itemSelected[index] = false

    UpdateSelection(self)

    if not silent and self.Event.SelectionChange then
      self.Event.SelectionChange(self)
    end
  end
end

local function GetSelection(self)
  local selection = {}

  for i, selected in pairs(self.itemSelected) do
    if selected then
      table.insert(selection, { index=i, item=self.items[i], value=self.values[i] })
    end
  end

  return selection
end

local function ClearSelection(self, silent)
  assert(silent == nil or type(silent) == "boolean", "param 1 must be a boolean!")

  self.itemSelected = {}

  self.selectedIndex = nil

  UpdateSelection(self)

  if not silent and self.Event.SelectionChange then
    self.Event.SelectionChange(self)
  end
end

local function GetSelectedIndices(self)
  local indices = {}

  for i, selected in pairs(self.itemSelected) do
    if selected then
      table.insert(indices, i)
    end
  end

  return indices
end

local function SetSelectedIndices(self, indices, silent)
  assert(type(indices) == "table", "param 1 must be a table!")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if indices == nil then
    self:ClearSelection(silent)
    return
  end

  self.itemSelected = {}

  for _, i in ipairs(indices) do
    assert(i == nil or type(i) == "number", "values in param 1 table must be numbers!")
    if i ~= nil and i >= 1 and i <= #self.items then
      self.itemSelected[i] = true
    end
  end

  UpdateSelection(self)

  if not silent and self.Event.SelectionChange then
    self.Event.SelectionChange(self)
  end
end

local function GetSelectedItems(self)
  local items = {}

  for i, selected in pairs(self.itemSelected) do
    if selected then
      table.insert(items, self.items[i])
    end
  end

  return items
end

local function SetSelectedItems(self, items, silent)
  assert(type(items) == "table", "param 1 must be a table!")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if items == nil then
    self:ClearSelection(silent)
    return
  end

  local indices = {}

  for i, item in ipairs(self.items) do
    for _, selectItem in ipairs(items) do
      if item == selectItem then
        table.insert(indices, i)
      end
    end
  end

  self:SetSelectedIndices(indices, silent)
end

local function GetSelectedValues(self)
  local values = {}

  for i, selected in pairs(self.itemSelected) do
    if selected then
      table.insert(values, self.values[i])
    end
  end

  return values
end

local function SetSelectedValues(self, values, silent)
  assert(type(values) == "table", "param 1 must be a table!")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if values == nil then
    self:ClearSelection(silent)
    return
  end

  local indices = {}

  for i, value in ipairs(self.values) do
    for _, selectValue in ipairs(values) do
      if value == selectValue then
        table.insert(indices, i)
      end
    end
  end

  self:SetSelectedIndices(indices, silent)
end

local function GetMaxWidth(self)
  local maxWidth = 0
  local f = AcquireItemFrame(self)
  for i, item in ipairs(self.items) do
    f:SetText(item)
    maxWidth = math.max(maxWidth, f:GetWidth())
  end
  ReleaseItemFrame(self, f)
  return maxWidth
end


-- Constructor Functions

function Library.LibSimpleWidgets.ScrollList(name, parent)
  local widget = UI.CreateFrame("Mask", name, parent)
  widget.bg = UI.CreateFrame("Frame", name.."BG", widget)
  widget.scrollbar = UI.CreateFrame("RiftScrollbar", name.."Scrollbar", widget)

  widget.scrollInterval = 3
  widget.showScrollbar = true
  widget.scrollbarNeeded = false
  widget.enabled = true
  widget.fontSize = 12
  widget.selectionBgColor = {0, 0, 0.5, 1}
  widget.items = {}
  widget.values = {}
  widget.levels = {}
  widget.itemFramePool = {}
  widget.itemFrames = {}
  widget.itemSelected = {}
  widget.indentSize = 10
  widget.levelFontSizes = {}
  widget.levelFontColors = {}
  widget.levelBackgroundColors = {}
  widget.levelSelectable = {}
  widget.selectedIndex = nil
  widget.selectionMode = "single"

  widget.Event.WheelBack = WheelBack
  widget.Event.WheelForward = WheelForward
  widget.Event.Size = ScrollViewResized

  widget.bg:SetAllPoints(widget)
  widget.bg:SetLayer(-10)
  widget.bg:SetBackgroundColor(0, 0, 0, 0)

  widget.scrollbar.scrollview = widget
  widget.scrollbar:SetOrientation("vertical")
  widget.scrollbar:SetLayer(10)
  widget.scrollbar:SetPoint("TOPRIGHT", widget, "TOPRIGHT", 0, 0)
  widget.scrollbar:SetPoint("BOTTOMRIGHT", widget, "BOTTOMRIGHT", 0, 0)
  widget.scrollbar.Event.ScrollbarChange = ScrollbarChange

  widget.SavedSetVisible = widget.SetVisible

  -- Public API - ScrollView
  widget.SetBorder = SetBorder
  widget.SetBackgroundColor = SetBackgroundColor
  widget.SetVisible = SetVisible
  widget.GetScrollInterval = GetScrollInterval
  widget.SetScrollInterval = SetScrollInterval
  widget.GetShowScrollbar = GetShowScrollbar
  widget.SetShowScrollbar = SetShowScrollbar
  widget.GetScrollbarWidth = GetScrollbarWidth
  widget.SetScrollbarWidth = SetScrollbarWidth
  widget.GetScrollOffset = GetScrollOffset
  widget.ScrollToOffset = ScrollToOffset
  widget.GetMaxOffset = GetMaxOffset
  widget.EnsureIndexVisible = EnsureIndexVisible

  -- Public API - List
  widget.GetFontSize = GetFontSize
  widget.SetFontSize = SetFontSize
  widget.GetEnabled = GetEnabled
  widget.SetEnabled = SetEnabled
  widget.GetSelectionBackgroundColor = GetSelectionBackgroundColor
  widget.SetSelectionBackgroundColor = SetSelectionBackgroundColor
  widget.SetLevelIndentSize = SetLevelIndentSize
  widget.SetLevelFontSize = SetLevelFontSize
  widget.SetLevelFontColor = SetLevelFontColor
  widget.SetLevelBackgroundColor = SetLevelBackgroundColor
  widget.SetLevelSelectable = SetLevelSelectable
  widget.GetItems = GetItems
  widget.SetItems = SetItems
  widget.GetValues = GetValues
  widget.SetSelectionMode = SetSelectionMode
  widget.GetSelectedIndex = GetSelectedIndex
  widget.SetSelectedIndex = SetSelectedIndex
  widget.GetSelectedItem = GetSelectedItem
  widget.SetSelectedItem = SetSelectedItem
  widget.GetSelectedValue = GetSelectedValue
  widget.SetSelectedValue = SetSelectedValue
  widget.AddSelectedIndex = AddSelectedIndex
  widget.RemoveSelectedIndex = RemoveSelectedIndex
  widget.GetSelection = GetSelection
  widget.ClearSelection = ClearSelection
  widget.GetSelectedIndices = GetSelectedIndices
  widget.SetSelectedIndices = SetSelectedIndices
  widget.GetSelectedItems = GetSelectedItems
  widget.SetSelectedItems = SetSelectedItems
  widget.GetSelectedValues = GetSelectedValues
  widget.SetSelectedValues = SetSelectedValues
  widget.GetMaxWidth = GetMaxWidth

  Library.LibSimpleWidgets.EventProxy(widget, {"ItemClick", "ItemSelect", "SelectionChange"})

  UpdateScrollbarVisiblity(widget)

  return widget
end
