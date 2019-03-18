%{
package main

import (
    "bufio"
    "log"
    "fmt"
)

var nIndent int

type yylexer struct{
    src     *bufio.Reader
    buf     []byte
    empty   bool
    current byte
}

func newLexer(src *bufio.Reader) (y *yylexer) {
    y = &yylexer{src: src}
    if b, err := src.ReadByte(); err == nil {
        y.current = b
    }
    return
}

func (y *yylexer) getc() byte {
    if y.current != 0 {
        y.buf = append(y.buf, y.current)
    }
    y.current = 0
    if b, err := y.src.ReadByte(); err == nil {
        y.current = b
    }
    return y.current
}

func (y yylexer) Error(e string) {
    log.Fatal(e)
}

func (y *yylexer) Lex(lval *yySymType) int {

    c := y.current
    if y.empty {
        c, y.empty = y.getc(), false
    }
%}

%yyc c
%yyn c = y.getc()

id [A-Za-z0-9\*\~\:\;\=\'\{\}\!\$\-\.\_\[\]]+

%%
    y.buf = y.buf[:0]

"(" 			{
					nIndent++
					return BRACKET_UP
				}
")"  			{
					nIndent--
					return BRACKET_DOWN
				}
","         	{
					return COMMA
				}

{id}	 		{
	                lval.token = string(y.buf)
	                return KEY
	            }


[ \t]+          ;       /* ignore whitespace */
.               { fmt.Printf("%q\n", y.buf) }


%%

    y.empty = true
    return 0
}

