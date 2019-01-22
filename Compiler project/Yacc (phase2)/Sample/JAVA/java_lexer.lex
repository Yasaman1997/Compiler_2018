package myCompiler;
%%

%byaccj

LETTER = [a-zA-Z]
NONZERO_DIGIT = [1-9]
DIGIT = "0"|{NONZERO_DIGIT}

PROGRAM_KW = (program)
MAIN_KW = (main)

IF_KW = (if)
THEN_KW = (then)
ELSE_KW = (else)

AND_KW = (and)
OR_KW = (or)
NOT_KW = (not)

SEMICOLON_KW = [;]
SINGLE_QUOTE_KW = "\u0027"

LCB_KW = [{]
RCB_KW = [}]

ADD_KW = [+]
SUB_KW = [-]

BOOLEAN_CONSTANT = (true) | (false)
CHAR_CONSTANT = {SINGLE_QUOTE_KW} ({LETTER} | {DIGIT}) {SINGLE_QUOTE_KW}

%%

{PROGRAM_KW} {
	// System.out.println(yytext() + "\t" + "PROGRAM_KW\t" + '-');
	return YYParser.PROGRAM_KW;
}
{MAIN_KW} {
	// System.out.println(yytext() + "\t" + "MAIN_KW\t" + '-');
	return YYParser.MAIN_KW;
}

{IF_KW} {
	// System.out.println(yytext() + "\t" + "IF_KW\t" + '-');
	return YYParser.IF_KW;
}
{THEN_KW} {
	// System.out.println(yytext() + "\t" + "THEN_KW\t" + '-');
	return YYParser.THEN_KW;
}
{ELSE_KW} {
	// System.out.println(yytext() + "\t" + "ELSE_KW\t" + '-');
	return YYParser.ELSE_KW;
}

{AND_KW} {
	// System.out.println(yytext() + "\t" + "AND_KW\t" + '-');
	return YYParser.AND_KW;
}
{OR_KW} {
	// System.out.println(yytext() + "\t" + "OR_KW\t" + '-');
	return YYParser.OR_KW;
}
{NOT_KW} {
	// System.out.println(yytext() + "\t" + "NOT_KW\t" + '-');
	return YYParser.NOT_KW;
}

{SEMICOLON_KW} {
	// System.out.println(yytext() + "\t" + "SEMICOLON_KW\t" + '-');
	return YYParser.SEMICOLON_KW;
}
{SINGLE_QUOTE_KW} {
	// System.out.println(yytext() + "\t" + "SINGLE_QUOTE_KW\t" + '-');
	return YYParser.SINGLE_QUOTE_KW;
}

{LCB_KW} {
	// System.out.println(yytext() + "\t" + "LCB_KW\t" + '-');
	return YYParser.LCB_KW;
}
{RCB_KW} {
	// System.out.println(yytext() + "\t" + "RCB_KW\t" + '-');
	return YYParser.RCB_KW;
}

{ADD_KW} {
	// System.out.println(yytext() + "\t" + "ADD_KW\t" + '-');
	return YYParser.ADD_KW;
}
{SUB_KW} {
	// System.out.println(yytext() + "\t" + "SUB_KW\t" + '-');
	return YYParser.SUB_KW;
}

{BOOLEAN_CONSTANT} {
	// System.out.println(yytext() + "\t" + "CHAR_CONSTANT\t" + "-");
	return YYParser.BOOLEAN_CONSTANT;
}
{CHAR_CONSTANT} {
	// System.out.println(yytext() + "\t" + "CHAR_CONSTANT\t" + "-");
	return YYParser.CHAR_CONSTANT;
}

. {
}