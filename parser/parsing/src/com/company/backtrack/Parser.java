package com.company.backtrack;

import com.company.lexer.Lexer;
import com.company.lexer.Token;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by noguchimasato on 11/6/16.
 */
public abstract class Parser {
    Lexer input;
    List<Integer> markers;
    List<Token> lookahead;
    int p = 0;
    public static final int FAILED = -1;
    public abstract void clearMemo();

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
            clearMemo();
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

    public boolean alreadyParsedRule(Map<Integer, Integer> memoization) throws PreviousParseFailedExpection {
        Integer memo1 = memoization.get(this.p);
        if (memo1 == null) return false;
        int memo = memo1.intValue();
        System.out.println("parsed list before at index" + this.p + "; skip ahead to token idex" + memo + ":" + lookahead.get(memo).text);
        if (memo == FAILED) throw new PreviousParseFailedExpection();
        seek(memo);
        return true;
    }

    public void memoize(Map<Integer, Integer> memoization, int startTokenIndex, boolean failed) {
        int stopTokenIndex = failed ? FAILED : this.p;
        memoization.put(startTokenIndex, stopTokenIndex);
    }
}
