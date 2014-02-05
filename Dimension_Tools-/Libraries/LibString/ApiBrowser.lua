do

local symbols = { }

symbols["string.concat"] = {
	summary = "Concatenate a list of strings or numbers.",
	signatures = {
		"str = string.concat(...) -- string <- ...",
	},
	parameter = {
		["..."] = "A variable list of strings or numbers to be concatenated.",
	},
	result = {
		["str"] = "The resulting string.",
	},
}

symbols["string.formatn"] = {
	summary = [[
Same as string.format but supports index specifiers in format string.
This can be used to index the format arguments out-of-order and is not limited to one digit.
There is currently one known issue:
string.formatn("%%%s") is not correctly detected and causes the argument numbering to skip an increment.]],
	signatures = {
		"str = string.formatn(fmt, ...) -- string <- string, ...",
	},
	parameter = {
		["..."] = "A variable list of strings or numbers to be concatenated.",
		["fmt"] = [[Same format string as accepted by string.format, with the additional support for index specifiers of the form "%5s" or "%10i".]],
	},
	result = {
		["str"] = "The resulting string.",
	},
}

symbols["string.gsplit"] = {
	summary = "Get an iterator for splitting a string into substrings according to a provided separator.",
	signatures = {
		"iterator = string.gsplit(str, sep) -- function <- string, string",
		"iterator = string.gsplit(str, sep, patterned) -- function <- string, string, boolean",
	},
	parameter = {
		["str"] = "The string to be split.",
		["sep"] = "The string acting as separator.",
		["patterned"] = "true to treat sep as a regular expressions, otherwise plain.",
	},
	result = {
		["iterator"] = [[
An iterator function suitable to be used in a for loop. On each iteration it returns two values: the substring from the split and the separator following it.
for str, sep in string.gsplit(...) do ... end.]],
	},
}

symbols["string.insert"] = {
	summary = "Insert a string into another at the specified index.",
	signatures = {
		"str = string.concat(str, index, insert) -- string <- string, number, string",
	},
	parameter = {
		["str"] = "The string into which to insert.",
		["index"] = "The character index before which to insert. If index is 5 then the string is inserted between characters 4 and 5. If index is greater than the length of str the string is appended at the end. If index is smaller than 1 the string is inserted at the front.",
		["insert"] = "The string to be inserted.",
	},
	result = {
		["str"] = "The resulting string.",
	},
}

symbols["string.join"] = {
	summary = "Concatenate a list of strings or numbers and insert delimeters between each.",
	signatures = {
		"str = string.join(sep, ...) -- string <- string, ...",
	},
	parameter = {
		["sep"] = "A string to be inserted between the joined strings.",
		["..."] = "A variable list of strings or numbers to be joined.",
	},
	result = {
		["str"] = "The resulting string.",
	},
}

symbols["string.ltrim"] = {
	summary = "Trim a string by removing characters from its beginning.",
	signatures = {
		"str = string.ltrim(str) -- string <- string",
		"str = string.ltrim(str, pattern) -- string <- string, string",
	},
	parameter = {
		["str"] = "The string to be trimmed.",
		["pattern"] = [[Any pattern which can be inserted into the regex bracket syntax. If given the string "a-s" removes characters with the pattern "[a-s]*". Defaults to "%s" if absent.]],
	},
	result = {
		["str"] = "The input string trimmed of any characters from its beginning which matched the pattern.",
	},
}

symbols["string.prefix"] = {
	summary = "Check whether a string is a prefix of another.",
	signatures = {
		"result = string.prefix(str, prefix) -- boolean <- string, string"
	},
	parameter = {
		["str"] = "The string to be searched.",
		["prefix"] = "The string to be searched for.",
	},
	result = {
		["result"] = "true if str starts with prefix.",
	},
}

symbols["string.rtrim"] = {
	summary = "Trim a string by removing characters from its end.",
	signatures = {
		"str = string.rtrim(str) -- string <- string",
		"str = string.rtrim(str, pattern) -- string <- string, string",
	},
	parameter = {
		["str"] = "The string to be trimmed.",
		["pattern"] = [[Any pattern which can be inserted into the regex bracket syntax. If given the string "a-s" removes characters with the pattern "[a-s]*". Defaults to "%s" if absent.]],
	},
	result = {
		["str"] = "The input string trimmed of any characters from its end which matched the pattern.",
	},
}

symbols["string.split"] = {
	summary = "Split a string into substrings according to a provided separator.",
	signatures = {
		"strings = string.split(str, sep) -- table <- string, string",
		"strings = string.split(str, sep, patterned) -- table <- string, string, boolean",
	},
	parameter = {
		["str"] = "The string to be split.",
		["sep"] = "The string acting as separator.",
		["patterned"] = "true to treat sep as a regular expressions, otherwise plain.",
	},
	result = {
		["strings"] = "A table containing the substrings in array form in the order they were found.",
	},
}

symbols["string.suffix"] = {
	summary = "Check whether a string is a suffix of another.",
	signatures = {
		"result = string.suffix(str, suffix) -- boolean <- string, string",
	},
	parameter = {
		["str"] = "The string to be searched.",
		["suffix"] = "The string to be searched for.",
	},
	result = {
		["result"] = "true if str ends with suffix.",
	},
}

symbols["string.tostring"] = {
	summary = "Convert a list of arguments to a list of strings.",
	signatures = {
		"... = string.tostring(...) -- ... <- ...",
	},
	parameter = {
		["..."] = "A variable list of values to be converted to strings.",
	},
	result = {
		["..."] = "All parameters converted to strings, preserving order and count.",
	},
}

symbols["string.trim"] = {
	summary = "Trim a string by removing characters on both ends.",
	signatures = {
		"str = string.trim(str) -- string <- string",
		"str = string.trim(str, pattern) -- string <- string, string",
	},
	parameter = {
		["str"] = "The string to be trimmed.",
		["pattern"] = [[Any pattern which can be inserted into the regex bracket syntax. If given the string "a-s" removes characters with the pattern "[a-s]*". Defaults to "%s" if absent.]],
	},
	result = {
		["str"] = "The input string trimmed of any characters from its beginning and end which matched the pattern.",
	},
}

LibString = {
	ApiBrowserIndex = symbols,
	ApiBrowserInspect = function(path) return symbols[path] end,
	ApiBrowserSummary = [[LibString adds the following utility methods to Lua's <font color="#dbce9b">string</font> metatable. Therefore they can be used exactly like the bult-in Lua string functions and do not require any additional setup.]],
}

end