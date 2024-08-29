import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/features/comments/logic/cubit/comment_cubit.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';


class CommentsBottomSheet extends StatelessWidget {
  final Color backgroundColor;
  final double borderRadius;
  final TextStyle titleStyle;
  final double maxHeight;
  final InputDecoration? inputDecoration;
  final String shopId ;

  const CommentsBottomSheet({
    super.key,
    this.backgroundColor = Colors.white,
    this.borderRadius = 25.0,
    this.titleStyle = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    this.maxHeight = 300.0,
    this.inputDecoration,
    required this.shopId,
  });

  static void show(BuildContext context, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child:  CommentsBottomSheet(shopId: name,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, controller) {
          return BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) {
              if (state is Success) {
                return _buildSuccessContent(context, state, controller,);
              } else if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text('Failed to load comments'));
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context, Success state, ScrollController controller) {
      final text = state.comment.isEmpty
        ? 'No comments found (${state.comment.length})'
        : 'Comments (${state.comment.length})';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:Text(text, style: titleStyle),
        ),
        Expanded(
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              _buildCommentsList(state),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildCommentInput(context),
        ),
      ],
    );
  }

  Widget _buildCommentsList(Success state) {
    if (state.comment.isEmpty) {
      return SizedBox(height: maxHeight, child: Center(child: Text('No comments yet')));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.comment.length,
      itemBuilder: (context, index) {
        final comment = state.comment[index];
        return ListTile(
          title: Text(comment.content),
          subtitle: Text('${comment.timestamp}'),
        );
      },
    );
  }

  Widget _buildCommentInput(BuildContext context) {
    return TextField(
      controller: context.read<CommentCubit>().commentController,
      decoration: inputDecoration ?? InputDecoration(
        labelText: 'Add a comment',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onSubmitted: (value) {
        context.read<CommentCubit>().addComment(shopId);
        print (shopId);
      },
    );
  }
}