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
  int doubleB = hist.update('b', (value) => value * 2);
  print(doubleB);
  print("after update:${hist['b']}");
  Map<String, String> histStrMap = hist.map((key, value) {
    return MapEntry(key.toString(), value.toString());
  });
  if (histStrMap['b'] case String s) {
    print('String $s');
  }
  hist['c'] = 10;
  for (var MapEntry(value: v, key: k) in hist.entries) {
    print('$k occurred $v times');
  }
  var [a, b] = [1, 2];
  print(a + b);
  MapEntry entry = MapEntry("a", 23);
  var MapEntry(key: k, value: v) = entry;
  print("key:$k,value:$v");

  identical(a, b);

  var it1 = <int>[1, 2, 2, 2, 2];
  var it2 = <String>[
    'a',
    'b',
    'c',
    'd',
    'e',
  ];
  print(Map<int, String>.fromIterables(it1, it2));

  // var cast = hist.cast<String, Object>();
  // Object obj = hist[](1);

  final planetsByMass = <num, String>{
    0.81: 'Venus',
    1: 'Earth',
    0.11: 'Mars',
    17.15: 'Neptune'
  };

  planetsByMass.forEach((key, value) {
    print('$key: $value');
    key = key * 2;
    // 0.81: Venus
    // 1: Earth
    // 0.11: Mars
    // 17.15: Neptune
  });
  print(planetsByMass);
}
