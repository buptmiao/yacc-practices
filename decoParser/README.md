### Deco Parser

*   Install golang
*   go get github.com/cznic/golex
*   cd decoParser && make
*   ./deco < test.txt

```
$ cat test.txt

(a,b,c(d,e))

$ ./deco < test.txt

(
	a,
	b,
	c(
		d,
		e
	)
)

```
