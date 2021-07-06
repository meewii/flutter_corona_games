import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../four_oh_four.dart';
import 'room_endpoint.dart' as room;

Handler createHandler() {
  final router = Router();
  router.get('/room/<roomId>', room.get);
  router.post('/room', room.create);
  router.add404();
  return router;
}
