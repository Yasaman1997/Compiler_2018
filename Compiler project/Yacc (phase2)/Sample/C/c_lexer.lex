%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

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

LETTER [a-zA-Z]
DIGIT [0-9]
NONZERO_DIGIT [1-9]


REAL_NUMBER ({NONZERO_DIGIT}{DIGIT}*[.][0]*{NONZERO_DIGIT}+)|("0."[0]*{NONZERO_DIGIT}+)|"0.0"|({NONZERO_DIGIT}{DIGIT}*".0")
INTEGER_NUMBER "0"|({NONZERO_DIGIT}{DIGIT}*)
BOOL_CONSTANT "true"|"false"
IDENTIFIER {LETTER}+|{LETTER}({LETTER}|{DIGIT})*

WHITESPACE ([\t]|[\n]|[ ])*

%%

"program" {return PROGRAM_KW;}
"int" {return INTEGER_KW;}
"real" {return REAL_KW;}
"bool" {return BOOL_KW;}
"and then" {return AND_KW;}
"or else" {return OR_KW;}
"begin" {return BEGIN_KW;} 
"end" {return END_KW;}
"procedure" {return PROCEDURE_KW;}
"function" {return FUNCTION_KW;}
":=" {return ASSIGN_KW;}
"if" {return IF_KW;}
"then" {return THEN_KW;}
"else" {return ELSE_KW;}
"while" {return WHILE_KW;}
"do" {return DO_KW;}
"for" {return FOR_KW;}
"to" {return TO_KW;}
"downto" {return DOWNTO_KW;}
"case" {return CASE_KW;}
"return" {return RETURN_KW;}

"+" {return PLUS_KW;}
"-" {return MINUS_KW;}
"*" {return MULT_KW;}
"/" {return DIV_KW;}

"<" {return LT_KW;}
"<=" {return LE_KW;}
"=" {return EQ_KW;}
"#" {return NE_KW;}
">" {return GT_KW;}
">=" {return GE_KW;}

"(" {return '(';} 
")" {return ')';}
"," {return ',';}
";" {return ';';}
":" {return ':';}

{REAL_NUMBER} {return REAL_NUMBER;}
{INTEGER_NUMBER} {return INTEGER_NUMBER;}
{BOOL_CONSTANT} {return BOOL_CONSTANT;}

{IDENTIFIER} {install_id(yytext); return IDENTIFIER;}

[\n] {++yylineno;}
. {}



