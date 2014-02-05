--- Insert a string at the specified position.
-- The string is inserted before the specified index. That means if index is 5 then the string is inserted between characters 4 and 5.
-- If index is greater than the length of self the string is appended at the end. If index is smaller than 1 the string is inserted at the front.
-- @param index The index of the character before which the string should be inserted.
-- @param s The stirng to be inserted.
-- @return The concatenated string.
-- @usage string.insert("abcde", 3, "xxx")
-- returns "abxxxcde"
function string:insert(index, s)
	if(index <= 1) then
		return s .. self
	elseif(index > #self) then
		return self .. s
	else
		return string.sub(self, 1, index - 1) .. s .. string.sub(self, index)
	end
end
