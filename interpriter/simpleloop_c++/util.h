//
// util.h
//
#ifndef UTIL_H
#define UTIL_H
#include <algorithm>
#include <string>
#include <cctype>
#include <stack>
#include <iostream>

using namespace std;

bool compCharIgnCase(char c1, char c2);
bool compareIgnCase(string s1, string s2);
void printstack(stack<double> stck);
int getTopElem(stack<double> &stck, double *a, double *b);
#endif
