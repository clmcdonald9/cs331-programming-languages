-- parseit.lua
-- Crysta McDonald
-- Started 2/21/26
-- Built for CS 331 spring 2026 assignment 4

-- Acknowledgement:
-- This parser was written using a modified version of 
-- Glenn G. Chappell's parser.lua skeleton.


local lexit = require "lexit"

------- Module Table -------
local parseit = {}


----------------------------------------------------
-------------------- Variables ---------------------
----------------------------------------------------

-- Lexer iteration 
local iter
local state
local lexOutS
local lexOutC

-- about current lexeme 
local lexeme
local lexCategory

local matched = ""

-- AST specification constants 
local PROGRAM = 1
local EMPTY_STMT = 2
local PRINT_STMT = 3
local PRINTLN_STMT = 4
local RETURN_STMT = 5
local INC_STMT = 6
local DEC_STMT = 7
local ASSN_STMT = 8
local FUNC_CALL = 9
local FUNC_DEF = 10
local IF_STMT = 11
local WHILE_LOOP = 12
local STRLIT_OUT = 13
local CHR_CALL = 14
local BIN_OP = 15
local UN_OP = 16
local NUMLIT_VAL = 17
local READ_CALL = 18
local RND_CALL = 19
local SIMPLE_VAR = 20
local ARRAY_VAR = 21

-------------------------------------------------------------
------------------ Utility Functions ------------------------
-------------------------------------------------------------

local function nextLexme()
    lexOutS, lexOutC  = iter(state, lexOutS)

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

local function atEnd()
    return lexCategory == 0
end

local function matchLexeme(string)
    if lexeme == string then
        matched = lexeme
        nextLexme()
        return true
    end
    return false
end


local function matchCategory(category)
    if lexCategory == category then
        matched = lexeme
        nextLexme()
        return true
    end
    return false
end


----------------------------------------------------------
----------------- Parsing Functions ----------------------
----------------------------------------------------------

local function parseFactor()
    return false, nil
end

local function parseTerm()
    return false, nil
end

local function parseArithExpr()
    return false, nil
end

local function parseCompareExpr()
    return false, nil
end

local function parseExpr()
    return false, nil
end

local function parsePrintArg()
    local good, ast

    if matchCategory(lexit.STRLIT) then
        return true, {STRLIT_OUT, matched}
    else
        return false, nil
    end
end

local function parseStatement()
    local statementKind
    local good
    local ast1
    local ast2
    local saveId
    -- note: matchLexeme advances to next lexeme
    if matchLexeme(";") then
        return true, {EMPTY_STMT}
    elseif matchLexeme("print") or matchLexeme("println") then
        if matched == "print" then
            statementKind = PRINT_STMT
        else
            statementKind = PRINTLN_STMT
        end

        if not matchLexeme("(") then
            return false, nil
        end

        if matchLexeme(")") then
            if not matchLexeme(";") then
                return false, nil
            end
            return true, {statementKind}
        end

        good, ast2 = parsePrintArg()
        if not good then 
            return false, nil
        end

        ast1 = {statementKind, ast2}

        while matchLexeme(",") do
            good, ast2 = parsePrintArg()
            if not good then
                return false, nil
            end
            table.insert(ast1, ast2)
        end

        if not matchLexeme(")") then
            return false, nil
        end

        if not matchLexeme(";") then 
            return false, nil
        end

        return true, ast1

    elseif matchLexeme("return") then
        good, ast1 = parseExpr()
        if not good then
            return false, nil
        end

        if not matchLexeme(";") then
            return false, nil
        end

        return true, {RETURN_STMT, ast1}

    elseif matchLexeme("++") then
        good, ast1 = parseExpr()

        return false, nil

    elseif matchCategory(lexit.ID) then
        return false, nil
    
    else
        return false, nil
    end

end

local function parseProgram()
    local ast = {PROGRAM}
    local ast2
    local good

    while  lexeme == ";"
        or lexeme == "print" or lexeme == "println"
        or lexeme == "return"
        or lexeme == "++" or lexeme == "--"
        or lexCategory == lexit.ID
        or lexeme == "func"
        or lexeme == "if"
        or lexeme == "while"
    do
        good, ast2 = parseStatement()
        if not good then
            return false, nil
        end
        
        table.insert(ast, ast2)
    end
    return true, ast

end

----------------------------------------------------------
----------------------- Parser ---------------------------
----------------------------------------------------------

function parseit.parse(program)
    init(program)

    local good, ast = parseProgram()
    local done = atEnd()

    return good, done, ast

end

return parseit
