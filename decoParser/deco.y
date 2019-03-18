%{
// +build ignore

package main

import (
	"bufio"
	"os"
)

var decoStack = NewDecoStack()

%}
%union {
    token string;
}
%token <token> KEY COMMA BRACKET_UP BRACKET_DOWN
%%
file : record
        | file record
        ;
record : KEY {decoStack.addToken($1) }
        | COMMA {}
        | BRACKET_UP {decoStack.startNode()}
        | BRACKET_DOWN {decoStack.endNode()}
    ;
%%

func main() {
    yyParse(newLexer(bufio.NewReader(os.Stdin)))

    decoStack.print()
}