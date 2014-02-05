-- Helper Functions

local function UpdateSelected(radioButtons, selected, silent)
  for i, radioButton in ipairs(radioButtons) do
    if radioButton ~= selected then
      radioButton:SetSelected(false, silent)
    end
  end
end

-- Public Functions

local class = {}
class.__index = class

function class:GetName()
  return self.name
end

function class:AddRadioButton(radioButton)
  table.insert(self.radioButtons, radioButton)
  radioButton.group = self
end

function class:RemoveRadioButton(radioButton)
  assert(type(radioButton) == "number" or type(radioButton) == "table", "param 1 must be a number or a radiobutton frame!")

  radioButton.group = nil
  if type(radioButton) == "number" then
    table.remove(self.radioButtons, radioButton)
  else
    for i, v in ipairs(self.radioButtons) do
      if v == radioButton then
        table.remove(self.radioButtons, i)
      end
    end
  end
end

function class:GetRadioButton(index)
  assert(type(index) == "number", "param 1 must be a number!")

  return self.radioButtons[index]
end

function class:GetSelectedRadioButton()
  for i, radioButton in ipairs(self.radioButtons) do
    if radioButton:GetSelected() then
      return radioButton
    end
  end
end

function class:GetSelectedIndex()
  for i, radioButton in ipairs(self.radioButtons) do
    if radioButton:GetSelected() then
      return i
    end
  end
end

function class:SetSelectedIndex(index, silent)
  assert(type(index) == "number", "param 1 must be a number!")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  local radioButton = self.radioButtons[index]
  radioButton:SetSelected(true, silent)
end

function class:SetEnabled(enabled)
  assert(type(enabled) == "boolean", "param 1 must be a boolean!")

  for i, radioButton in ipairs(self.radioButtons) do
    radioButton:SetEnabled(enabled)
  end
end

-- Internal Functions

function class:RadioButtonSelected(radioButton, silent)
  UpdateSelected(self.radioButtons, radioButton, silent)
  if not silent and self.Event.RadioButtonChange then
    self.Event.RadioButtonChange(self)
  end
end

-- Constructor Function

function Library.LibSimpleWidgets.RadioButtonGroup(name)
  assert(type(name) == "string", "param 1 must be a string!")

  local group = {}
  setmetatable(group, class)
  group.name = name
  group.radioButtons = {}
  Library.LibSimpleWidgets.EventProxy(group, { "RadioButtonChange" })
  return group
end
