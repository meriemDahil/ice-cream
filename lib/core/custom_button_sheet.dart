import 'package:flutter/material.dart';


class CustomBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? submitButton;
  final TextEditingController? commentController;
  final Function(String)? onCommentSubmitted;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.children,
    this.submitButton,
    this.commentController,
    this.onCommentSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          ...children,
          const SizedBox(height: 10.0),
          if (commentController != null && onCommentSubmitted != null)
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onSubmitted: onCommentSubmitted,
            ),
          if (submitButton != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: submitButton!,
            ),
        ],
      ),
    );
  }
}