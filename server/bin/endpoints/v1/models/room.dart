import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'session.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  final String id;
  final DateTime createdAt;
  final String hostId;
  final Session? session;
  final String roomDocumentPath;
  final String playersCollectionPath;

  Room(this.id, this.createdAt, this.hostId, this.session,
      this.roomDocumentPath, this.playersCollectionPath);

  factory Room.fromJson(String str) => _$RoomFromJson(json.decode(str));

  factory Room.fromFirebase(
      String id, Session? session, Map<String, dynamic> data) {
    return Room(
        id,
        DateTime.parse(data['fields']['createdAt']['timestampValue']),
        data['fields']['hostId']['stringValue'],
        session,
        'rooms/$id',
        'rooms/$id/players');
  }

  String toJson() => json.encode(_$RoomToJson(this));

  Map<String, dynamic> toFirebase() => {
        'fields': {
          'createdAt': {'timestampValue': createdAt.toIso8601String()},
          'hostId': {'stringValue': hostId},
          'sessionId': _fireBaseSession()
        }
      };

  Map<String, String?> _fireBaseSession() {
    if (session?.id != null) {
      return {'stringValue': session?.id};
    } else {
      return {'nullValue': null};
    }
  }
}
