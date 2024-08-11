import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

part 'shops_model.freezed.dart';
part 'shops_model.g.dart';

@freezed
class Shop with _$Shop {
  @JsonSerializable(explicitToJson: true) // Add explicitToJson: true if you have nested objects
  factory Shop({
    required String id,
    required String name,
    required String address,
    required String description,
    required String imageUrl,
    @GeoPointConverter() required GeoPoint location, // Use the custom converter here
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


class GeoPointConverter implements JsonConverter<GeoPoint, Map<String, dynamic>> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(
      json['latitude'] as double,
      json['longitude'] as double,
    );
  }

  @override
  Map<String, dynamic> toJson(GeoPoint geoPoint) {
    return {
      'latitude': geoPoint.latitude,
      'longitude': geoPoint.longitude,
    };
  }
}
