Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}

void main() {

  print(naturalsDownFrom(8));



}
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
//    yield* naturalsDownFrom(n - 1);
  yield* li;
  }
}
List<int> li=[-1,-2,-3];
