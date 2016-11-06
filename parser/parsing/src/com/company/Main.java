package com.company;

import com.company.lexer.ListLexer;
import com.company.multi.LookaheadParser;
import com.company.parser.ListParser;

public class Main {

    public static void main(String[] args) {
        ListLexer lexer = new ListLexer(args[0]);
        LookaheadParser parser = new LookaheadParser(lexer, 2);
        parser.list();
//        ListParser parser = new ListParser(lexer);
//        parser.list();
//        Token t = lexer.nextToken();
//        while(t.type != Lexer.EOF_TYPE) {
//            System.out.println(t);
//            t = lexer.nextToken();
//        }
//        System.out.println(t);

    }
}
