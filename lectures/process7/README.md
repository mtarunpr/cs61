CS61 2020: Process control 7
============================

Today’s meeting is about command representations.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. Read the [BNF Grammars notes](https://cs61.seas.harvard.edu/site/2020/BNFGrammars/).

Given the BNF grammar, the text `a | b c` can be derived as a
`commandline` as follows:

```
commandline ::= list            using rule `commandline ::= list`
   ::= conditional              using rule `list ::= conditional`
   ::= pipeline                 using rule `conditional ::= pipeline`
   ::= pipeline "|" command     using rule `pipeline ::= pipeline "|" command`
   ::= pipeline "|" command word
                                using rule `command ::= command word`
   ::= pipeline "|" word word   using rule `command ::= word`
   ::= command "|" word word    using rule `pipeline ::= command`
   ::= word "|" word word       using rule `command ::= word`
   ::= "a" "|" "b" "c"          using definition of `word`
```

2\. Describe how the command line `a | b && c > f.txt ; d ; e` can be
derived as a `commandline`.

3\. Sketch some C++ structure definitions corresponding to shell
commands. Do you need to use a tree-type structure?
