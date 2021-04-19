// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['lastUpdatedAt'] as String),
    json['hostId'] as String,
    json['sessionId'] as String?,
    json['sessionType'] as String?,
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
      'hostId': instance.hostId,
      'sessionId': instance.sessionId,
      'sessionType': instance.sessionType,
    };
