package main

import (
	"container/list"
	"fmt"
	"sort"
)

func printIndent(nindent int) {
	for i := 0; i < nindent; i++ {
		fmt.Printf("\t")
	}
}

type DecoNode struct {
	Indent    int
	LastToken string
	Tokens    map[string]*DecoNode
}

type DecoStack struct {
	root  *DecoNode
	stack *list.List
}

func NewDecoStack() *DecoStack {
	res := new(DecoStack)
	res.init()
	return res
}

func (d *DecoStack) init() {
	d.stack = list.New()
	d.root = new(DecoNode)
	d.root.LastToken = ""
	d.root.Tokens = make(map[string]*DecoNode)
}

func (d *DecoStack) startNode() {
	if d.stack.Len() == 0 {
		d.stack.PushBack(d.root)
	} else {
		node := new(DecoNode)
		node.Indent = d.stack.Back().Value.(*DecoNode).Indent + 1
		node.Tokens = make(map[string]*DecoNode)
		lastToken := d.stack.Back().Value.(*DecoNode).LastToken
		d.stack.Back().Value.(*DecoNode).Tokens[lastToken] = node
		d.stack.PushBack(node)
	}
}

func (d *DecoStack) endNode() {
	if d.stack.Len() > 0 {
		d.stack.Remove(d.stack.Back())
	}
}

func (d *DecoStack) addToken(token string) {

	var node *DecoNode
	d.stack.Back().Value.(*DecoNode).Tokens[token] = node
	d.stack.Back().Value.(*DecoNode).LastToken = token
}

func (d *DecoNode) printNode() {
	if d == nil {
		return
	}

	fmt.Println("(")
	keys := make([]string, 0, len(d.Tokens))
	for k := range d.Tokens {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for i, s := range keys {
		printIndent(d.Indent + 1)
		fmt.Printf("%s", s)
		d.Tokens[s].printNode()
		if i != len(keys)-1 && d.Tokens[s] == nil {
			fmt.Printf(",")
		}
		fmt.Println("")
	}
	printIndent(d.Indent)
	fmt.Printf(")")
}

func (d *DecoStack) print() {
	d.root.printNode()
}
