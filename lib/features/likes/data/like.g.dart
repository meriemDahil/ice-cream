// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikeImpl _$$LikeImplFromJson(Map<String, dynamic> json) => _$LikeImpl(
      id: json['id'] as String,
      shopId: json['shopId'] as String,
      userId: json['userId'] as String,
      timestamp:
          const TimestampConverter().fromJson(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$$LikeImplToJson(_$LikeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'userId': instance.userId,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
