main() {
  var mapDynamic = Map<String, dynamic>.of({'a': '100 dollors', 'b': 100});
  var mapObj = Map<String, Object>.of({'a': '100 dollors', 'b': 100});
  var map1 = Map<String, dynamic>.of(mapObj);
  // var map2 = Map<String, Object>.of(mapDynamic);

  // var map = Map<String, Object>.of({'a': '100 dollors', 'b': 100});
}
