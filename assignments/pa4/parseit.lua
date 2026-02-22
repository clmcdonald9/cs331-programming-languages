-- parseit.lua
-- Crysta McDonald
-- Started 2/21/26
-- Built for CS 331 spring 2026 assignment 4

-- Acknowledgement:
-- This parser was written using a modified version of 
-- Glenn G. Chappell's parser.lua skeleton.


local lexit = require "lexit"

local parseit = {}

-------------- Variables ---------------

-- Lexer iteration --
local iter
local state
local lexOutS
local lexOutC

-- about current lexeme --
local lexeme
local lexCategory
-------------- Functions ---------------

local function nextLexme()
    lexOutS, lexOutC  = iter()

    if lexOutS then
        lexeme, lexCategory = lexOutS, lexOutC
    else
        lexeme, lexCategory = "", 0
    end

end

local function init(program)
    iter, state, lexOutS= lexit.lex(program)
    nextLexme()
end

---
function parseit.parse(program)

end

return parseit
