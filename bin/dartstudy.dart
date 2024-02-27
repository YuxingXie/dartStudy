Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}

void main() {
  Iterable<int> list = naturalsTo(1);
  naturalsTo(2);
  naturalsTo(3);
  print(list);
}
