import lexer as lx

text_input = "print(4 + 4 - 2);"

lexer = lx.Lexer().get_lexer()
tokens = lexer.lex(text_input)

for token in tokens:
    print(token)
