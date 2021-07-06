// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    json['id'] as String,
    json['type'] as String,
    json['sessionDocumentPath'] as String,
    DateTime.parse(json['lastUpdatedAt'] as String),
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'sessionDocumentPath': instance.sessionDocumentPath,
      'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
    };
