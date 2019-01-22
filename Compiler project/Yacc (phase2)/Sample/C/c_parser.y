%{

#include <stdio.h>

// stuff from flex that bison needs to know about:
//extern "C" int yylex();
//extern "C" int yyparse();
extern FILE *yyin;
extern int yylineno;
extern char* yytext;

void yyerror(const char *s);
 
FILE *fout;
%}
// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	float rval;
	_Bool bval;
	char* id;
}

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:

%token PROGRAM_KW INTEGER_KW REAL_KW BOOL_KW AND_KW OR_KW BEGIN_KW END_KW PROCEDURE_KW FUNCTION_KW ASSIGN_KW IF_KW THEN_KW ELSE_KW WHILE_KW DO_KW FOR_KW TO_KW DOWNTO_KW CASE_KW RETURN_KW PLUS_KW MINUS_KW MULT_KW DIV_KW LT_KW LE_KW EQ_KW NE_KW GT_KW GE_KW
%token <ival> INTEGER_NUMBER 
%token <rval> REAL_NUMBER
%token <bval> BOOL_CONSTANT
%token <id> IDENTIFIER

%left AND_KW OR_KW
%right ASSIGN_KW
%left EQ_KW NE_KW
%left LT_KW GT_KW
%left LE_KW GE_KW
%left PLUS_KW MINUS_KW
%left MULT_KW DIV_KW
%right NOT_KW
%left THEN_KW
%left ELSE_KW

%%

// this is the actual grammar that bison will parse, but for right now it's just
// something silly to echo to the screen what bison gets from flex.  We'll
// make a real one shortly:

program : PROGRAM_KW IDENTIFIER ';' declist block ';'
	{
		fprintf(fout, "Rule 1 \t\t program -> PROGRAM_KW IDENTIFIER; declist block; \n") ;
	};
	| PROGRAM_KW IDENTIFIER ';' block ';'
	{
		fprintf(fout, "Rule 2 \t\t program -> PROGRAM_KW IDENTIFIER; block; \n") ;
	};
		
declist : dec 
	{
		fprintf(fout, "Rule 3 \t\t declist -> dec \n") ;
	};
	|  declist dec
	{
		fprintf(fout, "Rule 4 \t\t declist -> declist dec \n") ;
	};
	
dec : vardec 
	{
		fprintf(fout, "Rule 5 \t\t dec -> vardec \n") ;
	};
	|	 procdec
	{
		fprintf(fout, "Rule 6 \t\t dec -> procdec \n") ;
	};
	| funcdec
	{
		fprintf(fout, "Rule 7 \t\t dec -> funcdec \n") ;
	};	
	
type : INTEGER_KW
	{
		fprintf(fout, "Rule 8 \t\t type -> INTEGER_KW\n") ;
	};
	| REAL_KW
	{
		fprintf(fout, "Rule 9 \t\t type -> REAL_KW\n") ;
	};
	| BOOL_KW
	{
		fprintf(fout, "Rule 10 \t type -> BOOL_KW\n") ;
	};
	
iddec : IDENTIFIER 
	{
		fprintf(fout, "Rule 11 \t iddec -> IDENTIFIER \n") ;
	};
	| IDENTIFIER ASSIGN_KW exp
	{
		fprintf(fout, "Rule 12 \t iddec -> IDENTIFIER ASSIGN_KW exp \n") ;
	};
	
idlist : iddec
	{
		fprintf(fout, "Rule 13 \t idlist -> iddec \n") ;
	};
	| idlist  ','  iddec
	{
		fprintf(fout, "Rule 14 \t idlist -> idlist, iddec  \n") ;
	};
	
vardec : type idlist ';'
	{
		fprintf(fout, "Rule 15 \t vardec -> type idlist; \n") ;
	};
	
procdec : PROCEDURE_KW IDENTIFIER '(' paramdecs ')' declist block ';'
	{
		fprintf(fout, "Rule 16 \t procdec -> PROCEDURE_KW IDENTIFIER (paramdecs) declist block; \n") ;
	};
	| PROCEDURE_KW IDENTIFIER '(' paramdecs ')' block ';'
	{
		fprintf(fout, "Rule 16.1 \t procdec -> PROCEDURE_KW IDENTIFIER (paramdecs) block; \n") ;
	};
	
funcdec : FUNCTION_KW IDENTIFIER '(' paramdecs ')' ':' type declist block ';'
	{
		fprintf(fout, "Rule 17 \t funcdec -> FUNCTION_KW IDENTIFER (paramdecs) : type declist block; \n") ;
	};
	| FUNCTION_KW IDENTIFIER '(' paramdecs ')' ':' type block ';'
	{
		fprintf(fout, "Rule 17.1 \t funcdec -> FUNCTION_KW IDENTIFER (paramdecs) : type block; \n") ;
	};
	
paramdecs : paramdec
	{
		fprintf(fout, "Rule 18 \t paramdecs -> paramdec \n") ; 
	};
	| paramdecs ';' paramdec
	{
		fprintf(fout, "Rule 19 \t paramdecs -> paramdecs; paramdec \n") ; 
	};
	
paramdec : type paramlist
	{
		fprintf(fout, "Rule 20 \t paramdec -> type paramlist \n") ; 
	};
	
paramlist : IDENTIFIER
	{
		fprintf(fout, "Rule 21 \t paramlist -> IDENTIFIER \n") ; 
	};
	| paramlist ',' IDENTIFIER
	{
		fprintf(fout, "Rule 22 \t paramlist -> paramlist, IDENTIFIER \n") ; 
	};
	
block : BEGIN_KW stmtlist END_KW
	{
		fprintf(fout, "Rule 23 \t block -> BEGIN_KW stmtlist END_KW \n") ; 
	};
	| stmt
	{
		fprintf(fout, "Rule 24 \t block -> stmt\n") ; 
	};
	
stmtlist : stmt
	{
		fprintf(fout, "Rule 25 \t stmtlist -> stmt\n") ; 
	};
	| stmtlist ';' stmt
	{
		fprintf(fout, "Rule 26 \t stmtlist -> stmtlist; stmt\n") ; 
	};
	
lvalue : IDENTIFIER
	{
		fprintf(fout, "Rule 27 \t lvalue -> IDENTIFIER\n") ; 
	};
	
stmt: lvalue ASSIGN_KW exp 
	{
		fprintf(fout, "Rule 28 \t stmt ->  lvalue ASSIGN_KW exp   \n") ;
	};
	| IF_KW exp THEN_KW block 
	{
		fprintf(fout, "Rule 29 \t stmt -> IF_KW exp THEN_KW block \n") ;
	};
	| IF_KW exp THEN_KW block ELSE_KW block
	{
		fprintf(fout, "Rule 30 \t stmt -> IF_KW exp THEN_KW block ELSE_KW block \n") ;
	};
	| WHILE_KW exp DO_KW block
	{
		fprintf(fout, "Rule 31 \t stmt -> WHILE_KW exp DO_KW block  \n") ;
	};
	| FOR_KW lvalue ASSIGN_KW exp TO_KW exp DO_KW block 
	{
		fprintf(fout, "Rule 32 \t stmt ->  FOR_KW lvalue ASSIGN exp TO_KW exp DO_KW block \n") ;
	};
	| FOR_KW lvalue ASSIGN_KW exp TO_KW exp DOWNTO_KW block 
	{
		fprintf(fout, "Rule 33 \t stmt ->  FOR_KW lvalue ASSIGN exp TO_KW exp DOWNTO_KW block\n") ;
	};
	| CASE_KW exp caseelement END_KW
	{
		fprintf(fout, "Rule 34 \t stmt -> CASE_KW exp caseelement END_KW\n") ;
	};
	| RETURN_KW exp
	{
		fprintf(fout, "Rule 35 \t stmt -> RETURN_KW exp\n") ;
	};
	| exp  
	{
		fprintf(fout, "Rule 36 \t stmt -> exp   \n") ;
	};
	
exp : exp AND_KW exp
	{
		fprintf(fout, "Rule 37 \t exp -> exp AND_KW exp   \n") ;
	};
	| exp OR_KW exp
	{
		fprintf(fout, "Rule 38 \t exp ->  exp OR_KW exp   \n") ;
	};
	| exp PLUS_KW exp
	{
		fprintf(fout, "Rule 39 \t exp -> exp PLUS_KW exp   \n") ;
	};
	| exp MINUS_KW exp
	{
		fprintf(fout, "Rule 40 \t exp -> exp MINUS_KW exp   \n") ;
	};
	| exp MULT_KW exp
	{
		fprintf(fout, "Rule 41 \t exp -> exp MULT_KW exp   \n") ;
	};
	| exp DIV_KW exp
	{
		fprintf(fout, "Rule 42 \t exp ->  exp DIV_KW exp   \n") ;
	};
	| INTEGER_NUMBER
	{	
		fprintf(fout, "Rule 44 \t exp -> INTEGER_NUMBER  \n") ;
	};
	| REAL_NUMBER
	{
		fprintf(fout, "Rule 45 \t exp -> REAL_NUMBER  \n") ;
	};
	| BOOL_CONSTANT
	{
		fprintf(fout, "Rule 46 \t exp -> BOOL_CONSTANT \n") ;
	};
	| lvalue
	{
		fprintf(fout, "Rule 47 \t exp -> lvalue  \n") ;
	};
	| IDENTIFIER '(' explist ')' 
	{
		fprintf(fout, "Rule 48 \t exp -> IDENTIFIER (explist)  \n") ;
	};
	| exp LT_KW exp
	{
		fprintf(fout, "Rule 49.1 \t exp -> exp LT_KW exp  \n") ;
	};
	| exp LE_KW exp
	{
		fprintf(fout, "Rule 49.2 \t exp -> exp LE_KW exp  \n") ;
	};
	| exp EQ_KW exp
	{
		fprintf(fout, "Rule 49.3 \t exp -> exp EQ_KW exp  \n") ;
	};
	| exp NE_KW exp
	{
		fprintf(fout, "Rule 49.4 \t exp -> exp NE_KW exp  \n") ;
	};
	| exp GT_KW exp
	{
		fprintf(fout, "Rule 49.5 \t exp -> exp GT_KW exp  \n") ;
	};
	| exp GE_KW exp
	{
		fprintf(fout, "Rule 49.6 \t exp -> exp GE_KW exp  \n") ;
	};
	
caseelement : INTEGER_NUMBER ':' block ';'
	{
		fprintf(fout, "Rule 50 \t caseelement -> INTEGER_NUMBER : block; \n") ;
	};
	| caseelement INTEGER_NUMBER ':' block ';'
	{
		fprintf(fout, "Rule 51 \t caseelement -> caseelement INTEGER_NUMBER : block; \n") ;
	};
	
explist : exp
	{
		fprintf(fout, "Rule 52 \t explist -> exp \n") ; 
	};
	| explist ',' exp
	{
		fprintf(fout, "Rule 53 \t explist -> explist, exp\n") ; 
	};

%%

int main() {
	// open a file handle to a particular file:
	yyin = fopen("input.txt", "r");
	
	fout = fopen("output.txt", "w");
	fprintf(fout, "\n \t \t \t PARSER \n");
	fprintf(fout, "Rule No. --> Rule Description \n");
	
	if (fout == NULL)
	{
		printf("Error opening file!\n");
		//exit(1);
	}
	// make sure it is valid:
	else if (!yyin) {
		printf("Error opening file!\n");
		//exit(1);
	}
	// set flex to read from it instead of defaulting to STDIN:
	
	// parse through the input until there is no more:
	else
		yyparse();
}

void yyerror(const char *s) {
	fprintf(fout, "**Error: Line %d near token '%s' --> Message: %s **\n", yylineno,yytext ,s);
	printf("**Error: Line %d near token '%s' --> Message: %s **\n", yylineno,yytext, s);
	// might as well halt now:
	//exit(-1);
}