import 'package:cloud_firestore/cloud_firestore.dart';

class LikesRepository {
  LikesRepository();
  

  Future<void> likeShop(String shopId) async {
    await FirebaseFirestore.instance.collection('ShopList').doc(shopId).update({
      'likesCount': FieldValue.increment(1),
    });
  }

  Future<void> unlikeShop(String shopId) async {
    await FirebaseFirestore.instance.collection('ShopList').doc(shopId).update({
      'likesCount': FieldValue.increment(-1),
    });
  }

  Stream<int> getLikesCount(String shopId) {
    return FirebaseFirestore.instance.collection('ShopList').doc(shopId).snapshots().map((doc) {
      return doc.data()?['likesCount'] ?? 0;
    });
  }
}
