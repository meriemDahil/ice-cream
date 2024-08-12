// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      shopId: json['shopId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      likesCount: (json['likesCount'] as num?)?.toInt(),
      likedBy:
          (json['likedBy'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'userId': instance.userId,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
      'likesCount': instance.likesCount,
      'likedBy': instance.likedBy,
    };
