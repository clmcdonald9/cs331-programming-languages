-- lexit.lua
-- Crysta McDonald
-- 2/13/26
-- a lua module for lexical analysis

-- Acknowledgment:
-- lexit.lua is based on Professor Glenn G. Chappell's in-class
-- example, lexer.lua. Specifically, I reused  the
-- state-machine structure, the coroutine-iterator, and the character
-- classification and lexeme construction utility functions
-- The tamandua-specific lexeme rules and state transitions were 
-- written by me to satisfy assignment 3 


local lexit = {} -- Module

--------------- Constants ----------------

-- Constants: lexeme categories
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

local keyword = {
    ["chr"] = true,
    ["else"] = true,
    ["elsif"] = true,
    ["func"] = true,
    ["if"] = true,
    ["print"] = true,
    ["println"] = true,
    ["readint"] = true,
    ["return"] = true,
    ["rnd"] = true,
    ["while"] = true,
}

--------- Functions to determine kind of character -----------

local function isLetter(char)
    if "A" <= char and char <= "Z" then
        return true
    elseif "a" <= char and char <= "z" then
        return true
    else
        return false
    end
end

local function isDigit(char)
    if "9" >= char and char >= "0" then
        return true
    else
        return false
    end

end

local function isWhitespace(char)
    if char == " " or char == "\t" or char == "\n"
    or char == "\v" or char == "\r" or char == "\f" then
        return true
    else
        return false
    end
end

local function isPrintableASCII(char)
    if char >= " " and char <= "~" then
        return true
    else
        return false
    end
end

----------------------------------------------------------------
------------------------ Lexit.lex -----------------------------
----------------------------------------------------------------

function lexit.lex(str)
    -- Variables
    local char
    local position
    local oldPosition
    local lexeme
    local category
    local state

    -- States
    local START = 1
    local LETTER = 2
    local DIGIT = 3
    local EXPONENT = 4
    local PLUS = 5
    local DOUBLEQUOTE = 6
    local SINGLEQUOTE = 7
    local EQUAL = 8
    local DONE = 9

    -------------- Character functions -------------
    local function currentChar()
        return str:sub(position,position)
    end

    local function lookAhead(n)
        return str:sub(position+n, position+n)
    end

    local function lookBack(n)
        return str:sub(position-n, position-n)
    end

    local function nextPosition()
        position = position + 1
    end

    local function addToLexeme()
        lexeme = lexeme .. currentChar()
        nextPosition()
    end

    local function skipWhitespace()
        while isWhitespace(currentChar()) and position <= str:len() do
            nextPosition()
        end
    end

    local function skipComments()
        if currentChar() == "#" then
            while currentChar() ~= "\n" and position <= str:len() do
                nextPosition()
            end
        end
    end

    local function skipToNextLexeme()
        while true do
            oldPosition = position

            skipWhitespace()
            skipComments()

            if position == oldPosition then
                break
            end
        end
    end

---------------- Handler Functions -----------------

    local function handle_START()
        if not isPrintableASCII(char) and not isWhitespace(char) then
            addToLexeme()
            state = DONE
            category = lexit.MAL
        elseif isLetter(currentChar()) or currentChar() == "_" then
            addToLexeme()
            state = LETTER 
        elseif isDigit(currentChar()) then
            addToLexeme()
            state = DIGIT
        elseif char == "+" or char == "-" then 
            addToLexeme()
            state = PLUS
        elseif char == '"' then
            addToLexeme()
            state = DOUBLEQUOTE
        elseif char == "'" then
            addToLexeme()
            state = SINGLEQUOTE
        elseif char == "!" or char == "=" or char == ">" or char == "<" then
            addToLexeme()
            state = EQUAL
        elseif char == "&" and lookAhead(1) == "&" then
            addToLexeme()
            addToLexeme()
            state = DONE
            category = lexit.OP
        elseif char == "|" and lookAhead(1) == "|" then
            addToLexeme()
            addToLexeme()
            state = DONE
            category = lexit.OP
        elseif  char == "*" or char == "/" or char == "%" 
        or char == "[" or char == "]" then
            addToLexeme()
            state = DONE
            category = lexit.OP
        else
            addToLexeme()
            state = DONE
            category = lexit.PUNCT
        end

    end

    -- state == LETTER when we have seen a letter or "_"
    local function handle_LETTER()
        if isLetter(char) or isDigit(char) or char == "_" then
            addToLexeme()
        else
            state = DONE
            if keyword[lexeme] then
                category = lexit.KEY
            else
                category = lexit.ID
            end
        end
    end
    
    -- state == DIGIT if we have seen a digit
    local function handle_DIGIT()
        if isDigit(char) then
            addToLexeme()
        elseif char == "e" or char == "E" then
            if isDigit(lookAhead(1)) then
                addToLexeme()
                state = EXPONENT
            elseif lookAhead(1) == "+" and isDigit(lookAhead(2)) then
                addToLexeme()
                addToLexeme()
                addToLexeme()
                state = EXPONENT
            else
                state = DONE
                category = lexit.NUMLIT
            end
        else
        state = DONE
        category = lexit.NUMLIT
        end
    end
    -- state == EXPONENT when we have seen "e" followed by a digit, or a "+" then a digit
    local function handle_EXPONENT()
        if isDigit(char) then
            addToLexeme()
        else
            state = DONE
            category = lexit.NUMLIT
        end
    end
    -- state == PLUS when we have seen "+" or "-"
    local function handle_PLUS()
        if lookBack(1) == "+" and char == "+" then
            addToLexeme()
        elseif lookBack(1) == "-" and char == "-" then
            addToLexeme()
        end
        state = DONE
        category = lexit.OP
    end

    -- state == DOUBLEQUOTE when we have seen '"'
    local function handle_DOUBLEQUOTE()
        if position > str:len() or char == "\n" then
            state = DONE
            category = lexit.MAL
        elseif char ~= '"' then
            addToLexeme()
        else
            addToLexeme()
            state = DONE
            category = lexit.STRLIT
        end
    end
    
    -- state == SINGLEQUOTE when we have seen "'"
    local function handle_SINGLEQUOTE()
        if position > str:len() or char == "\n" then
            state = DONE
            category = lexit.MAL
        elseif char ~= "'" then
            addToLexeme()
        else
            addToLexeme()
            state = DONE
            category = lexit.STRLIT
        end
    end

    -- state == EQUAL when we have seen "=", "!", ">", or "<"
    local function handle_EQUAL()
        if char == "=" then
            addToLexeme()
        end
            state = DONE
            category = lexit.OP
    end

    local handlers = {
        [START] = handle_START,
        [LETTER] = handle_LETTER,
        [DIGIT] = handle_DIGIT,
        [EXPONENT] = handle_EXPONENT,
        [PLUS] = handle_PLUS,
        [DOUBLEQUOTE] = handle_DOUBLEQUOTE,
        [SINGLEQUOTE] = handle_SINGLEQUOTE,
        [EQUAL] = handle_EQUAL,
    }


    ----------------- Body of lex -----------------

    return coroutine.wrap(function()
        position = 1

        while true do
            skipToNextLexeme()

            if position > str:len() then
                return nil
            end

            lexeme = ""
            state = START
            category = nil

            while state ~= DONE do
                char = currentChar()
                handlers[state]()

            end

            coroutine.yield(lexeme, category)
        end
    end)

end


return lexit