import 'dart:convert' as convert;
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;

Uri firebaseUrl(String path, [Map<String, dynamic>? queryParameters]) {
  return Uri.https(
      'firestore.googleapis.com',
      'v1/projects/${getFirebasePath()}/databases/(default)/documents/$path',
      queryParameters);
}

String getFirebasePath() {
  // TODO: maybe get it from the backend Config Vars ?
  // final firebasePath = Platform.environment['FIREBASE_PATH'] ?? throw
  const firebasePath = String.fromEnvironment('FIREBASE_PATH');
  if (firebasePath.isEmpty) {
    stdout.writeln('Could not parse compile time variable FIREBASE_PATH.');
    exitCode = 64;
    return '';
  }
  return firebasePath;
}

Future<String> listDocuments(String path) async {
  return (await http.get(firebaseUrl(path))).body;
}

Future<List<String>> listIDocumentIds(String path) async {
  final url = firebaseUrl(path, {'mask.fieldPaths': '__name__'});
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
