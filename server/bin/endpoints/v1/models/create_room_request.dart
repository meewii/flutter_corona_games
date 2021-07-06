import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'create_room_request.g.dart';

@JsonSerializable()
class CreateRoomRequest {
  final String hostName;

  CreateRoomRequest(this.hostName);

  factory CreateRoomRequest.fromJson(String str) =>
      _$CreateRoomRequestFromJson(json.decode(str));

  String toJson() => json.encode(_$CreateRoomRequestToJson(this));
}
