#! /usr/bin/env python

import sys
import antlr4
from copybook_lexer import copybook_lexer
from copybook_parser import copybook_parser
from copybook_parserListener import copybook_parserListener


class Listener(copybook_parserListener):
    # Enter a parse tree produced by copybook_parser#main.
    def enterMain(self, ctx:copybook_parser.MainContext):
        pass

    # Exit a parse tree produced by copybook_parser#main.
    def exitMain(self, ctx:copybook_parser.MainContext):
        print("-- DONE")

    # def enterPic(self, ctx:copybook_parser.PicContext):
    #     print(dir(ctx))
    #     if ctx.sign_precision_9():
    #         print("NUMBER:", ctx.sign_precision_9().getText())
    #     else:
    #         print(ctx.LENGTH_TYPE_X())
    #
    # # Exit a parse tree produced by copybook_parser#pic.
    # def exitPic(self, ctx:copybook_parser.PicContext):
    #     print(ctx.getText())


def main():
    text = ''.join(line[6:73] for line in sys.stdin)
    lexer = copybook_lexer(antlr4.InputStream(text))
    stream = antlr4.CommonTokenStream(lexer)
    parser = copybook_parser(stream)
    tree = parser.main()
    walker = antlr4.ParseTreeWalker()
    walker.walk(Listener(), tree)


if __name__ == '__main__':
    main()
