-- lexit.lua
-- Crysta McDonald
-- 2/13/26
-- a lua module for lexical analysis

-- Acknowledgment:
-- Professor Glenn G. Chappell's in-class lexer.lua was used as
-- a  framework for the design of lexit.lua
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
    -- Variables
    local position
    local currentLexeme

    -- States
    local START = 1
    local DONE = 2
    

    -- Character functions
    local function currentChar()
        return str:sub(position,position)
    end

    local function nextChar()
        return str:sub(position+1, position+1)
    end

    local function nextPosition()
        position = position + 1
    end

    local function handle_DONE()
      --no
    end
    local function handle_START()
        state = DONE
        nextPosition()
    end

    local handlers = {
        [DONE] = handle_DONE,
        [START] = handle_START,
        
    }

    return coroutine.wrap(function()
        position = 1

        while true do
            if position > str:len() then
                return nil
            end

            currentLexeme = ""
            state = START

            while state ~= DONE do
                char = currentChar()
                handlers[state]()

            end
        end
    end)

end

return lexit