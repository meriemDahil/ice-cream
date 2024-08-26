
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ice_cream/features/comments/data/comment.dart';

const String TodoCollection = 'comments';

class FirebaseSevices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Comment> _todoRef;

  FirebaseSevices() {
    _todoRef = _firestore.collection(TodoCollection).withConverter<Comment>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data();
            if (data == null) {
              throw Exception('No data found in snapshot');
            }
            return Comment.fromJson(data);
          },
          toFirestore: (todo, _) => todo.toJson(),
        );
  }

  Stream<QuerySnapshot<Comment>> getTodos() {
    try {
      return _todoRef.snapshots();
    } catch (e) {
      print('Error getting todos: $e');
      // Optionally, you could return an empty stream or rethrow the exception
      return Stream.error(e);
    }
  }

  Future<void> addTodo(Comment todo) async {
    try {
      await _todoRef.add(todo);
      print('comment added succesfully');
    } catch (e) {
      print('Error adding comment: $e');
    }
  }
  void updateToDo(String todoId , Comment todo){
    _todoRef.doc(todoId).update(todo.toJson());
  }
  void deleteTodo(String todoId){
    _todoRef.doc(todoId).delete();
  }

}
