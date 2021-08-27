import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../utils.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  final String id;
  final String name;
  final DateTime lastPingAt;

  Player(this.id, this.name, this.lastPingAt);

  factory Player.fromJson(String str) => _$PlayerFromJson(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toFirebase() => {
        'fields': {
          'lastPingAt': {'timestampValue': lastPingAt.toIso8601String()},
          'name': {'stringValue': name}
        }
      };

  Map<String, dynamic> toMap() => _$PlayerToJson(this);

  factory Player.fromFirebase(Map<String, dynamic> data) => Player(
      extractFirebaseId(data['name']),
      data['fields']['name']['stringValue'],
      DateTime.parse(data['fields']['lastPingAt']['timestampValue']));
}
