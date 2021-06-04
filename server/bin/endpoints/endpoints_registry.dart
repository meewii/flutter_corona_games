import 'package:shelf_router/shelf_router.dart';

import 'four_oh_four.dart';
import 'room_endpoint.dart' as room;

class EndpointsRegistry {
  final Router router = Router();

  EndpointsRegistry() {
    router.get('/room/<roomId>', room.get);
    router.post('/room', room.create);
    router.add404();
  }
}
