local strfind = string.find
local strsub = string.sub

--- Split a string into substrings according to a provided separator.
-- @param sep The separator string.
-- @param patterned If this parameter evaluates to true the separation is performed on search patterns, otherwise plain strings.
-- @return A table with all strings as values in the order they were found.
-- @usage string.split("/a:b/c:d/:", ":")
-- returns { "/a", "b/c", "d/", "" }
-- @usage string.split("/a:b/c:d/:", "[:/]", true)
-- returns { "", "a", "b", "c", "d", "", "" }
-- @usage string.split("/a:b/c:d/:", "[:/]")
-- returns { "/a:b/c:d/:" }
function string:split(sep, patterned)
	local list = {}
	local pos = 1
	if(strfind("", sep, 1)) then -- this would result in endless loops
		error("delimiter matches empty string!", 2)
	end
	while 1 do
		local first, last = strfind(self, sep, pos, not patterned)
		if(first) then -- found?
			list[#list + 1] = strsub(self, pos, first - 1)
			pos = last + 1
		else
			list[#list + 1] = strsub(self, pos)
			break
		end
	end
	return list
end

--- Return an iterator for splitting a string into substrings according to a provided separator.
-- @param sep The separator string.
-- @param patterned If this parameter evaluates to true the separation is performed on search patterns, otherwise plain strings.
-- @return An iterator function to be used in for loops
-- @usage for s, sep in string.gsplit(",a,b/c:d/", "[,/:]", true) do
--     print(s, sep)
--     print("----")
-- end
-- prints the lines
-- > 	,
-- > ----
-- > a	,
-- > ----
-- > b	/
-- > ----
-- > c	:
-- > ----
-- > d	/
-- > ----
-- > 	
-- > ----
function string:gsplit(sep, patterned)
	if(strfind("", sep, 1)) then -- this would result in endless loops
		error("delimiter matches empty string!", 2)
	end

	local len = string.len(self)
	local pos = 1
	return function()
		local first, last = strfind(self, sep, pos, not patterned)
		if(first) then -- found?
			local s1 = strsub(self, pos, first - 1)
			local s2 = strsub(self, first, last)
			pos = last + 1
			return s1, s2
		elseif(pos <= (len + 1)) then
			local s = strsub(self, pos)
			pos = len + 2
			return s, ""
		end
	end
end
