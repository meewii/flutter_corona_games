import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart';

shelf.Response _notFoundRequest(shelf.Request request) =>
    shelf.Response.notFound(
        'Page not found "${request.url}"\n\nDo you come here often?');

extension FourOhFour on Router {
  void add404() {
    all('/<ignored|.*>', _notFoundRequest);
  }
}
