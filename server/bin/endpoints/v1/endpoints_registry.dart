import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../four_oh_four.dart';
import 'room_endpoint.dart';

Handler createHandler(String firebasePath) {
  final router = Router();
  final room = RoomEndpoint(firebasePath);
  router.get('/room/<roomId>', room.get);
  router.post('/room', room.create);
  router.add404();

  return router;
}
