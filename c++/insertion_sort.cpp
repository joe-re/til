#include <iostream>
#include <stdio.h>

using namespace std;

void trace(int a[], int n) {
  for (int i = 0; i < n; i++) {
    if (i > 0) printf(" ");
    printf("%d", a[i]);
  }
  printf("\n");
}

void insertionSort(int a[], int n) {
  for (int i = 0; i < n; i++) {
    int v = a[i];
    int j = i - 1;
    while (j >= 0 && a[j] > v) {
      a[j+1] = a[j];
      j--;
    }
    a[j+1] = v;
    trace(a, n);
  }
}

int main() {
  int a[100], n;
  cin >> n;
  for (int i = 0; i < n; i++) scanf("%d", &a[i]);
  insertionSort(a, n);
}
