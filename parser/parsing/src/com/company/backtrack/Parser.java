package com.company.backtrack;

import com.company.lexer.Lexer;
import com.company.lexer.Token;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by noguchimasato on 11/6/16.
 */
public class Parser {
    Lexer input;
    List<Integer> markers;
    List<Token> lookahead;
    int p = 0;

    public Parser(Lexer input) {
        this.input = input;
        this.markers = new ArrayList<>();
        this.lookahead = new ArrayList<>();
    }

    public Token LT(int i) { sync(i); return lookahead.get(p + i - 1); }
    public int LA(int i) { return LT(i).type; }
    public void match(int x) throws MismatchedTokenException {
        if (LA(1) == x) consume();
        else throw new MismatchedTokenException("expecting" + input.getTokenName(x) + "found" + LT(x));
    }

    public void sync(int i) {
        if (p + i > lookahead.size()) {
            int n = (p + i) - lookahead.size();
            fill(n);
        }
    }

    public void fill(int n) {
        for (int i = 0; i <= n; i++) { lookahead.add(input.nextToken()); }
    }

    public void consume() {
        p++;
        if (p == lookahead.size() && !isSpeclating()) {
            p = 0;
            lookahead.clear();
        }
        sync(1);
    }

    public int mark() { markers.add(p); return p; }
    public void release() {
        int marker = markers.get(markers.size() -  1);
        markers.remove(markers.size() - 1);
        seek(marker);
    }
    public void seek(int index) { p = index; }
    public boolean isSpeclating() { return markers.size() > 0; }
}
