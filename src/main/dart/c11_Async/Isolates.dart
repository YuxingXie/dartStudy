import 'dart:convert';
import 'dart:io';

//const String filename = 'with_keys.json';
const String filename =
    r'D:\develop\projects\dartProjects\dartStudy\src\main\dart\c11_Async\with_keys.json';

void main() async {
  // Read some data.
  final fileData = await _readFileAsync();
  print(fileData);
  final jsonData = jsonDecode(fileData);

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
  print('$jsonData');
}

Future<String> _readFileAsync() async {
  final file = File(filename);
  final contents = await file.readAsString();
  return contents.trim();
}
