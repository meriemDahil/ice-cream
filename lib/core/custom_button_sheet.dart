import 'package:flutter/material.dart';

class CommentsBottomSheet extends StatelessWidget {
  final int commentsCount;
  final Function(String) onCommentSubmitted;

  const CommentsBottomSheet({
    Key? key,
    required this.commentsCount,
    required this.onCommentSubmitted,
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
            'Comments ($commentsCount)',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2, // replace with actual comments count
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text('Comment name'),
                subtitle: Text('Comment text'),
              );
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Add a comment',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onSubmitted: (value) {
              onCommentSubmitted(value);
              
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
