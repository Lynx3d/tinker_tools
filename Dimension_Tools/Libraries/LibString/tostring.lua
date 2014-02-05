local tostring = tostring

--- Convert a list of arguments to strings.
-- @param ... A variable number of arbitrary values.
-- @return The arguments converted to strings in the same order as they were passed to the function.
-- @usage string.tostring(1, { }, nil, true)
-- returns "1", "table: 0xDEADBEEF", "nil", "true"
function string.tostring(...)
	local result = { ... }
	for i = 1, select("#", ...) do
		result[i] = tostring(result[i])
	end
	return unpack(result)
end
