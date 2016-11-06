package com.company.multi;

import com.company.lexer.Lexer;
import com.company.lexer.ListLexer;

/**
 * Created by noguchimasato on 11/6/16.
 */
public class LookaheadParser extends Parser {
    public LookaheadParser(Lexer input, int k) { super(input, k); }

    public void list() {
        match(ListLexer.LBRACK);
        elements();
        match(ListLexer.RBRACK);
    }

    public void elements() {
        element();
        while(LA(1) == ListLexer.COMMA) {
            match(ListLexer.COMMA);
            element();
        }
    }

    public void element() {
        if (LA(1) == ListLexer.NAME && LA(2) == ListLexer.EQUAL) {
            match(ListLexer.NAME);
            match(ListLexer.EQUAL);
            match(ListLexer.NAME);
        }
        else if (LA(1) == ListLexer.NAME) match(ListLexer.NAME);
        else if (LA(1) == ListLexer.LBRACK) list();
        else throw new Error("expecting name or list; found" + LT(1));
    }
}
