import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/core/custom_button_sheet.dart';
import 'package:ice_cream/features/comments/logic/cubit/comment_cubit.dart';

class CommentsBuilder extends StatelessWidget {
  final String shopName;
  const CommentsBuilder({super.key, required this.shopName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
                builder: (context, state) {
                  if (state is Success) {
                    return GestureDetector(
                      onTap: () => CommentsBottomSheet.show(context, shopName),
                      child: Text(
                        "Show Comments (${state.comment.length})",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  } else if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
  }
}