#include <iostream>
#include "./util.h"

using namespace std;

int main(int argc, const char * argv[]) {
  string s;
  while (true) {
    cout << "->";
    cin >> s;
    if (compareIgnCase(s, "quit"))
      break;
    cout << s << endl;
  }
  return 0;
}
