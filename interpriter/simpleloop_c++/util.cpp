#include "util.h"

bool compCharIgnCase(char c1, char c2) {
  return (tolower(c1) == tolower(c2));
}

bool compareIgnCase(string s1, string s2) {
  if (s1.length() != s2.length())
    return false;
  return equal(s1.begin(), s1.end(),
      s2.begin(), compCharIgnCase);
}

void printstack(stack<double> stck) {
  stack<double> tmpstck;
  tmpstck = stck;
  cout << "--- stack top ---" << endl;
  int n = (int)tmpstck.size();
  for (int i=0; i<n; i++) {
    cout << tmpstck.top() << endl;
    tmpstck.pop();
  }
  cout << "--- stack bottom ---" << endl;
}

int getTopElem(stack<double> &stck, double *a, double *b) {
  if (stck.size() < 2) {
    cout << "lack of operand" << endl;
    return -1;
  }
  *a = stck.top();
  stck.pop();
  *b = stck.top();
  stck.pop();
  return 0;
}
