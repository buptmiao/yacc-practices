%{
#include <stdio.h>
#include "y.tab.h"

int yyerror(char *msg);
%}
%union {
	char *str;
}
%token <str> KEY EQ VALUE
%%
file : record file
        | record
        ;
record : KEY EQ VALUE {printf("key: %s, value: %s \n", $1, $3); }
	;
%%
int main()
{
        yyparse();
        return 0;
}
int yyerror(char *msg)
{
        printf("Error encountered: %s \n", msg);
        return 0;
}
