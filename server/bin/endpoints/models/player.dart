import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  final String id;
  final String name;
  final DateTime lastPingAt;

  Player(this.id, this.name, this.lastPingAt);

  factory Player.fromJson(String str) => _$PlayerFromJson(json.decode(str));

  String toJson() => json.encode(_$PlayerToJson(this));
}
