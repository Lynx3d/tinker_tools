local temp

assert(string.concat("123", "1", "true", "nil", "x") == "1231truenilx")

assert(string.formatn("%s, %1s, %10i, %i", "abc", 2, 3, 4, 5, 6, 7, 8, 9, 10) == "abc, abc, 10, 4")

assert(string.insert("abcde", 3, "xxx") == "abxxxcde")
assert(string.insert("abcde", 0, "xxx") == "xxxabcde")
assert(string.insert("abcde", 10, "xxx") == "abcdexxx")

assert(string.join(":", "a", "b", "c", "d") == "a:b:c:d")

assert(string.prefix("abcdef", "abc") == true)
assert(string.prefix("abcdef", "bc") == false)

temp = string.split(":a:b:c:d:", ":")
assert(#temp == 6 and temp[1] == "" and temp[2] == "a" and temp[3] == "b" and temp[4] == "c" and temp[5] == "d" and temp[6] == "")

assert(string.suffix("abcdef", "def") == true)
assert(string.suffix("abcdef", "de") == false)

temp = { string.tostring(1, "abc", nil, true) }
assert(#temp == 4 and temp[1] == "1" and temp[2] == "abc" and temp[3] == "nil" and temp[4] == "true")

assert(string.trim("   abc   ") == "abc")
assert(string.trim("0123abc4567", "0-7") == "abc")
assert(string.ltrim("   abc   ") == "abc   ")
assert(string.ltrim("0123abc4567", "0-7") == "abc4567")
assert(string.rtrim("   abc   ") == "   abc")
assert(string.rtrim("0123abc4567", "0-7") == "0123abc")
