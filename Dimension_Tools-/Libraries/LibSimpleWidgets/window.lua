-- Helper Functions

local function AddDragEventsToBorder(window)
  local border = window:GetBorder()
  function border.Event:LeftDown()
    self.leftDown = true
    local mouse = Inspect.Mouse()
    self.originalXDiff = mouse.x - self:GetLeft()
    self.originalYDiff = mouse.y - self:GetTop()
    local left, top, right, bottom = window:GetBounds()
    window:ClearAll()
    window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left, top)
    window:SetWidth(right-left)
    window:SetHeight(bottom-top)
  end
  function border.Event:LeftUp()
    self.leftDown = false
  end
  function border.Event:LeftUpoutside()
    self.leftDown = false
  end
  function border.Event:MouseMove(x, y)
    if not self.leftDown then
      return
    end
    window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - self.originalXDiff, y - self.originalYDiff)
  end
end

local function AddDragFrame(window)
  window.dragWindow = UI.CreateFrame("Frame", window:GetName().."Drag", window:GetBorder())
  window.dragWindow:SetAllPoints(window)
  function window.dragWindow.Event:LeftDown()
    self.leftDown = true
    local mouse = Inspect.Mouse()
    self.originalXDiff = mouse.x - self:GetLeft()
    self.originalYDiff = mouse.y - self:GetTop()
    local left, top, right, bottom = window:GetBounds()
    window:ClearAll()
    window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left, top)
    window:SetWidth(right-left)
    window:SetHeight(bottom-top)
  end

  function window.dragWindow.Event:LeftUp()
    self.leftDown = false
  end

  function window.dragWindow.Event:LeftUpoutside()
    self.leftDown = false
  end

  function window.dragWindow.Event:MouseMove(x, y)
    if not self.leftDown then
      return
    end
    window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x - self.originalXDiff, y - self.originalYDiff)
  end
end

-- Public Functions

local function SetCloseButtonVisible(self, visible)
  assert(type(visible) == "boolean", "param 1 must be a boolean!")

  if visible then
    if self.closeButton then
      self.closeButton:SetVisible(true)
    else
      local closeButton = UI.CreateFrame("RiftButton", self:GetName().."CloseButton", self)
      closeButton:SetSkin("close")
      closeButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", -8, 15)
      function closeButton.Event:LeftPress()
        local window = self:GetParent()
        window:SetVisible(false)
        if window.Event.Close then
          window.Event.Close(window)
        end
      end
      self.closeButton = closeButton
    end
  elseif self.closeButton then
    self.closeButton:SetVisible(false)
  end
end

-- Constructor Function

function Library.LibSimpleWidgets.Window(name, parent)
  local window = UI.CreateFrame("RiftWindow", name, parent)
  if not pcall(AddDragEventsToBorder, window) then
    AddDragFrame(window)
  end

  window.SetCloseButtonVisible = SetCloseButtonVisible

  Library.LibSimpleWidgets.EventProxy(window, {"Close"})

  return window
end
