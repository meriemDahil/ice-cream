import 'package:freezed_annotation/freezed_annotation.dart';

part 'like.freezed.dart';
part 'like.g.dart';

@freezed
class Like with _$Like {
  factory Like({
    required String id,
    required String shopId,
    required String userId,
    required DateTime timestamp,
  }) = _Like;

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);
}
