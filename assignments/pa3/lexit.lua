-- lexit.lua
-- Crysta McDonald
-- 2/13/26
-- a lua module for lexical analysis

-- Acknowledgment:
-- Professor Glenn G. Chappell's in-class lexer.lua was used as
-- a guide for the design of lexer.lua
-- This implementation was written to satisfy assignment 3
-- Tamandua lexical specification.

lexit = {} -- Module

--Constants: lexeme categories
lexit.KEY = 1
lexit.ID = 2
lexit.NUMLIT = 3
lexit.STRLIT = 4
lexit.OP = 5
lexit.PUNCT = 6
lexit.MAL = 7

-- lexeme category names
lexit.catnames = {
    "Keyword",
    "Identifier",
    "NumericLiteral",
    "StringLiteral",
    "Operator",
    "Punctuation",
    "Malformed"
}

function lexit.lex(str)

end

return lexit