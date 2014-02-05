--- Check whether a string is a prefix of self.
-- @param s The prefix string to check for.
-- @return True if self begins with s, otherwise false.
-- @usage string.prefix("abcdef", "abc")
-- returns true
-- @usage string.prefix("abcdef", "b")
-- returns false
function string:prefix(s)
	local pos = string.find(self, s, 1, true)
	return pos ~= nil and pos == 1
end
