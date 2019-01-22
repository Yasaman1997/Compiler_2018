%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>

FILE *fout;


char symbol_table[100][50];
int counter=0;
int install_id(char* next)
{
	int i = 0;
	for(i = 0; i<counter; i++){
		if(strcmp(next, symbol_table[i]) == 0){	
	return i;
		}
	}
	strcpy( symbol_table[counter] , next);
	counter++ ;
	return counter-1 ;
}
%}


LETTER [a-zA-Z];
DIGIT [0-9];

SHENASE "\#"{LETTER}{LETTER}{DIGIT}{DIGIT}{DIGIT};

ADADSABET {DIGIT}+;
PUNCT [(),;:];

REALCONST [1-9]+{DIGIT}?(.{DIGIT}*[1-9])?;
BOOLSABET "true"|"false";

WHITE_SPACE_KW [ \t];
COMMENT_KW "//"[^\n]*;


PROGRAM_KW (program)
INTEGER_KW (int)
FLOAT_KW (float)
BOOLEAN_KW (boolean)
CHAR_KW (char)
ASSIGN (:=)
DO_KW (do)
WHILE_KW (while)
FOR_KW (for)
IF_KW (agar)
OR_ELSE_KW (ya vagarna)
ELSE_KW (vagarna)
THEN_KW (angah)
RETURN_KW (bazgasht)
SEMICOLON_KW (;)
SWITCH_KW (gozinesh)
CASE_KW (mored)
DEFAULT_KW (default)
NOT_KW (naghiz)
END_KW (end)
EXIT_KW (exit)
FUNCTION_KW (ravie)
DOWNTO_KW (downto)
AND_KW (VA)
OR_KW (YA)

ARRAY_UPTO (\.\.)

BLOCK_START (\{)
BLOCK_FINISHED (\})
PARANTHESES_START (\()
PARANTHESES_END (\))

BT [>]
BE [>=]
LT [<]
LE (<=)
PLUS [+]
MINUS [-]
EQ (=)
GE (>=)
NE (<>)
DIVIDE (\/)
REMAINDER (%)

BOOL_CONSTANT "true"|"false"
IDENTIFIER {LETTER}+|{LETTER}({LETTER}|{DIGIT})*


%%

{DIGIT} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "DIGIT\t-\n");}
{ADADSABET} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "ADADSABET\t-\n");}
{PUNCT} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "PUNCT\t-\n");}
{REALCONST} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "REALCONST\t-\n");}
{WHITE_SPACE_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "WHITE_SPACE_KW\t-\n");}
{COMMENT_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "COMMENT_KW\t-\n");}



{PROGRAM_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "PROGRAM_KW\t-\n");}
{INTEGER_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "INTEGER_KW\t-\n");}
{FLOAT_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "FLOAT_KW\t-\n");}
{BOOLEAN_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "BOOLEAN_KW\t-\n");}
{CHAR_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "CHAR_KW\t-\n");}
{ASSIGN} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "ASSIGN\t-\n");}
{DO_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "DO_KW\t-\n");}
{WHILE_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "WHILE_KW\t-\n");}
{FOR_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "FOR_KW\t-\n");}



{ELSE_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "ELSE_KW\t-\n");}

{THEN_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "THEN_KW\t-\n");}

{RETURN_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "RETURN_KW\t-\n");}

{SEMICOLON_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "SEMICOLON_KW\t-\n");}
{SWITCH_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "SWITCH_KW\t-\n");}
{CASE_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "CASE_KW\t-\n");}
{DEFAULT_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "DEFAULT_KW\t-\n");}
{NOT_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "NOT_KW\t-\n");}
{END_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "END_KW\t-\n");}
{EXIT_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "EXIT_KW\t-\n");}
{FUNCTION_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "FUNCTION_KW\t-\n");}

{DOWNTO_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "DOWNTO_KW\t-\n");}
{AND_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "AND_KW\t-\n");}

{OR_KW} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "OR_KW\t-\n");}
{ARRAY_UPTO} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "ARRAY_UPTO\t-\n");}
{BLOCK_START} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "BLOCK_START\t-\n");}
{BLOCK_FINISHED} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "BLOCK_FINISHED\t-\n");}
{PARANTHESES_START} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "PARANTHESES_START\t-\n");}
{PARANTHESES_END} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "PARANTHESES_END\t-\n");}

{BOOLSABET} {fprintf(fout, "\t%s\t", yytext);fprintf(fout, "BOOLSABET\t");fprintf(fout, "%s\n", yytext);}

{SHENASE} {fprintf(fout, "\t%s\t", yytext);fprintf(fout, "SHENASE\t");fprintf(fout, "%d\n", install_id(yytext));}

{BT} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "BT\t-\n");}
{BE} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "BE\t-\n");}
{LT} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "LT\t-\n");}
{LE} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "LE\t-\n");}
{PLUS} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "PLUS\t-\n");}
{MINUS} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "MINUS\t-\n");}

{EQ} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "EQ\t-\n");}
{GE} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "GE\t-\n");}
{NE} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "NE\t-\n");}
{DIVIDE} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "DIVIDE\t-\n");}
{REMAINDER} {fprintf(fout, "\t%s\t", yytext); fprintf(fout, "REMAINDER\t-\n");}



%%
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

yyin = fopen("input.txt", "r");	
fout = fopen("output.txt", "w");
fprintf(fout, "\n LEXER \n");
fprintf(fout, "\tRegEx\tToken\tAttVal\n\n");
    if(yyin) {  
      yylex();
	  fclose(yyin);           
    }
	fclose(fout);
    return 0;
}