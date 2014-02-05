local function whichBorders(borders)
  local t = string.find(borders, "t") ~= nil
  local b = string.find(borders, "b") ~= nil
  local l = string.find(borders, "l") ~= nil
  local r = string.find(borders, "r") ~= nil
  return t, b, l, r
end

function Library.LibSimpleWidgets.SetBorder(...)
  if type(select(1, ...)) == "string" then
    -- new-style argument list: type, frame, ...
    local borderType = select(1, ...)
    local frame = select(2, ...)

    local border = frame.__lsw_border

    if border == nil or border.type ~= borderType then
      if border then
        border:Destroy()
      end
      border = Library.LibSimpleWidgets.CreateBorder(...)
    elseif borderType == "plain" then
      local _, _, width, r, g, b, a, borders = ...

      -- defaults
      width = width or 1
      r = r or 0
      g = g or 0
      b = b or 0
      a = a or 0
      borders = borders or "tblr"

      -- update plain border settings
      border:SetWidth(width)
      border:SetColors(borders, r, g, b, a)
      border:SetVisibleBorders(borders)
    end

    -- rounded and tooltip types have no further args
    frame.__lsw_border = border
  elseif type(select(1, ...)) == "table" then
    -- old-style argument list -- plain border only
    local frame, width, r, g, b, a, borders = ...

    -- defaults
    width = width or 1
    r = r or 0
    g = g or 0
    b = b or 0
    a = a or 0
    borders = borders or "tblr"

    local border = frame.__lsw_border

    if border == nil or border.type ~= "plain" then
      if border then
        border:Destroy()
      end
      border = Library.LibSimpleWidgets.CreateBorder("plain", frame, width, r, g, b, a)
      border:SetVisibleBorders(borders)
    else
      border:SetWidth(width)
      border:SetColors(borders, r, g, b, a)
      border:SetVisibleBorders(borders)
    end

    frame.__lsw_border = border
  else
    error("Invalid arguments to SetBorder")
  end
end

local class = {}
class.__index = class

function class:Init(borderType, owner, ...)
  self.type = borderType
  self.owner = owner

  local createFrames = self["CreateFrames_".. borderType]
  if createFrames == nil then
    error("Invalid border type: ".. borderType)
  end

  createFrames(self, ...)

  -- Hook SetVisible so we can do the same on the borders
  self.OrigSetVisible = owner.SetVisible
  local border = self
  function owner:SetVisible(visible)
    border.OrigSetVisible(owner, visible)
    if visible then
      -- preserve original border visibility
      border:SetVisibleBorders(border.visibleBorders)
    else
      border:HideBorders()
    end
  end
end

function class:Destroy()
  -- Unhook SetVisible
  if self.OrigSetVisible then
    self.owner.SetVisible = self.OrigSetVisible
  end

  -- Hide border
  self:HideBorders()

  -- Release/recycle frames?
  self.owner.__lsw_border = nil
end

function class:CreateFrames_plain(width, r, g, b, a, borders)
  local nameBase = self.owner:GetName()
  local parent = self.owner:GetParent()
  self.top = UI.CreateFrame("Frame", nameBase .."_TopBorder", parent)
  self.bottom = UI.CreateFrame("Frame", nameBase .."_BottomBorder", parent)
  self.left = UI.CreateFrame("Frame", nameBase .."_LeftBorder", parent)
  self.right = UI.CreateFrame("Frame", nameBase .."_RightBorder", parent)

  self.width = width or 1
  self.position = "outside"
  self:Layout()

  if r ~= nil then
    self:SetColors("tblr", r, g, b, a)
  end

  if borders ~= nil then
    self:SetVisibleBorders(borders)
  end
end

function class:CreateFrames_rounded()
  local nameBase = self.owner:GetName()
  local parent = self.owner:GetParent()

  self.top = UI.CreateFrame("Texture", nameBase .."_TopBorder", parent)
  self.bottom = UI.CreateFrame("Texture", nameBase .."_BottomBorder", parent)
  self.left = UI.CreateFrame("Texture", nameBase .."_LeftBorder", parent)
  self.right = UI.CreateFrame("Texture", nameBase .."_RightBorder", parent)
  self.topleft = UI.CreateFrame("Texture", nameBase .."_TopLeftBorder", parent)
  self.topright = UI.CreateFrame("Texture", nameBase .."_TopRightBorder", parent)
  self.bottomleft = UI.CreateFrame("Texture", nameBase .."_BottomLeftBorder", parent)
  self.bottomright = UI.CreateFrame("Texture", nameBase .."_BottomRightBorder", parent)

  self.top:SetTexture("LibSimpleWidgets", "textures/rounded_top.png")
  self.bottom:SetTexture("LibSimpleWidgets", "textures/rounded_bottom.png")
  self.left:SetTexture("LibSimpleWidgets", "textures/rounded_left.png")
  self.right:SetTexture("LibSimpleWidgets", "textures/rounded_right.png")
  self.topleft:SetTexture("LibSimpleWidgets", "textures/rounded_topleft.png")
  self.topright:SetTexture("LibSimpleWidgets", "textures/rounded_topright.png")
  self.bottomleft:SetTexture("LibSimpleWidgets", "textures/rounded_bottomleft.png")
  self.bottomright:SetTexture("LibSimpleWidgets", "textures/rounded_bottomright.png")

  self.width = math.max(self.top:GetHeight(), self.left:GetWidth())
  self.position = "outside"
  self:Layout()
end

function class:CreateFrames_tooltip()
  local nameBase = self.owner:GetName()
  local parent = self.owner:GetParent()

  self.top = UI.CreateFrame("Texture", nameBase .."_TopBorder", parent)
  self.bottom = UI.CreateFrame("Texture", nameBase .."_BottomBorder", parent)
  self.left = UI.CreateFrame("Texture", nameBase .."_LeftBorder", parent)
  self.right = UI.CreateFrame("Texture", nameBase .."_RightBorder", parent)
  self.topleft = UI.CreateFrame("Texture", nameBase .."_TopLeftBorder", parent)
  self.topright = UI.CreateFrame("Texture", nameBase .."_TopRightBorder", parent)
  self.bottomleft = UI.CreateFrame("Texture", nameBase .."_BottomLeftBorder", parent)
  self.bottomright = UI.CreateFrame("Texture", nameBase .."_BottomRightBorder", parent)

  self.top:SetTexture("LibSimpleWidgets", "textures/tooltip_top.png")
  self.bottom:SetTexture("LibSimpleWidgets", "textures/tooltip_bottom.png")
  self.left:SetTexture("LibSimpleWidgets", "textures/tooltip_left.png")
  self.right:SetTexture("LibSimpleWidgets", "textures/tooltip_right.png")
  self.topleft:SetTexture("LibSimpleWidgets", "textures/tooltip_topleft.png")
  self.topright:SetTexture("LibSimpleWidgets", "textures/tooltip_topright.png")
  self.bottomleft:SetTexture("LibSimpleWidgets", "textures/tooltip_bottomleft.png")
  self.bottomright:SetTexture("LibSimpleWidgets", "textures/tooltip_bottomright.png")

  self.position = "outside"
  self.width = math.max(self.top:GetHeight(), self.left:GetWidth())
  self:Layout()
end

function class:SetWidth(width)
  if self.type ~= "plain" then
    error("width can only be set for plain borders")
  end

  self.width = width
  self:Layout()
end

function class:SetVisibleBorders(borders)
  if self.type == "plain" then
    self.visibleBorders = borders

    local bt, bb, bl, br = whichBorders(borders)

    local ownerVisible = self.owner:GetVisible()
    self.top:SetVisible(bt and ownerVisible)
    self.bottom:SetVisible(bb and ownerVisible)
    self.left:SetVisible(bl and ownerVisible)
    self.right:SetVisible(br and ownerVisible)
  elseif self.type == "rounded" or self.type == "tooltip" then
    self.top:SetVisible(true)
    self.bottom:SetVisible(true)
    self.left:SetVisible(true)
    self.right:SetVisible(true)
    self.topleft:SetVisible(true)
    self.topright:SetVisible(true)
    self.bottomleft:SetVisible(true)
    self.bottomright:SetVisible(true)
  end
end

function class:HideBorders()
  if self.type == "plain" then
    self.top:SetVisible(false)
    self.bottom:SetVisible(false)
    self.left:SetVisible(false)
    self.right:SetVisible(false)
  elseif self.type == "rounded" or self.type == "tooltip" then
    self.top:SetVisible(false)
    self.bottom:SetVisible(false)
    self.left:SetVisible(false)
    self.right:SetVisible(false)
    self.topleft:SetVisible(false)
    self.topright:SetVisible(false)
    self.bottomleft:SetVisible(false)
    self.bottomright:SetVisible(false)
  end
end

function class:SetColors(borders, r, g, b, a)
  if self.type ~= "plain" then
    error("colors can only be set for plain borders")
  end

  a = a or 1 -- default alpha to 1

  local bt, bb, bl, br = whichBorders(borders)

  if bt then
    self.top:SetBackgroundColor(r, g, b, a)
  end

  if bb then
    self.bottom:SetBackgroundColor(r, g, b, a)
  end

  if bl then
    self.left:SetBackgroundColor(r, g, b, a)
  end

  if br then
    self.right:SetBackgroundColor(r, g, b, a)
  end
end

function class:SetPosition(position)
  self.position = position
  self:Layout()
end

function class:Layout()
  local owner = self.owner
  local ownerLayer = owner:GetLayer()

  if self.position == "outside" then
    if self.type == "plain" then
      local width = self.width

      self.top:SetLayer(ownerLayer)
      self.bottom:SetLayer(ownerLayer)
      self.left:SetLayer(ownerLayer)
      self.right:SetLayer(ownerLayer)

      self.top:ClearAll()
      self.top:SetPoint("BOTTOMLEFT", owner, "TOPLEFT", -width, 0)
      self.top:SetPoint("BOTTOMRIGHT", owner, "TOPRIGHT", width, 0)
      self.top:SetHeight(width)

      self.bottom:ClearAll()
      self.bottom:SetPoint("TOPLEFT", owner, "BOTTOMLEFT", -width, 0)
      self.bottom:SetPoint("TOPRIGHT", owner, "BOTTOMRIGHT", width, 0)
      self.bottom:SetHeight(width)

      self.left:ClearAll()
      self.left:SetPoint("TOPRIGHT", owner, "TOPLEFT", 0, -width)
      self.left:SetPoint("BOTTOMRIGHT", owner, "BOTTOMLEFT", 0, width)
      self.left:SetWidth(width)

      self.right:ClearAll()
      self.right:SetPoint("TOPLEFT", owner, "TOPRIGHT", 0, -width)
      self.right:SetPoint("BOTTOMLEFT", owner, "BOTTOMRIGHT", 0, width)
      self.right:SetWidth(width)
    elseif self.type == "rounded" or self.type == "tooltip" then
      self.top:SetLayer(ownerLayer)
      self.bottom:SetLayer(ownerLayer)
      self.left:SetLayer(ownerLayer)
      self.right:SetLayer(ownerLayer)
      self.topleft:SetLayer(ownerLayer)
      self.topright:SetLayer(ownerLayer)
      self.bottomleft:SetLayer(ownerLayer)
      self.bottomright:SetLayer(ownerLayer)

      self.top:ClearAll()
      self.top:SetPoint("BOTTOMLEFT", owner, "TOPLEFT", 0, 0)
      self.top:SetPoint("BOTTOMRIGHT", owner, "TOPRIGHT", 0, 0)

      self.bottom:ClearAll()
      self.bottom:SetPoint("TOPLEFT", owner, "BOTTOMLEFT", 0, 0)
      self.bottom:SetPoint("TOPRIGHT", owner, "BOTTOMRIGHT", 0, 0)

      self.left:ClearAll()
      self.left:SetPoint("TOPRIGHT", owner, "TOPLEFT", 0, 0)
      self.left:SetPoint("BOTTOMRIGHT", owner, "BOTTOMLEFT", 0, 0)

      self.right:ClearAll()
      self.right:SetPoint("TOPLEFT", owner, "TOPRIGHT", 0, 0)
      self.right:SetPoint("BOTTOMLEFT", owner, "BOTTOMRIGHT", 0, 0)

      self.topleft:ClearAll()
      self.topleft:SetPoint("BOTTOMRIGHT", owner, "TOPLEFT", 0, 0)

      self.topright:ClearAll()
      self.topright:SetPoint("BOTTOMLEFT", owner, "TOPRIGHT", 0, 0)

      self.bottomleft:ClearAll()
      self.bottomleft:SetPoint("TOPRIGHT", owner, "BOTTOMLEFT", 0, 0)

      self.bottomright:ClearAll()
      self.bottomright:SetPoint("TOPLEFT", owner, "BOTTOMRIGHT", 0, 0)
    end
  elseif self.position == "inside" then
    local insideLayer = ownerLayer+1
    if self.type == "plain" then
      local width = self.width

      self.top:SetLayer(insideLayer)
      self.bottom:SetLayer(insideLayer)
      self.left:SetLayer(insideLayer)
      self.right:SetLayer(insideLayer)

      self.top:ClearAll()
      self.top:SetPoint("TOPLEFT", owner, "TOPLEFT", 0, 0)
      self.top:SetPoint("TOPRIGHT", owner, "TOPRIGHT", 0, 0)
      self.top:SetHeight(width)

      self.bottom:ClearAll()
      self.bottom:SetPoint("BOTTOMLEFT", owner, "BOTTOMLEFT", 0, 0)
      self.bottom:SetPoint("BOTTOMRIGHT", owner, "BOTTOMRIGHT", 0, 0)
      self.bottom:SetHeight(width)

      self.left:ClearAll()
      self.left:SetPoint("TOPLEFT", owner, "TOPLEFT", 0, 0)
      self.left:SetPoint("BOTTOMLEFT", owner, "BOTTOMLEFT", 0, 0)
      self.left:SetWidth(width)

      self.right:ClearAll()
      self.right:SetPoint("TOPRIGHT", owner, "TOPRIGHT", 0, 0)
      self.right:SetPoint("BOTTOMRIGHT", owner, "BOTTOMRIGHT", 0, 0)
      self.right:SetWidth(width)
    elseif self.type == "rounded" or self.type == "tooltip" then
      self.top:SetLayer(insideLayer)
      self.bottom:SetLayer(insideLayer)
      self.left:SetLayer(insideLayer)
      self.right:SetLayer(insideLayer)
      self.topleft:SetLayer(insideLayer)
      self.topright:SetLayer(insideLayer)
      self.bottomleft:SetLayer(insideLayer)
      self.bottomright:SetLayer(insideLayer)

      self.top:ClearAll()
      self.top:SetPoint("TOPLEFT", owner, "TOPLEFT", self.topleft:GetWidth(), 0)
      self.top:SetPoint("TOPRIGHT", owner, "TOPRIGHT", -self.topright:GetWidth(), 0)

      self.bottom:ClearAll()
      self.bottom:SetPoint("BOTTOMLEFT", owner, "BOTTOMLEFT", self.bottomleft:GetWidth(), 0)
      self.bottom:SetPoint("BOTTOMRIGHT", owner, "BOTTOMRIGHT", -self.bottomright:GetWidth(), 0)

      self.left:ClearAll()
      self.left:SetPoint("TOPLEFT", owner, "TOPLEFT", 0, self.topleft:GetHeight())
      self.left:SetPoint("BOTTOMLEFT", owner, "BOTTOMLEFT", 0, -self.bottomleft:GetHeight())

      self.right:ClearAll()
      self.right:SetPoint("TOPRIGHT", owner, "TOPRIGHT", 0, self.topright:GetHeight())
      self.right:SetPoint("BOTTOMRIGHT", owner, "BOTTOMRIGHT", 0, -self.bottomright:GetHeight())

      self.topleft:ClearAll()
      self.topleft:SetPoint("TOPLEFT", owner, "TOPLEFT", 0, 0)

      self.topright:ClearAll()
      self.topright:SetPoint("TOPRIGHT", owner, "TOPRIGHT", 0, 0)

      self.bottomleft:ClearAll()
      self.bottomleft:SetPoint("BOTTOMLEFT", owner, "BOTTOMLEFT", 0, 0)

      self.bottomright:ClearAll()
      self.bottomright:SetPoint("BOTTOMRIGHT", owner, "BOTTOMRIGHT", 0, 0)
    end
  else
    error("invalid border position: "..tostring(self.position))
  end
end

function Library.LibSimpleWidgets.CreateBorder(borderType, frame, ...)
  assert(type(borderType) == "string", "param 1 must be a string!")
  assert(type(frame) == "table" and frame.SetPoint, "param 2 must be a frame!")

  local obj = {}
  setmetatable(obj, class)
  obj:Init(borderType, frame, ...)
  return obj
end
