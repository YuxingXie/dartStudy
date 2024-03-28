//void checkVersion() async {
Future<String> checkVersion() async {
//  var version = await lookUpVersion();
//  print(version);
  // Do something with version
//  return  null as Future<String>;
  return Future(lookUpVersion);
}

String lookUpVersion() {
  return '100';
}

main() async {
  String f = await checkVersion();
  print(f);
}
