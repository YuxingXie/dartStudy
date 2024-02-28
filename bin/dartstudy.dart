

void main() {
  int age=-1;
  String? x;
  x=switch(age){
    >=0&&<3=>
      '$age years old is baby' ,
    >=3&&<=10
      =>'$age years old is kid',
    (>10&&<18)
  =>'$age years old is teenage',
    (>=18&&<60)
  =>'$age years old is yong person',
    (>=60&&<150)
  =>'$age years old is old person',
    (>=150)
  =>'$age years old is not a person',
//  _ => throw FormatException('Invalid')
  _ => 'bad age format'
//  <0 => 'bad age format'
  };
  print(x);


}
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
//    yield* naturalsDownFrom(n - 1);
  yield* li;
  }
}
List<int> li=[-1,-2,-3];
