import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  final String id;
  final String type;
  final String sessionDocumentPath;
  final DateTime lastUpdatedAt;

  Session(this.id, this.type, this.sessionDocumentPath, this.lastUpdatedAt);

  factory Session.fromJson(String str) => _$SessionFromJson(json.decode(str));

  String toJson() => json.encode(_$SessionToJson(this));
}
