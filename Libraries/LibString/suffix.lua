--- Check whether a string is a suffix of self.
-- @param s The suffix string to check for.
-- @return True if self ends with s, otherwise false.
-- @usage string.suffix("abcdef", "def")
-- returns true
-- @usage string.suffix("abcdef", "e")
-- returns false
function string:suffix(s)
	local pos = #self - #s + 1
	local index = string.find(self, s, pos, true)
	return index ~= nil and index == pos
end
