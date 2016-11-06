package com.company.backtrack;

import com.company.lexer.Lexer;
import com.company.lexer.ListLexer;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by noguchimasato on 11/6/16.
 */
public class BacktrackParser extends Parser {
    private Map<Integer, Integer> list_memo;

    @Override
    public void clearMemo() {
        list_memo = new HashMap<>();
    }

    public BacktrackParser(Lexer input) {
        super(input);
        list_memo = new HashMap<>();
    }

    public void stat() throws MismatchedTokenException {
        if (speculate_stat_alt1()) {
            list(); match(Lexer.EOF_TYPE);
        }
        else if (speculate_stat_alt2()) {
            assign(); match(Lexer.EOF_TYPE);
        }
        else throw new Error("expecting stat found" + LT(1));
    }


    public boolean speculate_stat_alt1() {
        boolean success = true;
        mark();
        try { list(); match(ListLexer.EOF_TYPE); }
        catch (MismatchedTokenException e) { success = false; }
        release();
        return success;
    }

    public boolean speculate_stat_alt2() {
        boolean success = true;
        mark();
        try { assign(); match(ListLexer.EOF_TYPE); }
        catch (MismatchedTokenException e) { success = false; }
        release();
        return success;
    }

    public void _list() throws MismatchedTokenException {
        System.out.println("parse list rule at toke index:" + this.p);
        match(ListLexer.LBRACK);
        elements();
        match(ListLexer.RBRACK);
    }

    public void list() throws MismatchedTokenException {
        boolean failed = false;
        int startTokenIndex = this.p;
        try {
            if (isSpeclating() && alreadyParsedRule(list_memo)) return;
        } catch (PreviousParseFailedExpection ex) {
            throw new MismatchedTokenException("");
        }
        try {
            _list();
        } catch (MismatchedTokenException e) {
            failed = true;
            throw e;
        }
        finally {
            if (isSpeclating()) {
                memoize(list_memo, startTokenIndex, failed);
            }
        }
    }

    public void assign() throws MismatchedTokenException{
        element();
        match(ListLexer.EQUAL);
        element();
    }

    public void elements() throws MismatchedTokenException {
        element();
        while(LA(1) == ListLexer.COMMA) {
            match(ListLexer.COMMA);
            element();
        }
    }

    public void element() throws MismatchedTokenException {
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
