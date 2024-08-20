import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';

class ShopRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Shop> _shopRef;
  ShopRepository() {
    _shopRef = _firestore.collection('ShopList').withConverter<Shop>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data();
        if (data == null) {
          throw Exception('No data found in snapshot');
        }
        return Shop.fromJson(data);
      },
      toFirestore: (shop, _) => shop.toJson(),
    );
  }
  Stream<List<Shop>> getShops() {
    try {
      return _shopRef.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print('Error getting shop list: $e');
      return Stream.error(e);
    }
  }
}
