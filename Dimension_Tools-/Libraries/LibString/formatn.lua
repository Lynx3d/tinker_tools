local select = select
local tinsert = table.insert
local tonumber = tonumber

--- Same as string.format but accepts index specifiers in format string.
-- Extends the functionality of string.format with additional index specifiers.
-- This can be used to index the format arguments out-of-order and and is not limited to one digit.
-- There is currently one known issue:
--
-- ##string.formatn("%%%s")## is not correctly detected and causes the argument numbering to skip an increment.
-- @param fmt The format string.
-- @param ... A variable number of string or number arguments.
-- @return The formatted string.
-- @usage string.formatn("%s, %1s, %10i, %i", "abc", 2, 3, 4, 5, 6, 7, 8, 9, 10)
-- returns "abc, abc, 10, 4"
function string.formatn(fmt, ...)
	local args = { }
	local index = 1
	local len = select("#", ...)
	for marker, n in string.gmatch(fmt, "(%%(%d*)%a)") do
		n = tonumber(n)
		if(n) then
			if(n < 1 or n > len) then
				error("Argument index " .. n .. " out of range in format string.", 2)
			end
			tinsert(args, (select(n, ...)))
		else
			tinsert(args, (select(index, ...)))
		end
		index = index + 1
	end
	return string.format(string.gsub(fmt, "%%%d*(%a)", "%%%1"), unpack(args))
end
