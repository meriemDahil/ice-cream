import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';
import 'package:ice_cream/features/shops/repo/shop_list_repo.dart';

part 'shop_list_state.dart';
part 'shop_list_cubit.freezed.dart';
class ShopListCubit extends Cubit<ShopListState> {
  final ShopRepository _shopRepository;

  ShopListCubit(this._shopRepository) : super(const ShopListState.initial());
/*
  there is intersting thing here we can do is by calling  fetchShops within the constructor so that the data is fetched 
  automatically without the calling fetchShops in the init state in the ui 
  so its like 
   ShopListCubit(this._shopRepository) : super(const ShopListState.initial()) {
    fetchShops();   Automatically fetches shops when Cubit is created
  }
*/
  void fetchShops() {
    emit(const ShopListState.loading());
    try {
      _shopRepository.getShops().listen(
        (shops) {
          emit(ShopListState.success(shops));
        },
      onError: (error) {
          print('Error fetching shops: $error');
          emit(const ShopListState.error('Failed to fetch shops.'));
        },
      );
    } catch (e) {
      emit(const ShopListState.error('An unexpected error occurred.'));
      print(e.toString());
    }
  }
}
