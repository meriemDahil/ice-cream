
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ice_cream/features/comments/data/comment.dart';

class CommentsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Comment> _commentRef;

  CommentsRepo() {
    _commentRef = _firestore.collection('comments').withConverter<Comment>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data();
            if (data == null) {
              throw Exception('No data found in snapshot');
            }
            return Comment.fromJson(data);
          },
          toFirestore: (comment, _) => comment.toJson(),
        );
  }

  Stream<List<Comment>> getComments() {
    try {
      return _commentRef.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print('Error getting comment list: $e');
      return Stream.error(e);
    }
  }

  Future<void> addComment(Comment comment) async {
    try {
      await _commentRef.add(comment);
      print('comment added succesfully');
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  void updateComment(String commentId , Comment comment){
    _commentRef.doc(commentId).update(comment.toJson());
  }
  
  void deleteComment(String commentId){
    _commentRef.doc(commentId).delete();
  }

}
