import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart' as shelf;
import 'package:uuid/uuid.dart';

import '../utils.dart';
import 'models/create_room_request.dart';
import 'models/player.dart';
import 'models/room.dart';
import 'models/session.dart';

Future<shelf.Response> getRoom(shelf.Request request, String roomId) async {
  final response = await http.get(firebaseUrl('rooms/$roomId'));
  if (response.statusCode > 399) {
    return shelf.Response(response.statusCode,
        body: response.body, headers: {'Content-Type': 'application/json'});
  }

  final roomJson = jsonDecode(response.body);

  Session? session;
  final String? sessionId = roomJson['fields']['sessionId']['stringValue'];
  if (sessionId != null) {
    final sessionUrl = firebaseUrl('rooms/$roomId/sessions/$sessionId');
    final sessionResponse = await http.get(sessionUrl);
    if (sessionResponse.statusCode >= 200 &&
        sessionResponse.statusCode <= 299) {
      final sessionJson = jsonDecode(sessionResponse.body);
      // TODO: session.fromFirebase()
    }
  }

  final room = Room.fromFirebase(roomId, session, roomJson);
  return shelf.Response.ok(room.toJson(),
      headers: {'Content-Type': 'application/json'});
}

Future<shelf.Response> getPlayers(shelf.Request request, String roomId) async {
  final response = await http.get(firebaseUrl('rooms/$roomId/players'));
  if (response.statusCode > 399) {
    return shelf.Response(response.statusCode,
        body: response.body, headers: {'Content-Type': 'application/json'});
  }

  final List<dynamic> jsonList =
      jsonDecode(response.body)['documents'];

  final players = jsonList
      .map((e) => Player.fromFirebase(e).toMap())
      .toList(growable: false);

  final json = jsonEncode(players);
  return shelf.Response.ok(json, headers: {'Content-Type': 'application/json'});
}

Future<shelf.Response> create(shelf.Request request) async {
  final body = await request.readAsString();
  final createRoomRequest = CreateRoomRequest.fromJson(body);
  return createImpl(createRoomRequest.hostName);
}

Future<shelf.Response> createImpl(String hostName) async {
  final now = DateTime.now().toUtc();

  final existingRooms = await listDocumentIds('rooms');
  var newRoomId = generateRandomRoomId();
  while (existingRooms.contains(newRoomId)) {
    newRoomId = generateRandomRoomId();
  }

  final newPlayerName = hostName;
  final newPlayerId = Uuid().v4();

  final domainRoom = Room(newRoomId, now, newPlayerId, null, 'rooms/$newRoomId',
      'rooms/$newRoomId/players');
  final newRoom = domainRoom.toFirebase();
  final newRoomUrl = firebaseUrl('rooms/', {'documentId': newRoomId});
  final newRoomResponse = await http.post(
    newRoomUrl,
    body: json.encode(newRoom),
  );

  if (newRoomResponse.statusCode > 399) {
    return shelf.Response(newRoomResponse.statusCode,
        body: newRoomResponse.body,
        headers: {'Content-Type': 'application/json'});
  }

  final domainPlayer = Player(newPlayerId, newPlayerName, now);
  final newPlayer = domainPlayer.toFirebase();
  final newPlayerUrl =
      firebaseUrl('rooms/$newRoomId/players/', {'documentId': newPlayerId});
  final newPlayerResponse = await http.post(
    newPlayerUrl,
    body: json.encode(newPlayer),
  );

  if (newPlayerResponse.statusCode > 399) {
    return shelf.Response(newPlayerResponse.statusCode,
        body: newPlayerResponse.body,
        headers: {'Content-Type': 'application/json'});
  }

  return shelf.Response.ok(domainRoom.toJson(),
      headers: {'Content-Type': 'application/json'});
}
