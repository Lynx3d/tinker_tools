local BUTTON_NORMAL = "textures/dropdownbutton.png"
local BUTTON_HIGHLIGHT = "textures/dropdownbutton_highlight.png"
local BUTTON_CLICKED = "textures/dropdownbutton_clicked.png"

-- Helper Functions

local function contains(tbl, val)
  for k, v in pairs(tbl) do
    if v == val then
      return true
    end
  end
  return false
end

local function FindContext(frame)
  local parent = frame.GetParent and frame:GetParent() or nil
  if parent == nil then
    return frame
  else
    return FindContext(parent)
  end
end

local function UpdateCurrent(self)
  local item = self.dropdown:GetSelectedItem()

  if item == nil then
    self.current:SetText("Select...")
  else
    self.current:SetText(item)
  end
end

local function ResizeDropdown(self)
  local currentHeight = self.current:GetHeight()
  local itemsHeight = #self.dropdown:GetItems() * currentHeight

  self.dropdown:SetHeight(math.max(currentHeight, math.min(self.maxDropdownHeight, itemsHeight)))
end


-- Current Frame Events

local function CurrentClick(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  local dropdown = widget.dropdown
  dropdown:SetVisible(not dropdown:GetVisible())
end


-- Dropdown Frame Events

local function DropdownItemSelect(self, item, value, index)
  local widget = self.widget
  UpdateCurrent(widget)
  if widget.Event.ItemSelect then
    widget.Event.ItemSelect(widget, item, value, index)
  end
  self:SetVisible(false)
end


-- Public Functions

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.current, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.dropdown, width, r, g, b, a)
end

local function SetBackgroundColor(self, r, g, b, a)
  self.current:SetBackgroundColor(r, g, b, a)
  self.dropdown:SetBackgroundColor(r, g, b, a)
end

local function GetFontSize(self)
  return self.current:GetFontSize()
end

local function SetFontSize(self, size)
  assert(type(size) == "number", "param 1 must be a number!")
  self.current:SetFontSize(size)
  self.dropdown:SetFontSize(size)

  self:ResizeToFit()
end

local function GetShowArrow(self)
  return self.button:GetVisible()
end

local function SetShowArrow(self, showArrow)
  self.button:SetVisible(showArrow)
end

local function ResizeToFit(self)
  self.current:ClearAll()
  self:SetHeight(self.current:GetHeight())

  local maxWidth = math.max(self.current:GetWidth(), self.dropdown:GetMaxWidth())

  self.current:SetAllPoints(self)
  self:SetWidth(maxWidth + self.button:GetWidth())

  ResizeDropdown(self)
end

local function GetEnabled(self)
  return self.enabled
end

local function SetEnabled(self, enabled)
  assert(type(enabled) == "boolean", "param 1 must be a boolean!")

  self.enabled = enabled
  if enabled then
    self.current:SetFontColor(1, 1, 1, 1)
  else
    self.current:SetFontColor(0.5, 0.5, 0.5, 1)
    self.dropdown:SetVisible(false)
  end

  self.dropdown:SetEnabled(enabled)
end

local function GetMaxDropdownHeight(self)
  return self.maxDropdownHeight
end

local function SetMaxDropdownHeight(self, maxDropdownHeight)
  self.maxDropdownHeight = maxDropdownHeight
  ResizeDropdown(self)
end

local function GetItems(self)
  return self.dropdown:GetItems()
end

local function SetItems(self, items, values)
  assert(type(items) == "table", "param 1 must be a table!")
  assert(values == nil or type(values) == "table", "param 2 must be a table!")

  self.dropdown:SetItems(items, values)
  ResizeDropdown(self)
  UpdateCurrent(self)
end

local function GetValues(self)
  return self.dropdown:GetValues()
end

local function GetSelectedItem(self)
  return self.dropdown:GetSelectedItem()
end

local function SetSelectedItem(self, item, silent)
  self.dropdown:SetSelectedItem(item, true)
  UpdateCurrent(self)
  if not silent and self.Event.ItemSelect then
    self.Event.ItemSelect(self, self.dropdown:GetSelectedItem(), self.dropdown:GetSelectedValue(), self.dropdown:GetSelectedIndex())
  end
end

local function GetSelectedValue(self)
  return self.dropdown:GetSelectedValue()
end

local function SetSelectedValue(self, value, silent)
  self.dropdown:SetSelectedValue(value, true)
  UpdateCurrent(self)
  if not silent and self.Event.ItemSelect then
    self.Event.ItemSelect(self, self.dropdown:GetSelectedItem(), self.dropdown:GetSelectedValue(), self.dropdown:GetSelectedIndex())
  end
end

local function GetSelectedIndex(self)
  return self.dropdown:GetSelectedIndex()
end

local function SetSelectedIndex(self, index, silent)
  self.dropdown:SetSelectedIndex(index, true)
  UpdateCurrent(self)
  if not silent and self.Event.ItemSelect then
    self.Event.ItemSelect(self, self.dropdown:GetSelectedItem(), self.dropdown:GetSelectedValue(), self.dropdown:GetSelectedIndex())
  end
end


-- Constructor Function

function Library.LibSimpleWidgets.Select(name, parent)
  local context = FindContext(parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.current = UI.CreateFrame("Text", widget:GetName().."Current", widget)
  widget.button = UI.CreateFrame("Texture", widget:GetName().."Button", widget)
  widget.dropdown = UI.CreateFrame("SimpleScrollList", widget:GetName().."DropdownScroller", context)

  widget.enabled = true

  widget.current:SetBackgroundColor(0, 0, 0, 1)
  widget.current:SetText("Select...")
  widget.current:SetLayer(1)
  widget.current.Event.LeftClick = CurrentClick

  widget.maxDropdownHeight = widget.current:GetHeight() * 10

  widget.button:SetTexture("LibSimpleWidgets", BUTTON_NORMAL)
  local buttonWidth = widget.button:GetWidth()
  local buttonHeight = widget.button:GetHeight()
  widget.button:SetPoint("TOPRIGHT", widget.current, "TOPRIGHT", 1, -1)
  widget.button:SetPoint("BOTTOMRIGHT", widget.current, "BOTTOMRIGHT", 1, 1)
  widget.button:SetLayer(2)
  widget.button.Event.LeftClick = CurrentClick
  widget.button.Event.MouseIn = function(self) self:SetTexture("LibSimpleWidgets", BUTTON_HIGHLIGHT) end
  widget.button.Event.MouseOut = function(self) self:SetTexture("LibSimpleWidgets", BUTTON_NORMAL) end
  widget.button.Event.LeftDown = function(self) self:SetTexture("LibSimpleWidgets", BUTTON_CLICKED) end
  widget.button.Event.LeftUp = function(self) self:SetTexture("LibSimpleWidgets", BUTTON_HIGHLIGHT) end
  widget.button.Event.Size = function(self) self:SetWidth(self:GetHeight() / 19 * 21) end

  widget.dropdown.widget = widget
  widget.dropdown:SetPoint("TOPLEFT", widget.current, "BOTTOMLEFT", 0, 2)
  widget.dropdown:SetPoint("TOPRIGHT", widget.current, "BOTTOMRIGHT", 0, 2)
  widget.dropdown:SetLayer(1000000)
  widget.dropdown:SetVisible(false)
  widget.dropdown:SetBackgroundColor(0, 0, 0, 1)
  widget.dropdown.Event.ItemSelect = DropdownItemSelect

  ResizeDropdown(widget)

  widget:SetWidth(widget.current:GetWidth() + buttonWidth)
  widget:SetHeight(widget.current:GetHeight())
  widget.current:SetAllPoints(widget)

  widget.SetBorder = SetBorder
  widget.SetBackgroundColor = SetBackgroundColor
  widget.GetFontSize = GetFontSize
  widget.SetFontSize = SetFontSize
  widget.GetShowArrow = GetShowArrow
  widget.SetShowArrow = SetShowArrow
  widget.ResizeToDefault = ResizeToFit -- TODO: Deprecated.
  widget.ResizeToFit = ResizeToFit
  widget.GetEnabled = GetEnabled
  widget.SetEnabled = SetEnabled
  widget.GetMaxDropdownHeight = GetMaxDropdownHeight
  widget.SetMaxDropdownHeight = SetMaxDropdownHeight
  widget.GetItems = GetItems
  widget.SetItems = SetItems
  widget.GetValues = GetValues
  widget.GetSelectedIndex = GetSelectedIndex
  widget.SetSelectedIndex = SetSelectedIndex
  widget.GetSelectedItem = GetSelectedItem
  widget.SetSelectedItem = SetSelectedItem
  widget.GetSelectedValue = GetSelectedValue
  widget.SetSelectedValue = SetSelectedValue

  Library.LibSimpleWidgets.EventProxy(widget, {"ItemSelect"})

  Library.LibSimpleWidgets.SetBorder(widget.current, 1, 165/255, 162/255, 134/255, 1, "t")
  Library.LibSimpleWidgets.SetBorder(widget.current, 1, 103/255, 98/255, 88/255, 1, "lr")
  Library.LibSimpleWidgets.SetBorder(widget.current, 1, 17/255, 66/255, 55/255, 1, "b")
  Library.LibSimpleWidgets.SetBorder(widget.dropdown, 1, 165/255, 162/255, 134/255, 1, "tblr")

  return widget
end
