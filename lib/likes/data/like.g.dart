// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikeImpl _$$LikeImplFromJson(Map<String, dynamic> json) => _$LikeImpl(
      id: json['id'] as String,
      shopId: json['shopId'] as String,
      userId: json['userId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LikeImplToJson(_$LikeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'userId': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
    };
