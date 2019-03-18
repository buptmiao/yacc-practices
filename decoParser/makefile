all: deco.go token.go decoStack.go
	gofmt -l -s -w *.go
	go build $^

run: all
	./deco

token.go: token.l
	golex -o $@ $<

deco.go: deco.y
	go run $(GOPATH)/src/golang.org/x/tools/cmd/goyacc/yacc.go -o $@ $<

clean:
	go clean
	rm -f token.go deco.go lex.yy.go y.go y.output *~

nuke: clean
	rm -f deco
