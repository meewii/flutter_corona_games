// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    json['hostId'] as String,
    json['session'] == null
        ? null
        : Session.fromJson(json['session'] as String),
    json['roomDocumentPath'] as String,
    json['playersCollectionPath'] as String,
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'hostId': instance.hostId,
      'session': instance.session,
      'roomDocumentPath': instance.roomDocumentPath,
      'playersCollectionPath': instance.playersCollectionPath,
    };
