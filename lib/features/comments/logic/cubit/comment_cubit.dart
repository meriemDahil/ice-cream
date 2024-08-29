import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ice_cream/features/comments/data/comment.dart';
import 'package:ice_cream/features/comments/repo/comment_repo.dart';

part 'comment_state.dart';
part 'comment_cubit.freezed.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentsRepo _commentsRepo;
  final TextEditingController commentController = TextEditingController();

  CommentCubit(this._commentsRepo) : super(CommentState.initial());

  void fetchComments() {
    _commentsRepo.getComments().listen(
      (comments) {
        emit(CommentState.success(comments));
      },
      onError: (error) {
        print('Error fetching comments: $error');
        emit(const CommentState.error('Failed to fetch comments.'));
      },
    );
  }

  Future<void> addComment(String shopId) async {
    if (commentController.text.isNotEmpty) {
      emit(const CommentState.loading());
      try {
        final comment = Comment(
          content: commentController.text,
          timestamp: DateTime.now(),
          shopId: shopId,
          userId: 'userId',
        );
        await _commentsRepo.addComment(comment);
        commentController.clear();

        // Fetch the updated comments list
        fetchComments();
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

