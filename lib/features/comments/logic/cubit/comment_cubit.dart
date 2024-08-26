import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ice_cream/features/comments/data/comment.dart';
import 'package:ice_cream/features/comments/repo/comment_repo.dart';

part 'comment_state.dart';
part 'comment_cubit.freezed.dart';

class CommentCubit extends Cubit<CommentState> {
final CommentsRepo _commentsRepo ;
final TextEditingController commentController = TextEditingController();
  CommentCubit(this._commentsRepo) : super(CommentState.initial());


  void fetchComments() {
    emit(const CommentState.loading());
    try {
      _commentsRepo.getComments().listen(
        (comment) {
          emit(CommentState.success(comment));
        },
      onError: (error) {
          print('Error fetching comments: $error');
          emit(const CommentState.error('Failed to fetch comments.'));
        },
      );
    } catch (e) {
      emit(const CommentState.error('An unexpected error occurred.'));
      print(e.toString());
    }
  }

 
  Future<void> addComment() async {
    if (commentController.text.isNotEmpty) {
      emit(const CommentState.loading());
      try {
        final comment = Comment(
          content: commentController.text,
          timestamp: 'time',
          id: 'id',
          shopId: 'shopId',
          userId: 'shopId',
        );
        await _commentsRepo.addComment(comment);
        commentController.clear(); 
        emit(CommentState.success([comment]));
      } catch (e) {
        emit(const CommentState.error('Failed to add comment.'));
        print('Error adding comment: $e');
      }
    } else {
      emit(const CommentState.error('Comment cannot be empty.'));
    }
  }

  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}