import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ice_cream/features/likes/repo/like_repo.dart';

part 'likes_state.dart';
part 'likes_cubit.freezed.dart';

class LikesCubit extends Cubit<LikesState> {
  final LikesRepository _likesRepository;

  LikesCubit(this._likesRepository) : super(LikesState.initial());

  Stream<int> getLikesCount(String shopId) {
    return _likesRepository.getLikesCount(shopId);
  }

  Future<void> likeShop(String shopId) async {
    try {
      await _likesRepository.likeShop(shopId);
      emit(LikesState.updated());
    } catch (e) {
      emit(LikesState.error(e.toString()));
    }
  }

  Future<void> unlikeShop(String shopId) async {
    try {
      await _likesRepository.unlikeShop(shopId);
      emit(LikesState.updated());
    } catch (e) {
      emit(LikesState.error(e.toString()));
    }
  }
}
