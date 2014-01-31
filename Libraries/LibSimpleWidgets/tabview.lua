-- Helper Functions

local LSW_SetBorder = Library.LibSimpleWidgets.SetBorder

local TAB_BORDER_WIDTH = 1
local TAB_GAP = 4

local function CalcMaxLabelWidth(self)
  local w = 0
  for i, tab in ipairs(self.tabs) do
    local origFontSize = tab.labelFrame:GetFontSize()
    tab.labelFrame:SetFontSize(self.fontSize + 1)
    w = math.max(w, tab.labelFrame:GetWidth())
    tab.labelFrame:SetFontSize(origFontSize)
  end
  return w
end

local function CalcMaxTabWidth(self)
  return math.max(self.minimumTabWidth, CalcMaxLabelWidth(self) + 10)
end

local function CalcTabWidth(self, tab)
  if self.tabPosition == "left" or self.tabPosition == "right" then
    return CalcMaxTabWidth(self)
  else
    return math.max(self.minimumTabWidth, tab.labelFrame:GetWidth() + 10)
  end
end


-- Public Functions

local function AddTab(self, label, frame)
  assert(type(label) == "string", "param 1 must be a string!")
  assert(type(frame) == "table", "param 2 must be a frame!")

  local tab = {
    frame = frame,
    active = false,
  }
  table.insert(self.tabs, tab)
  local index = #self.tabs

  frame:SetParent(self.tabContent)
  frame:SetLayer(1)
  frame:SetAllPoints(self.tabContent)
  frame:SetVisible(false)

  -- Setup tab background and border
  tab.tabFrame = UI.CreateFrame("Frame", self:GetName().."Tab"..tostring(index), self)
  tab.tabFrame:SetBackgroundColor(unpack(self.inactiveTabBackgroundColor))
  tab.tabFrame:SetHeight(25)
  tab.tabFrame:SetLayer(2)
  local r, g, b, a = unpack(self.inactiveTabBorderColor)
  LSW_SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, r, g, b, a, self.tabOtherSides)

  -- Setup label
  tab.labelFrame = UI.CreateFrame("Text", self:GetName().."Label"..tostring(index), tab.tabFrame)
  tab.labelFrame:SetFontSize(self.fontSize)
  tab.labelFrame:SetFontColor(unpack(self.inactiveFontColor))
  tab.labelFrame:SetPoint("CENTER", tab.tabFrame, "CENTER")
  tab.labelFrame:SetText(label)

  -- Size all tabs
  for i, t in ipairs(self.tabs) do
    t.tabFrame:SetWidth(CalcTabWidth(self, t))
  end

  -- Reposition tab content
  if self.tabPosition == "left" then
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5 + CalcMaxTabWidth(self), 5)
  elseif self.tabPosition == "right" then
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5 - CalcMaxTabWidth(self), -5)
  end

  -- Setup mouse events for highlighting and activating tabs
  tab.tabFrame.Event.MouseIn = function()
    tab.labelFrame:SetFontSize(self.fontSize + 1)
    tab.labelFrame:SetFontColor(unpack(self.highlightFontColor))
  end
  tab.tabFrame.Event.MouseOut = function()
    tab.labelFrame:SetFontSize(self.fontSize)
    if tab.active then
      tab.labelFrame:SetFontColor(unpack(self.activeFontColor))
    else
      tab.labelFrame:SetFontColor(unpack(self.inactiveFontColor))
    end
  end
  tab.tabFrame.Event.LeftDown = function()
    self:SetActiveTab(index)
  end

  -- Position tab
  local prevTab = self.tabs[index-1]
  if prevTab then
    if self.tabPosition == "bottom" then
      tab.tabFrame:SetPoint("TOPLEFT", prevTab.tabFrame, "TOPRIGHT", TAB_GAP, 0)
    elseif self.tabPosition == "top" then
      tab.tabFrame:SetPoint("BOTTOMLEFT", prevTab.tabFrame, "BOTTOMRIGHT", TAB_GAP, 0)
    elseif self.tabPosition == "left" then
      tab.tabFrame:SetPoint("TOPRIGHT", prevTab.tabFrame, "BOTTOMRIGHT", 0, TAB_GAP)
    elseif self.tabPosition == "right" then
      tab.tabFrame:SetPoint("TOPLEFT", prevTab.tabFrame, "BOTTOMLEFT", 0, TAB_GAP)
    end
  else
    if self.tabPosition == "bottom" then
      tab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "BOTTOMLEFT", TAB_GAP*1.5, TAB_BORDER_WIDTH)
    elseif self.tabPosition == "top" then
      tab.tabFrame:SetPoint("BOTTOMLEFT", self.tabContent, "TOPLEFT", TAB_GAP*1.5, -TAB_BORDER_WIDTH)
    elseif self.tabPosition == "left" then
      tab.tabFrame:SetPoint("TOPRIGHT", self.tabContent, "TOPLEFT", -TAB_BORDER_WIDTH, TAB_GAP*1.5)
    elseif self.tabPosition == "right" then
      tab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "TOPRIGHT", TAB_BORDER_WIDTH, TAB_GAP*1.5)
    end
  end

  if #self.tabs == 1 then
    self:SetActiveTab(1)
  end
end

local function RemoveTab(self, index)
  assert(type(index) == "number", "param 1 must be a number!")

  local tab = self.tabs[index]
  if tab == nil then return end

  tab.tabFrame:SetVisible(false)
  tab.frame:SetVisible(false)

  local prevTab = self.tabs[index-1]
  local nextTab = self.tabs[index+1]

  table.remove(self.tabs, index)

  -- Size all tabs
  for i, t in ipairs(self.tabs) do
    t.tabFrame:SetWidth(CalcTabWidth(self, t))
  end

  -- Reposition tab content
  if self.tabPosition == "left" then
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5 + CalcMaxTabWidth(self), 5)
  elseif self.tabPosition == "right" then
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5 - CalcMaxTabWidth(self), -5)
  end

  if nextTab ~= nil then
    if prevTab ~= nil then
      if self.tabPosition == "bottom" then
        nextTab.tabFrame:SetPoint("TOPLEFT", prevTab.tabFrame, "TOPRIGHT", TAB_GAP, 0)
      elseif self.tabPosition == "top" then
        nextTab.tabFrame:SetPoint("BOTTOMLEFT", prevTab.tabFrame, "BOTTOMRIGHT", TAB_GAP, 0)
      elseif self.tabPosition == "left" then
        nextTab.tabFrame:SetPoint("TOPRIGHT", prevTab.tabFrame, "BOTTOMRIGHT", 0, TAB_GAP)
      elseif self.tabPosition == "right" then
        nextTab.tabFrame:SetPoint("TOPLEFT", prevTab.tabFrame, "BOTTOMLEFT", 0, TAB_GAP)
      end
    else
      if self.tabPosition == "bottom" then
        nextTab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "BOTTOMLEFT", TAB_GAP*1.5, TAB_BORDER_WIDTH)
      elseif self.tabPosition == "top" then
        nextTab.tabFrame:SetPoint("BOTTOMLEFT", self.tabContent, "TOPLEFT", TAB_GAP*1.5, -TAB_BORDER_WIDTH)
      elseif self.tabPosition == "left" then
        nextTab.tabFrame:SetPoint("TOPRIGHT", self.tabContent, "TOPLEFT", -TAB_BORDER_WIDTH, TAB_GAP*1.5)
      elseif self.tabPosition == "right" then
        nextTab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "TOPRIGHT", TAB_BORDER_WIDTH, TAB_GAP*1.5)
      end
    end
  end

  if tab.active and #self.tabs > 0 then
    self:SetActiveTab(math.max(1, index-1))
  end
end

local function GetActiveTab(self)
  for i, tab in ipairs(self.tabs) do
    if tab.active then
      return i
    end
  end

  return nil
end

local function SetActiveTab(self, index)
  assert(type(index) == "number", "param 1 must be a number!")

  local origTab
  for i, tab in ipairs(self.tabs) do
    if tab.active then
      origTab = i
    end
    if i == index then
      tab.active = true
      tab.tabFrame:SetBackgroundColor(unpack(self.activeTabBackgroundColor))
      tab.tabFrame:SetWidth(CalcTabWidth(self, tab) + self.activeTabWidthOffset)
      tab.tabFrame:SetHeight(25 + self.activeTabHeightOffset)
      tab.tabFrame:SetLayer(3)
      local r, g, b, a = unpack(self.activeTabBorderColor)
      LSW_SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, r, g, b, a, self.tabOtherSides)
      tab.labelFrame:SetFontSize(self.fontSize)
      tab.labelFrame:SetFontColor(unpack(self.activeFontColor))
      tab.frame:SetVisible(true)
    else
      tab.active = false
      tab.tabFrame:SetBackgroundColor(unpack(self.inactiveTabBackgroundColor))
      tab.tabFrame:SetWidth(CalcTabWidth(self, tab))
      tab.tabFrame:SetHeight(25)
      tab.tabFrame:SetLayer(2)
      local r, g, b, a = unpack(self.inactiveTabBorderColor)
      LSW_SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, r, g, b, a, self.tabOtherSides)
      tab.labelFrame:SetFontSize(self.fontSize)
      tab.labelFrame:SetFontColor(unpack(self.inactiveFontColor))
      tab.frame:SetVisible(false)
    end
  end

  if origTab ~= index and self.Event.TabSelect then
    self.Event.TabSelect(self, index)
  end
end

local function SetTabLabel(self, index, label)
  assert(type(index) == "number", "param 1 must be a number!")
  assert(type(label) == "string", "param 2 must be a string!")

  local tab = self.tabs[index]
  if tab == nil then return end

  tab.labelFrame:SetText(label)

  -- Size all tabs
  for i, t in ipairs(self.tabs) do
    t.tabFrame:SetWidth(CalcTabWidth(self, t))
  end

  -- Reposition tab content
  if self.tabPosition == "left" then
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5 + CalcMaxTabWidth(self), 5)
  elseif self.tabPosition == "right" then
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5 - CalcMaxTabWidth(self), -5)
  end
end

local function SetTabContent(self, index, frame)
  assert(type(index) == "number", "param 1 must be a number!")
  assert(type(frame) == "table", "param 2 must be a frame!")

  local tab = self.tabs[index]
  if tab == nil then return end

  if tab.frame then
    tab.frame:SetVisible(false)
  end

  tab.frame = frame

  frame:SetParent(self.tabContent)
  frame:SetLayer(1)
  frame:SetAllPoints(self.tabContent)
  frame:SetVisible(tab.active)
end

local function SetMinimumTabWidth(self, width)
  assert(type(width) == "number", "param 1 must be a number!")

  self.minimumTabWidth = width

  for i, tab in ipairs(self.tabs) do
    tab.tabFrame:SetWidth(CalcTabWidth(self, tab))
  end

  -- Reposition tab content
  if self.tabPosition == "left" then
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5 + CalcMaxTabWidth(self), 5)
  elseif self.tabPosition == "right" then
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5 - CalcMaxTabWidth(self), -5)
  end
end

local function SetTabPosition(self, pos)
  if pos == "bottom" then
    self.tabConnectedSide = "t"
    self.tabOtherSides = "blr"
    self.activeTabWidthOffset = 0
    self.activeTabHeightOffset = 3
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5, 5)
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, -32)
  elseif pos == "top" then
    self.tabConnectedSide = "b"
    self.tabOtherSides = "tlr"
    self.activeTabWidthOffset = 0
    self.activeTabHeightOffset = 3
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5, 32)
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, -5)
  elseif pos == "left" then
    self.tabConnectedSide = "r"
    self.tabOtherSides = "tlb"
    self.activeTabWidthOffset = 3
    self.activeTabHeightOffset = 0
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5 + CalcMaxTabWidth(self), 5)
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, -5)
  elseif pos == "right" then
    self.tabConnectedSide = "l"
    self.tabOtherSides = "trb"
    self.activeTabWidthOffset = 3
    self.activeTabHeightOffset = 0
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5, 5)
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5 - CalcMaxTabWidth(self), -5)
  else
    error("invalid tab position: "..pos)
  end

  self.tabPosition = pos

  if #self.tabs > 0 then
    for i, tab in ipairs(self.tabs) do
      tab.tabFrame:ClearAll()

      if tab.active then
        tab.tabFrame:SetWidth(CalcTabWidth(self, tab) + self.activeTabWidthOffset)
        tab.tabFrame:SetHeight(25 + self.activeTabHeightOffset)
        tab.tabFrame:SetLayer(3)
        local r, g, b, a = unpack(self.activeTabBorderColor)
        LSW_SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, r, g, b, a, self.tabOtherSides)
      else
        tab.tabFrame:SetWidth(CalcTabWidth(self, tab))
        tab.tabFrame:SetHeight(25)
        tab.tabFrame:SetLayer(2)
        local r, g, b, a = unpack(self.inactiveTabBorderColor)
        LSW_SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, r, g, b, a, self.tabOtherSides)
      end

      if i == 1 then
        if pos == "bottom" then
          tab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "BOTTOMLEFT", TAB_GAP*1.5, TAB_BORDER_WIDTH)
        elseif pos == "top" then
          tab.tabFrame:SetPoint("BOTTOMLEFT", self.tabContent, "TOPLEFT", TAB_GAP*1.5, -TAB_BORDER_WIDTH)
        elseif pos == "left" then
          tab.tabFrame:SetPoint("TOPRIGHT", self.tabContent, "TOPLEFT", -TAB_BORDER_WIDTH, TAB_GAP*1.5)
        elseif pos == "right" then
          tab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "TOPRIGHT", TAB_BORDER_WIDTH, TAB_GAP*1.5)
        end
      elseif i > 1 then
        local prevTab = self.tabs[i-1]
        if pos == "bottom" then
          tab.tabFrame:SetPoint("TOPLEFT", prevTab.tabFrame, "TOPRIGHT", TAB_GAP, 0)
        elseif pos == "top" then
          tab.tabFrame:SetPoint("BOTTOMLEFT", prevTab.tabFrame, "BOTTOMRIGHT", TAB_GAP, 0)
        elseif pos == "left" then
          tab.tabFrame:SetPoint("TOPRIGHT", prevTab.tabFrame, "BOTTOMRIGHT", 0, TAB_GAP)
        elseif pos == "right" then
          tab.tabFrame:SetPoint("TOPLEFT", prevTab.tabFrame, "BOTTOMLEFT", 0, TAB_GAP)
        end
      end
    end
  end
end

local function GetFontSize(self)
  return self.fontSize
end

local function SetFontSize(self, size)
  assert(type(size) == "number", "param 1 must be a number!")

  self.fontSize = size

  for i, tab in ipairs(self.tabs) do
    tab.labelFrame:SetFontSize(size)
  end

  -- Size all tabs
  for i, t in ipairs(self.tabs) do
    t.tabFrame:SetWidth(CalcTabWidth(self, t))
  end

  -- Reposition tab content
  if self.tabPosition == "left" then
    self.tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 5 + CalcMaxTabWidth(self), 5)
  elseif self.tabPosition == "right" then
    self.tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5 - CalcMaxTabWidth(self), -5)
  end
end

local function GetInactiveFontColor(self)
  return unpack(self.inactiveFontColor)
end

local function SetInactiveFontColor(self, r, g, b, a)
  self.inactiveFontColor = {r, g, b, a}
  for i, tab in ipairs(self.tabs) do
    if not tab.active then
      tab.labelFrame:SetFontColor(r, g, b, a)
    end
  end
end

local function GetActiveFontColor(self)
  return unpack(self.activeFontColor)
end

local function SetActiveFontColor(self, r, g, b, a)
  self.activeFontColor = {r, g, b, a}
  for i, tab in ipairs(self.tabs) do
    if tab.active then
      tab.labelFrame:SetFontColor(r, g, b, a)
    end
  end
end

local function GetHighlightFontColor(self)
  return unpack(self.highlightFontColor)
end

local function SetHighlightFontColor(self, r, g, b, a)
  self.highlightFontColor = {r, g, b, a}
end

local function GetTabContentBackgroundColor(self)
  return self.tabContent:GetBackgroundColor()
end

local function SetTabContentBackgroundColor(self, r, g, b, a)
  self.tabContent:SetBackgroundColor(r, g, b, a)
end

local function GetTabContentBorderColor(self)
  return unpack(self.tabContentBorderColor)
end

local function SetTabContentBorderColor(self, r, g, b, a)
  self.tabContentBorderColor = {r, g, b, a }
  LSW_SetBorder(self.tabContent, 1, r, g, b, a)
end

local function GetActiveTabBackgroundColor(self)
  return unpack(self.activeTabBackgroundColor)
end

local function SetActiveTabBackgroundColor(self, r, g, b, a)
  self.activeTabBackgroundColor = {r, g, b, a }

  -- reset active tab to apply new color
  local i = self:GetActiveTab()
  if i ~= nil then
    self:SetActiveTab(i)
  end
end

local function GetActiveTabBorderColor(self)
  return unpack(self.activeTabBorderColor)
end

local function SetActiveTabBorderColor(self, r, g, b, a)
  self.activeTabBorderColor = {r, g, b, a}

  -- reset active tab to apply new color
  local i = self:GetActiveTab()
  if i ~= nil then
    self:SetActiveTab(i)
  end
end

local function GetInactiveTabBackgroundColor(self)
  return unpack(self.inactiveTabBackgroundColor)
end

local function SetInactiveTabBackgroundColor(self, r, g, b, a)
  self.inactiveTabBackgroundColor = {r, g, b, a}

  -- reset active tab to apply new color
  local i = self:GetActiveTab()
  if i ~= nil then
    self:SetActiveTab(i)
  end
end

local function GetInactiveTabBorderColor(self)
  return unpack(self.inactiveTabBorderColor)
end

local function SetInactiveTabBorderColor(self, r, g, b, a)
  self.inactiveTabBorderColor = {r, g, b, a}

  -- reset active tab to apply new color
  local i = self:GetActiveTab()
  if i ~= nil then
    self:SetActiveTab(i)
  end
end


-- Constructor Function

function Library.LibSimpleWidgets.TabView(name, parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.tabContent = UI.CreateFrame("Frame", name.."Content", widget)

  widget.fontSize = 13
  widget.inactiveFontColor = {0.66, 0.65, 0.56, 1}
  widget.activeFontColor = {0.86, 0.81, 0.63, 1}
  widget.highlightFontColor = {1, 1, 1, 1}
  widget.tabContentBorderColor = {0.27, 0.27, 0.27, 1}
  widget.activeTabBackgroundColor = {0.17, 0.17, 0.17, 1}
  widget.activeTabBorderColor = {0.47, 0.48, 0.40, 1}
  widget.inactiveTabBackgroundColor = {0.12, 0.11, 0.12, 1}
  widget.inactiveTabBorderColor = {0.23, 0.22, 0.23, 1}
  widget.minimumTabWidth = 100
  widget.tabs = {}

  widget.tabContent:SetBackgroundColor(0.17, 0.17, 0.17, 1)
  widget.tabContent:SetLayer(1)
  local r, g, b, a = unpack(widget.tabContentBorderColor)
  LSW_SetBorder(widget.tabContent, 1, r, g, b, a)

  SetTabPosition(widget, "bottom")

  widget.AddTab = AddTab
  widget.RemoveTab = RemoveTab
  widget.GetActiveTab = GetActiveTab
  widget.SetActiveTab = SetActiveTab
  widget.SetTabLabel = SetTabLabel
  widget.SetTabContent = SetTabContent
  widget.SetMinimumTabWidth = SetMinimumTabWidth
  widget.SetTabPosition = SetTabPosition
  widget.GetFontSize = GetFontSize
  widget.SetFontSize = SetFontSize
  widget.GetInactiveFontColor = GetInactiveFontColor
  widget.SetInactiveFontColor = SetInactiveFontColor
  widget.GetActiveFontColor = GetActiveFontColor
  widget.SetActiveFontColor = SetActiveFontColor
  widget.GetHighlightFontColor = GetHighlightFontColor
  widget.SetHighlightFontColor = SetHighlightFontColor
  widget.GetTabContentBackgroundColor = GetTabContentBackgroundColor
  widget.SetTabContentBackgroundColor = SetTabContentBackgroundColor
  widget.GetTabContentBorderColor = GetTabContentBorderColor
  widget.SetTabContentBorderColor = SetTabContentBorderColor
  widget.GetActiveTabBackgroundColor = GetActiveTabBackgroundColor
  widget.SetActiveTabBackgroundColor = SetActiveTabBackgroundColor
  widget.GetActiveTabBorderColor = GetActiveTabBorderColor
  widget.SetActiveTabBorderColor = SetActiveTabBorderColor
  widget.GetInactiveTabBackgroundColor = GetInactiveTabBackgroundColor
  widget.SetInactiveTabBackgroundColor = SetInactiveTabBackgroundColor
  widget.GetInactiveTabBorderColor = GetInactiveTabBorderColor
  widget.SetInactiveTabBorderColor = SetInactiveTabBorderColor

  Library.LibSimpleWidgets.EventProxy(widget, { "TabSelect" })

  return widget
end
