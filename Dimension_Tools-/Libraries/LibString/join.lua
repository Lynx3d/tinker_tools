--- Concatenate a list of strings or numbers and insert delimeters between each.
-- @param sep The separator string
-- @param ... A variable number of string or number arguments to be concatenated.
-- @return The concatenated string.
-- @usage string.join(":", "a", "b", "c")
-- returns "a:b:c:d"
function string.join(sep, ...)
	return table.concat({ ... }, sep)
end
