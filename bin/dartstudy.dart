late String description;
void main() {


  var printNumber = numberPrinter();
  printNumber(); // 10
  printNumber(); // 20
  var printNumber1 = numberPrinter();
  var printNumber2 = numberPrinter();
  printNumber1();
  printNumber2();

}
void printElement(int element) {
  print(element);
}
void enableFlags(String description,{bool? bold=true, bool? hidden=false}) {
  if(bold!=null&&bold){
    print('bold');
  }else print('not bold');
  if(hidden!=null&&hidden){
    print('hidden');
  }else print('not hidden');
  print(description);
}

String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
int num = 0;

var numberPrinter = (){
  return (){
    for(int i = 0; i < 10; i++){
      num++;
    }
    print(num);
  };
};
