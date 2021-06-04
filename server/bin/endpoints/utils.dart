import 'dart:convert' as convert;
import 'dart:math';

import 'package:http/http.dart' as http;

Future<String> listDocuments(String firebase, String path) async {
  final url = Uri.https('firestore.googleapis.com',
      'v1/projects/$firebase/databases/(default)/documents/$path');
  return (await http.get(url)).body;
}

Future<List<String>> listIDocumentIds(String firebase, String path) async {
  final url = Uri.https(
      'firestore.googleapis.com',
      'v1/projects/$firebase/databases/(default)/documents/$path',
      {'mask.fieldPaths': '__name__'});
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List documents = convert.jsonDecode(response.body)['documents'];
    return documents.map((e) => e['name'].toString().split('/').last).toList();
  } else {
    return List.empty();
  }
}

const _VALUES = 'QWERTYUIOPASDFGHJKLZXCVBNM';

String generateRandomRoomId({int size = 5}) {
  return String.fromCharCodes(List.generate(
      size, (index) => _VALUES.codeUnitAt(Random().nextInt(_VALUES.length))));
}
