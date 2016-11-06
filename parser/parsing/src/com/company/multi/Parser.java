package com.company.multi;

import com.company.lexer.Lexer;
import com.company.lexer.Token;

/**
 * Created by noguchimasato on 11/6/16.
 */
public class Parser {
    Lexer input;
    Token[] lookahead;
    int k;
    int p = 0;

    public Parser(Lexer input, int k) {
        this.input = input;
        this.k = k;
        lookahead = new Token[k];
        for (int i=0; i<k; i++) consume();
    }

    public void consume() {
        lookahead[p] = input.nextToken();
        p = (p+1) % k;
    }

    public Token LT(int i) {
        return lookahead[(p+i-1) % k];
    }
    public int LA(int i) {
        return LT(i).type;
    }
    public void match(int x) {
        if (LA(1) == x) consume();
        else throw new Error("expecting" + input.getTokenName(x) + "; found" + LT(1));
    }
}
