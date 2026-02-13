## reserved words
there can be reserved words that are not keywords, and keywords that are not reserved words.

# lexer
three ways to write a lexer
1. state machine entirely in code
2. state machine that used a table
3. some more advanced method?

## state machine lexing
writing a lexer in lua

### lexemes
no delimiter between lexemes
comments like multiline c comments

what happens when you read past the end of input

string func sub to get single chars out of the input string


function skipToNextLexeme.

move pos to begin of next lex, skipping comments and  white space between comments



### debug stuff
invariants are statements that are always true at a certain point

assert, pass a bool to it, if the expression is false, then crash, else, do nothing

debug vs release builds
release avoids debugging info
release has more aggressive optimization
release has no asserts

