//void checkVersion() async {
Future<String> checkVersion() async {
  var version = await lookUpVersion();
  print(version);
  // Do something with version
//  return  null as Future<String>;
  return  Future<String>(version);
}

lookUpVersion() {

}

main(){
  Future<String> f = checkVersion();
  print(f);
}
