--- Concatenate a list of strings or numbers.
-- @param ... A variable number of string or number arguments to be concatenated.
-- @return The concatenated string.
-- @usage string.concat("abcde", 3, "xxx")
-- returns "abcde3xxx"
function string.concat(...)
	return table.concat({ ... })
end
