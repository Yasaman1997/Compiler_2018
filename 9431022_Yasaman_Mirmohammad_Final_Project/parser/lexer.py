import ply.lex as lex


class Lexer:
    tokens = (
        'WHITE_SPACE',  #
        'COMMENTS',  #
        'ID',  #
        'RANGE',  #
        'LETTER',  #

        'NUMBER',  #

        'BOOL',  #

        'CONST',  #

        'OPENING_BRACKET',  #
        'CLOSING_BRACKET',  #
        'OPENING_PARENTHESES',  #
        'CLOSING_PARENTHESES',  #
        'OPENING_BRACE',  #
        'CLOSING_BRACE',  #

        'COLON',  #

        'SEMICOLON',  #
        'COMMA',  #

        'PROGRAM_KW',  #
        'FLOAT_KW',  #
        'INTEGER_KW',  #
        'CHAR_KW',  #

        'IF_KW',  #
        'THEN_KW',  #
        'ELSE_KW',  #
        'SWITCH_KW',  #
        'END_KW',  #
        'CASE_KW',  #
        'DEFAULT_KW',  #
        'FOR_KW',  #
        'DO_KW',  #
        'WHILE_KW',  #
        'RETURN_KW',  #
        'GIVE_BACK',  #
        'COME_BACK',  #
        'EXIT_WHEN_1ST_KW',  #
        'EXIT_WHEN_2ND_KW',  #
        'EXP',  #
        'PLUS_EXP',  #
        'MINUS_EXP',  #
        'MUL_EXP',  #
        'DIV_EXP',  #
        'PLUSPLUS',  #
        'MINUSMINUS',  #
        'DOWNTO_KW',  #
        'UPTO_KW',  #

        'AND_KW',  #
        'OR_KW',  #
        'NOT_KW',  #
        'LT',  #
        'LE',  #
        'GE',  #
        'G',  #
        'MUL',  #
        'DIV',  #
        'MOD',  #
        'DOT',  #
        'METHOD_KW',  #
        'MAIN',  #
        'CONTINUE',  #
        'TILL',  #
        'VOID'  #
        'STATIC',  #
        'VAR',  #
        'DEF',  #
        'DIGITS',  #
        'RESERVED',  #

        'NEW_LINE',  #
        'INT_KW',  #
        'BOOL_KW',  #

        'STATIC_KW',  #
        'BOOLEAN_KW',  #
        'CHARACTER_KW',  #
        'INTERGER_KW',  #

        'VOID_KW',  #
        'OTHER_KW',  #
        'TILL_KW',  #
        'COMEBACK_KW',  #
        'GIVEBACK_KW',  #
        'CONTINUE_KW',  #
        'EQ',  #
        'PLUS_EQ',  #
        'MINUS_EQ',  #
        'MUL_EQ',  #
        'DIV_EQ',  #

        'LOGIC_EQ',  #
        'GT',  #
        'NOT_EQ',  #
        'PLUS',  #
        'MINUS',  #
        'MULTIPLY',  #
        'DIVIDE',  #
        'REMAINDER',  #
        'QMARK',  #
        'CONST_KW',  #
        'TRUE',  #
        'FALSE',  #
        'LOGIC_AND',  #
        'LOGIC_OR',  #
        'NOT',  #
        'AND',  #
        'OR',  #

    )

    reserved = {
        'static': 'STATIC',  #
        'program': 'PROGRAM_KW',
        'character': 'CHAR_KW',
        'char': 'CHAR_KW',
        'boolean': 'BOOLEAN_KW',
        'bool': 'BOOLEAN_KW',
        'float': 'FLOAT_KW',
        'int': 'INTEGER_KW',
        'integer': 'INTEGER_KW',
        'If': 'IF_KW',
        'if': 'IF_KW',
        'then': 'THEN_KW',
        'else': 'ELSE_KW',
        'switch': 'SWITCH_KW',
        'end': 'END_KW',
        'exit': 'EXIT_WHEN_1ST_KW',
        'when': 'EXIT_WHEN_2ND_KW',
        'upto': 'UPTO_KW',
        'downto': 'DOWNTO_KW',
        'case': 'CASE_KW',
        'default': 'DEFAULT_KW',
        'or': 'OR_KW',
        'and': 'AND_KW',
        'not': 'NOT_KW',
        'do': 'DO_KW',
        'for': 'FOR_KW',
        'while': 'WHILE_KW',
        'giveBack': 'GIVEBACK_KW',
        'comeBack': 'COMEBACK_KW',
        'continue': 'CONTINUE',
        'method': 'METHOD_KW',
        'main': 'MAIN',
        'till': 'TILL',
        'void': 'VOID',
        'static': 'STATIC_KW',
        'boolean': 'BOOLEAN_KW',
        'bool': 'BOOL_KW',
        'char': 'CHAR_KW',
        'character': 'CHARACTER_KW',
        'int': 'INT_KW',
        'integer': 'INTEGER_KW',
        'void': 'VOID_KW',
        'if': 'IF_KW',
        'other': 'OTHER_KW',
        'till': 'TILL_KW',
        'comeback': 'COMEBACK_KW',
        'Giveback': 'GIVEBACK_KW',
        'continue': 'CONTINUE_KW',
        'then': 'THEN_KW',
        'else': 'ELSE_KW',
        'const': 'CONST_KW',
        'true': 'TRUE',
        'false': 'FALSE',
        'and': 'AND',
        'or': 'OR'
    }

    t_ignore = ' \t'
    symbol_table = []

    x_LETTER = r'[a-zA-Z]'

    x_NUMBER = r'[0-9]'

    t_LETTER = r'(\'' + x_LETTER + '\')'
    t_VAR = r'(' + x_LETTER + x_NUMBER + ')'
    t_ID = r'(\#' + x_LETTER + x_LETTER + x_NUMBER + x_NUMBER + x_NUMBER + ')'
    t_NUMBER = r'(' + x_NUMBER + ')'
    t_RANGE = r'(' + t_NUMBER + r'..' + t_NUMBER + ')|(' + t_ID + r',,' + t_ID + ')'

    t_COME_BACK = r'(\'' + 'comeBack' + '\')'
    t_GIVE_BACK = r'(\'' + 'giveBack' + '\')'

    t_BOOL = r'true|false'

    t_WHITE_SPACE = r' \n\t\r'

    t_OPENING_BRACKET = r'\]'
    t_CLOSING_BRACKET = r'\['
    t_OPENING_PARENTHESES = r'\('
    t_CLOSING_PARENTHESES = r'\)'
    t_OPENING_BRACE = r'{'
    t_CLOSING_BRACE = r'}'

    t_SEMICOLON = r';'
    t_COLON = r':'
    t_COMMA = r','
    t_EXP = r':='

    t_PLUS_EXP = r'\+='
    t_MINUS_EXP = r'-='
    t_MUL_EXP = r'\*='
    t_DIV_EXP = r'\/='
    t_PLUSPLUS = r'\+\+'

    t_G = r'>'

    t_MUL = r'\*'
    t_DIV = r'\/'
    t_MOD = r'%'
    t_DOT = r'\.'
    t_DEF = r'='

    t_MINUSMINUS = r'--'
    t_EQ = r'='
    t_PLUS_EQ = r'\+='
    t_MINUS_EQ = r'-='
    t_MUL_EQ = r'\*='
    t_DIV_EQ = r'/='
    t_LE = r'<='
    t_GE = r'>='
    t_LOGIC_EQ = r'=='
    t_GT = r'>'
    t_LT = r'<'
    t_NOT_EQ = r'!='
    t_PLUS = r'\+'
    t_MINUS = r'-'
    t_MULTIPLY = r'\*'
    t_DIVIDE = r'/'
    t_REMAINDER = r'%'
    t_QMARK = r'\?'
    t_LOGIC_AND = r'\&\&'
    t_LOGIC_OR = r'\|'
    t_NOT = r'\~'

    def t_DIGITS(self, t):
        r'[0-9]+'
        t.value = int(t.value)
        return t

    def t_COMMENT(self, t):
        r'/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/|//.*'
        pass

    def t_NEW_LINE(self, t):
        r'\r?\n+'
        t.lexer.lineno += t.value.count("\n")

    def t_RESERVED(self, t):
        r"""[a-zA-Z]+"""
        t.type = self.reserved.get(t.value, 'LETTER')
        if t.type == 'LETTER':
            if t.value not in self.symbol_table:
                self.symbol_table.append(t.value)

        return t

    def t_error(self, t):
        print("Illegal character: ", t.value[0])
        t.lexer.skip(1)

    def build(self, **kwargs):
        self.lexer = lex.lex(module=self, **kwargs)
        return self.lexer


if __name__ == '__main__':
    path = 'sample.txt'
    f = open(path)
    lexer = Lexer().build()
    lexer.input(f.read())
    f.close()
    f2 = open('res.txt', 'w+')
    for token in lexer:
        s = str(token)
        x = s.find(',')
        print(s)
        f2.write(s[9:x] + '\n')
    f2.close()
