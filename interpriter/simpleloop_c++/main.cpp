#include <iostream>
#include <algorithm>
#include <string>
#include <cctype>

using namespace std;

bool compCharIgnCase(char c1, char c2);
bool compareIgnCase(string s1, string s2);

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

bool compCharIgnCase(char c1, char c2) {
  return (tolower(c1) == tolower(c2));
}

bool compareIgnCase(string s1, string s2) {
  if (s1.length() != s2.length())
    return false;
  return equal(s1.begin(), s1.end(),
      s2.begin(), compCharIgnCase);
}
