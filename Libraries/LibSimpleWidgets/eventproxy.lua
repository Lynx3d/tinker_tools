function Library.LibSimpleWidgets.EventProxy(frame, eventNames)
  local newEventTable = {}
  local eventNameLookup = {}
  for i, v in ipairs(eventNames) do
    eventNameLookup[v] = true
  end

  local originalEventTable = frame.Event

  setmetatable(newEventTable, {
    __index = function(t, k)
      if eventNameLookup[k] then
        return rawget(t, k)
      elseif originalEventTable then
        return originalEventTable[k]
      else
        error("Invalid event: "..k)
      end
    end,
    __newindex = function(t, k, v)
      if eventNameLookup[k] then
        rawset(t, k, v)
      elseif originalEventTable then
        originalEventTable[k] = v
      else
        error("Invalid event: "..k)
      end
    end
  })

  frame.Event = newEventTable
end
