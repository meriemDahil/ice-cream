import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ice_cream/features/likes/repo/like_repo.dart';

part 'likes_state.dart';
part 'likes_cubit.freezed.dart';



class LikesCubit extends Cubit<LikesState> {
  final LikesRepository likesRepository;
  

  LikesCubit({
    required this.likesRepository,
    
  }) : super(const LikesState.initial()) {
    _fetchLikesCount();
  }

   late String shopId;

  void _fetchLikesCount() async {
    try {
      likesRepository.getLikesCount(shopId).listen((likesCount) {
        emit(LikesState.likesCountChanged(likesCount));
      });
    } catch (e) {
      emit(LikesState.error(e.toString()));
    }
  }

  Future<void> likeShop() async {
    try {
      await likesRepository.likeShop(shopId);
      emit(const LikesState.updated());
    } catch (e) {
      emit(LikesState.error(e.toString()));
    }
  }

  Future<void> unlikeShop() async {
    try {
      await likesRepository.unlikeShop(shopId);
      emit(const LikesState.updated());
    } catch (e) {
      emit(LikesState.error(e.toString()));
    }
  }
}
