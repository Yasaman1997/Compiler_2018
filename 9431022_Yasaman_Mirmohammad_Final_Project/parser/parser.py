import ply.yacc as yacc
import lexer as lx

class Parser:
    tokens = lx.Lexer.tokens

    precedence = (
        ('lEFT', 'PLUS', 'MINUS'),
        ('lEFT', 'MULTIPLY', 'DIVIDE'),
    )

    def p_program(self, p):
        """program : list"""

    # todo : fix it
    def p_numOrletter(self, p):
        """numOrletter : DIGITS
        | LETTER"""

    def p_list(self, p):
        """list : list declaration
        | declaration"""

    def p_declaration(self, p):
        """declaration : function
        | varDeclaration"""

    def p_varDeclaration(self, p):
        """varDeclaration : type variableList SEMICOLON"""

    def p_ScopedVariableDec(self, p):
        """ScopedVariableDec : scopedSpecifier variableList SEMICOLON"""

    def p_variableList(self, p):
        """variableList : variableList COMMA varInitialization
        | varInitialization"""

    def p_varInitialization(self, p):
        """varInitialization : varForm
        | varForm COLON OPENING_PARENTHESES eachExpression CLOSING_PARENTHESES"""

    def p_varForm(self, p):
        """varForm : LETTER numOrletter OPENING_BRACKET DIGITS CLOSING_BRACKET
        | LETTER numOrletter"""

    def p_scopedSpecifier(self, p):
        """scopedSpecifier : STATIC_KW type
        | type
        """

    def p_type(self, p):
        """type : BOOLEAN_KW
        | INTEGER_KW
        | CHARACTER_KW
        | CHAR_KW
        | BOOL_KW
        | INT_KW
        """

    def p_function(self, p):
        """function : VOID_KW numOrletter OPENING_PARENTHESES parameter CLOSING_PARENTHESES OPENING_BRACE statement CLOSING_BRACE
        | type LETTER numOrletter OPENING_PARENTHESES parameter CLOSING_PARENTHESES statement
        """

    def p_parameter(self, p):
        """parameter : listOfParameters
        |
        """

    def p_listOfParameters(self, p):
        """listOfParameters : listOfParameters SEMICOLON paramTypeList
        | paramTypeList
        """

    def p_paramTypeList(self, p):
        """paramTypeList : type paramList
        """

    def p_paramList(self, p):
        """paramList :  paramList COMMA paramId
        | paramId
        """

    def p_localDeclarations(self, p):
        """localDeclarations : localDeclarations ScopedVariableDec
        |
        """

    def p_paramId(self, p):
        """paramId : LETTER numOrletter
        | LETTER numOrletter  OPENING_BRACKET CLOSING_BRACKET
        """

    def p_statement(self, p):
        """statement : phrase
        | compoundPhrase
        | selectPhrase
        | iterationPhrase
        | returnPhrase
        | continue
        """

    def p_compoundPhrase(self, p):
        """compoundPhrase : OPENING_BRACE localDeclarations  statementList CLOSING_BRACE"""

    def p_statementList(self, p):
        """statementList : statementList statement
        |
        """

    def p_phrase(self, p):
        """phrase : allExpression SEMICOLON
        | SEMICOLON
        """

    def p_selectPhrase(self, p):
        """selectPhrase : IF_KW OPENING_PARENTHESES eachExpression CLOSING_PARENTHESES ifBody
        | IF_KW OPENING_PARENTHESES eachExpression CLOSING_PARENTHESES OPENING_BRACE ifBody ifBody CLOSING_BRACE
        """

    def p_ifBody(self, p):
        """ifBody : statement
        | statement OTHER_KW statement
        | SEMICOLON
        """

    def p_iterationPhrase(self, p):
        """iterationPhrase : TILL_KW OPENING_PARENTHESES eachExpression CLOSING_PARENTHESES statement
        """

    def p_returnPhrase(self, p):
        """returnPhrase : COMEBACK_KW SEMICOLON
        | GIVEBACK_KW allExpression SEMICOLON
        | GIVEBACK_KW numOrletter SEMICOLON
        """

    def p_continue(self, p):
        """continue : CONTINUE_KW SEMICOLON
        """

    def p_allExpression(self, p):
        """allExpression : alterable mathOp allExpression
        | alterable PLUSPLUS
        | alterable MINUSMINUS
        | eachExpression
        | alterable mathOp alterable"""

    def p_mathOp(self, p):
        """mathOp : EQ
        | PLUS_EQ
        | MINUS_EQ
        | MUL_EQ
        | DIV_EQ"""

    def p_eachExpression(self, p):
        """eachExpression : eachExpression logicOp eachExpression
        | eachExpression logicOp THEN_KW eachExpression
        | logicOp eachExpression
        | relExpression
        | eachExpression logicOp ELSE_KW eachExpression"""

    def p_relExpression(self, p):
        """relExpression : mathEXP compareType mathEXP
        | mathEXP
        """

    def p_compareType(self, p):
        """compareType : EQ
        | NOT_EQ"""

    def p_equal(self, p):
        """equal : LE
        | GE
        | LOGIC_EQ"""

    def p_nonEqual(self, p):
        """nonEqual : GT
        | LT
        | NOT_EQ"""

    # todo : conflicts
    def p_mathEXP(self, p):
        """mathEXP : mathEXP opplus mathEXP
        | mathEXP opminus mathEXP
        | mathEXP opmul mathEXP
        | mathEXP opdiv mathEXP
        | mathEXP oprem mathEXP
        | unaryExpression"""

    def p_opplus(self, p):
        """opplus : PLUS"""

    def p_opminus(self, p):
        """opminus : MINUS"""

    def p_opmul(self, p):
        """opmul : MULTIPLY"""

    def p_opdiv(self, p):
        """opdiv : DIVIDE"""

    def p_oprem(self, p):
        """oprem : REMAINDER"""

    def p_unaryExpression(self, p):
        """unaryExpression : unaryop unaryExpression
        | factor"""

    def p_unaryop(self, p):
        """unaryop : MINUS
        | MULTIPLY
        | QMARK
        """

    def p_factor(self, p):
        """factor : inalterable
        | alterable
        """

    def p_alterable(self, p):
        """alterable : LETTER numOrletter
        | alterable OPENING_BRACKET allExpression CLOSING_BRACKET
        | alterable DOT LETTER numOrletter
        """

    def p_inalterable(self, p):
        """inalterable : OPENING_PARENTHESES allExpression CLOSING_PARENTHESES
        | constant
        | LETTER numOrletter OPENING_PARENTHESES args CLOSING_PARENTHESES
        """

    def p_args(self, p):
        """args : arguments
        |
        """

    def p_arguments(self, p):
        """arguments : arguments COMMA allExpression
        | allExpression
        """

    def p_constant(self, p):
        """constant : CONST_KW
        | TRUE
        | FALSE
        """

    def p_logicOp(self, p):
        """logicOp : LOGIC_AND
        | LOGIC_OR
        | NOT
        | AND
        | OR
        """

    # def p_error(self, p):
    #     print('syntax error')
    #     exit(5)

    def p_error(self, p):
        # print('syntax error')
        # exit(5)
        if p:
            print("Syntax error at token", p)
            # Just discard the token and tell the parser it's okay.
            # self.parser.errok()
            exit(5)
        else:
            print("Syntax error at EOF")

    def build(self, **kwargs):
        '''
        build the parser
        '''
        self.parser = yacc.yacc(module=self, **kwargs)
        return self.parser
