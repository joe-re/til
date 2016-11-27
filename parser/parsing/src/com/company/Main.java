package com.company;

import com.company.IR.Homo.AST;
import com.company.lexer.Lexer;
import com.company.lexer.ListLexer;
import com.company.lexer.Token;
import com.company.multi.LookaheadParser;
import com.company.parser.ListParser;

public class Main {

    public static void main(String[] args) {
        Token plus = new Token(ListLexer.PLUS, "+");
        Token one = new Token(ListLexer.INT, "1");
        Token two = new Token(ListLexer.INT, "2");
        AST root = new AST(plus);
        root.addChild(new AST(one));
        root.addChild(new AST(two));
        System.out.println("1+2 tree: " + root.toStringTree());

        AST list = new AST();
        list.addChild(new AST(one));
        list.addChild(new AST(two));
        System.out.println("1 and 2 in list: " + list.toStringTree());
//        ListLexer lexer = new ListLexer(args[0]);
//        LookaheadParser parser = new LookaheadParser(lexer, 2);
//        parser.list();
////        ListParser parser = new ListParser(lexer);
//        parser.list();
//        Token t = lexer.nextToken();
//        while(t.type != Lexer.EOF_TYPE) {
//            System.out.println(t);
//            t = lexer.nextToken();
//        }
//        System.out.println(t);

    }
}
