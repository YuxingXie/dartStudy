//void checkVersion() async {
Future<String> checkVersion() async {
//  var version = await lookUpVersion();
//  print(version);
  // Do something with version
//  return  null as Future<String>;
  return  '1.0';
}

lookUpVersion() {

}

main(){
  Future<String> f = checkVersion();
}
