from lexer import Lexer
from parser import Parser

if __name__ == '__main__':
    f = open('sample2.txt')
    data = f.read()
    f.close()
    parser = Parser()
    lexer = Lexer()
    parser.build().parse(data, lexer.build())