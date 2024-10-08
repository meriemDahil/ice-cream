// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shops_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopImpl _$$ShopImplFromJson(Map<String, dynamic> json) => _$ShopImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      socialMedia: (json['socialMedia'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      likesCount: (json['likesCount'] as num).toInt(),
      commentsCount: (json['commentsCount'] as num).toInt(),
    );

Map<String, dynamic> _$$ShopImplToJson(_$ShopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'location': instance.location.toJson(),
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'phone': instance.phone,
      'website': instance.website,
      'socialMedia': instance.socialMedia,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
    };

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      city: json['city'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'state': instance.state,
    };
