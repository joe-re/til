package com.company.parser;

import com.company.lexer.Lexer;
import com.company.lexer.Token;

/**
 * Created by noguchimasato on 11/3/16.
 */
public abstract class Parser {
    Lexer input;
    Token lookahead;

    public Parser(Lexer input) {
        this.input = input;
        this.lookahead = input.nextToken();
    }

    public void match(int x) {
        if (lookahead.type == x) consume();
        else throw new Error("expecting" + input.getTokenName(x) + "; found" + lookahead);
    }

    public void consume() {
        lookahead = this.input.nextToken();
    }
}
