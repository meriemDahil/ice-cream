part of 'shop_list_cubit.dart';

@freezed
class ShopListState with _$ShopListState {
  const factory ShopListState.initial() = _Initial;
  const factory ShopListState.loading()= Loading;
   const factory ShopListState.success(List<Shop>shops)= Success;
   const factory ShopListState.error(error)= Error;

}