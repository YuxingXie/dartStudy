main() {
  var mapDynamic = Map<String, dynamic>.of({'a': '100 dollors', 'b': 100});
  var mapObj = Map<String, Object>.of({'a': '100 dollors', 'b': 100});
  var map1 = Map<String, dynamic>.of(mapObj);
  // var map2 = Map<String, Object>.of(mapDynamic);

  // var map = Map<String, Object>.of({'a': '100 dollors', 'b': 100});
  Map<String, int> hist = {
    'a': 23,
    'b': 100,
  };

  for (var MapEntry(value: v, key: k) in hist.entries) {
    print('$k occurred $v times');
  }
  var [a, b] = [1, 2];
  print(a + b);
  MapEntry entry = MapEntry("a", 23);
  var MapEntry(key: k, value: v) = entry;
  print("key:$k,value:$v");
}
