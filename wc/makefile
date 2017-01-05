# definition
cmd:=wc
lex:=wc.l

# action
${cmd}: lex.yy.c
	gcc -g lex.yy.c -o $@

lex.yy.c: ${lex}
	lex $^

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h ${cmd}
