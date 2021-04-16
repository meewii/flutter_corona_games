import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  final String id;
  final DateTime createdAt;
  final DateTime lastUpdatedAt;
  final String hostId;
  final String? sessionId;
  final String? sessionType;

  Room(this.id, this.createdAt, this.lastUpdatedAt, this.hostId, this.sessionId,
      this.sessionType);

  factory Room.fromJson(String str) => _$RoomFromJson(json.decode(str));

  String toJson() => json.encode(_$RoomToJson(this));
}
