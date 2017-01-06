%{
#include "calculator.h"
#include "y.tab.h"
void yyerror(char *);
%}
id [A-Za-z]
num [0-9]*

%%

{id}	 		{
	                yylval.sIndex = *yytext - 'A';
	                return VARIABLE;
	            }
{num}			{
	                yylval.iValue = atoi(yytext);
	                return INTEGER;
	            }
[-()<>=+*/;{}.] {
                	return *yytext;
            	}      
">="            return GE;
"<="            return LE;
"=="            return EQ;
"!="            return NE;
"while"         return WHILE;
"if"            return IF;
"else"          return ELSE;
"print"         return PRINT;

"\n"			{yylineno++;}
[ \t]+          ;       /* ignore whitespace */
.               yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}

