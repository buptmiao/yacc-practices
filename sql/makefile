# definition
cmd:=sql
lex:=sql.l
yacc:=sql.y

# action
${cmd}: y.tab.c lex.yy.c
	gcc -g $^ -o $@

lex.yy.c: ${lex}
	lex $^

y.tab.c: ${yacc}
	yacc -d $^

clean:
	rm -f lex.yy.c y.tab.c y.tab.h ${cmd}
