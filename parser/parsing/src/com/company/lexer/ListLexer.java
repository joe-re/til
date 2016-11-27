package com.company.lexer;

/**
 * Created by noguchimasato on 11/3/16.
 */
public class ListLexer extends Lexer {
    public static int NAME = 2;
    public static int COMMA = 3;
    public static int LBRACK = 4;
    public static int RBRACK = 5;
    public static int EQUAL = 6;
    public static int INT = 7;
    public static int PLUS = 8;
    public static String[] tokenNames = { "n/a", "<EOF>", "NAME", "COMMA", "LBRACK", "RBRACK", "EQUAL", "INT", "PLUS" };
    public String getTokenName(int x) { return tokenNames[x]; }
    public ListLexer(String input) { super(input); }
    boolean isLETTER() { return c>='a' && c<='z' || c>='A' && c<='Z'; }

    public Token nextToken() {
        while(c!=EOF) {
            switch (c) {
                case ' ': case '\t': case'\r': WS(); continue;
                case ',': consume(); return new Token(COMMA, ",");
                case '[': consume(); return new Token(LBRACK, "[");
                case ']': consume(); return new Token(RBRACK, "]");
                case '=': consume(); return new Token(EQUAL, "=");
                default:
                    if (isLETTER()) return NAME();
                    throw new Error("invalid charactor: " + c);
            }

        }
        return new Token(EOF_TYPE, "<EOF>");
    }

    Token NAME() {
        StringBuffer buf = new StringBuffer();
        do { buf.append(c); consume(); } while (isLETTER());
        return new Token(NAME, buf.toString());
    }

    void WS() {
        while( c==' ' || c=='\t' || c=='\n' || c=='\r' ) {
            consume();
        }
    }
}
