import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    required String id,
    required String shopId,
    required String userId,
    required String content,
    required DateTime timestamp,
    int? likesCount, // The number of likes the comment has received (optional).
    List<String>? likedBy, 
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
