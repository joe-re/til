#include <iostream>
#include "./util.h"

using namespace std;

int main(int argc, const char * argv[]) {
  string s;
  stack<double> stck;
  while (true) {
    cout << "->";
    cin >> s;
    if (compareIgnCase(s, "quit"))
      break;
    if (compareIgnCase(s, "printstack")) {
      printstack(stck);
      continue;
    }

    double a, b;
    char c = s[0];
    switch(c) {
      case '+':
        if (getTopElem(stck, &a, &b)) break;
        cout << a + b << endl;
        stck.push(a + b);
        break;
      case '-':
        if (s.size() != 1) {
          stck.push(atof(s.c_str()));
          break;
        }
        if (getTopElem(stck, &a, &b)) break;
        cout << a - b << endl;
        stck.push(a - b);
        break;
      case '/':
        if (getTopElem(stck, &a, &b)) break;
        cout << a / b << endl;
        stck.push(a / b);
        break;
      case '*':
        if (getTopElem(stck, &a, &b)) break;
        cout << a * b << endl;
        stck.push(a * b);
        break;
      default:
        stck.push(atof(s.c_str()));
        break;
    }
    cout << s << endl;
  }
  return 0;
}
