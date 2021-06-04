import 'package:shelf/shelf.dart' as shelf;

import 'models/create_room_request.dart';

shelf.Response get(shelf.Request request, String roomId) {
  return shelf.Response.ok('Request for Room $roomId');
}

Future<shelf.Response> create(shelf.Request request) async {
  final body = await request.readAsString();
  final createRoomRequest = CreateRoomRequest.fromJson(body);

  // TODO:
  // generate host user
  // generate room
  // return

  return shelf.Response.ok('Request for "${request.url}"');
}
