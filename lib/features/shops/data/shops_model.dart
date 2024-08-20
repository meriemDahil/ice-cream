import 'package:freezed_annotation/freezed_annotation.dart';

part 'shops_model.freezed.dart';
part 'shops_model.g.dart';

@freezed
class Shop with _$Shop {
  @JsonSerializable(explicitToJson: true)
  factory Shop({
    required String id,
    required String name,
    required String address,
    required String description,
    required String imageUrl,
    required Location location,
    required String openTime,
    required String closeTime,
    String? phone,
    String? website,
    Map<String, String>? socialMedia,
    required int likesCount,
    required int commentsCount,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}

@freezed
class Location with _$Location {
  factory Location({
    required double latitude,
    required double longitude,
    String? city,
    String? state,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}
