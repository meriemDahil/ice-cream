part of 'comment_cubit.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState.initial() = _Initial;
  const factory CommentState.loading()= Loading;
   const factory CommentState.success(List<Comment>comment)= Success;
   const factory CommentState.error(error)= Error;
}
