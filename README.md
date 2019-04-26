### ANTLR4 Cobol copybook parser

The relevant lexer/parser files are the `*.g4` files `copybook_lexer.g4` and `copybook_parser.g4`.

##### Set up
To generate the necessary Python 3 code, run
```bash
antlr4 -Dlanguage=Python3 -listener *g4
```
or alternatively the `generate.sh` command. You need ANTLR4 and the Python 3 runtime. To get the latter,
```bash
pip install antlr4-python3-runtime
```

##### Testing

To quickly test the parser on a copybook: 
```bash 
./test_parser.py < copybook-ok.txt
```

In case of errors, the python script above will output the parsing errors from ANTLR. An example is `./test_parser.py < copybook-fail.txt`.