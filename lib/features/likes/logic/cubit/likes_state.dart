part of 'likes_cubit.dart';

@freezed
class LikesState with _$LikesState {
  const factory LikesState.initial() = _Initial;
  const factory LikesState.updated() = Success;
  const factory LikesState.likesCountChanged(int likesCount) = Changed;
  const factory LikesState.error(String message) = Error;
}