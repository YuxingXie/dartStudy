late String description;
void main() {
//  String? maybeString = 'nullable with base type String';


  var list = [1, 2, 3];

// Pass printElement as a parameter.
  list.forEach(printElement);

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
