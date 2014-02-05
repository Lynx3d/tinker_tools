local function f(self, fmt, chars)
	if(chars) then
		return (string.gsub(self, string.format(fmt, chars, chars), "%1"))
	else
		return (string.gsub(self, fmt, "%1"))
	end
end

--- Trim the string by removing characters on both ends.
-- This optional argument string is inserted into the pattern of string.gsub and can be any valid pattern allowed inside the [] set specifiers.
-- For example "abc,", "a-z", "%p", "^0-9" and so on. Remember to escape the magic characters $()%.[]*+-? (and ^ if not meant as inversion) with the % sign.
-- @param chars An optional string which determines the characters to be removed.
-- @return The trimmed string.
-- @usage string.trim("   abc   ")
-- returns "abc"
-- @usage string.trim("0123abc4567", "0-7")
-- retuns "abc"
function string:trim(chars)
	return f(self, "^[%s]*(.-)[%s]*$", chars)
end

--- Trim the string by removing characters from the beginning.
-- This optional argument string is inserted into the pattern of string.gsub and can be any valid pattern allowed inside the [] set specifiers.
-- For example "abc,", "a-z", "%p", "^0-9" and so on. Remember to escape the magic characters $()%.[]*+-? (and ^ if not meant as inversion) with the % sign.
-- @param chars An optional string which determines the characters to be removed.
-- @return The trimmed string.
-- @usage string.ltrim("   abc   ")
-- returns "abc   "
-- @usage string.ltrim("0123abc4567", "0-7")
-- retuns "abc4567"
function string:ltrim(chars)
	return f(self, "^[%s]*(.-)$", chars)
end

--- Trim the string by removing characters from the end.
-- This optional argument string is inserted into the pattern of string.gsub and can be any valid pattern allowed inside the [] set specifiers.
-- For example "abc,", "a-z", "%p", "^0-9" and so on. Remember to escape the magic characters $()%.[]*+-? (and ^ if not meant as inversion) with the % sign.
-- @param chars An optional string which determines the characters to be removed.
-- @return The trimmed string.
-- @usage string.rtrim("   abc   ")
-- returns "   abc"
-- @usage string.rtrim("0123abc4567", "0-7")
-- retuns "0123abc"
function string:rtrim(chars)
	return f(self, "^(.-)[%s]*$", chars)
end
