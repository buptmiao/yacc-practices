%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
%}
char [A-Za-z]
num [0-9]
eq [=]
name {char}+
age {num}+

%%

{name} { yylval.str = strdup(yytext);
return KEY; }
{eq} { return EQ; }
{age} { yylval.str = strdup(yytext);
return VALUE; }
. ;

%%

int yywrap(void)
{
        return 1;
}

