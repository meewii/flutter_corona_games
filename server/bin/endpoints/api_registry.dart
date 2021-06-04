import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart';

import 'four_oh_four.dart';
import 'utils.dart';
import 'v1/endpoints_registry.dart' as v1;
// import 'v1/room_endpoint.dart' as test;

class ApiRegistry {
  final Router router = Router();

  ApiRegistry(String firebasePath) {
    // TODO: how to make an automatic fall-back?
    router.mount('/v1/', v1.createHandler(firebasePath));
    router.all('/test/<ignored|.*>', _testRequest);
    router.add404();
  }
}

Future<shelf.Response> _testRequest(shelf.Request request) async {
  final documents =
      await listDocuments(String.fromEnvironment('FIREBASE_PATH'), 'rooms');
  return shelf.Response.ok(documents,
      headers: {'Content-Type': 'application/json'});

  // return test.createImpl('none');
}

// https://firebase.google.com/docs/firestore/reference/rest/v1/projects.databases.documents
