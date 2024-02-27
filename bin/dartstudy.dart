late String description;
void main() {
  const list = ['apples', 'bananas', 'oranges'];
  list.map((item) {
    return item.toUpperCase();
  }).forEach((item) {
    print('$item: ${item.length}');
  });

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
