import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'endpoints/api_registry.dart';
import 'endpoints/four_oh_four.dart';
import 'endpoints/utils.dart';

const _localhost = 'localhost';
const _hostname = '0.0.0.0';

void main(List<String> args) async {
  var parser = ArgParser()
    ..addOption('port', abbr: 'p')
    ..addFlag(_localhost, defaultsTo: false);
  var result = parser.parse(args);

  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  var host = _hostname;
  if (result[_localhost]) {
    host = _localhost;
  }

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  final firebasePath = getFirebasePath();
  final api = ApiRegistry(firebasePath);
  final router = Router();

  router.mount('/api/', api.router);
  router.all('/echo/<ignored|.*>', _echoRequest);
  router.add404();

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(router);

  var server = await io.serve(handler, host, port);
  print(
      'Serving data from $firebasePath at http://${server.address.host}:${server.port}');
}

shelf.Response _echoRequest(shelf.Request request) =>
    shelf.Response.ok('Echo "${request.url}"');
