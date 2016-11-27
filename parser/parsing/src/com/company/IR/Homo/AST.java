package com.company.IR.Homo;

import com.company.lexer.Token;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by noguchi-masato on 11/28/16.
 */

public class AST {
    Token token;
    List<AST> children;

    public AST() {}
    public AST(Token token) { this.token = token; }
    public AST(int tokenType, String text) { this.token = new Token(tokenType, text); }
    public int getNodeType() { return this.token.type; }
    public void addChild(AST t) {
        if (children == null) children = new ArrayList<AST>();
        children.add(t);
    }
    public boolean isNil() { return token == null; }
    public String toString() {
        return token != null ? token.toString() : "nil";
    }
    public String toStringTree() {
        if (children == null || children.size()==0) return this.toString();
        StringBuilder buf = new StringBuilder();
        if(!isNil()) {
            buf.append("(");
            buf.append(this.toString());
            buf.append(")");
        }
        for (int i = 0; i < children.size(); i++) {
            AST t = (AST)children.get(i);
            if (i>0) buf.append(' ');
            buf.append(t.toStringTree());
        }
        if (!isNil()) buf.append(")");
        return buf.toString();
    }
}
