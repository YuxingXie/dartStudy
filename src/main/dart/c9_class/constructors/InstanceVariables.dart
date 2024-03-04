class A{
  int b = 100;
  int a=10;
  final int c;
  late final int d;
  A(this.c) {
    this.d=c*2;
//    this.d=5;
  }
}
main(){
  A a = A(9);
  print(a.c);
  print(a.d);

}
