package com.company.lexer;

/**
 * Created by noguchimasato on 11/3/16.
 */
public class Token {

    public int type;
    public String text;
    public Token(int type, String text) { this.type=type; this.text=text; }
    public String toString() {
        String tname = ListLexer.tokenNames[type];
        return "<'" + text + "'," + tname + ">";
    }
}
