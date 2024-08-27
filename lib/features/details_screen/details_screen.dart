import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/core/app_constants.dart';
import 'package:ice_cream/features/comments/data/comment.dart';
import 'package:ice_cream/features/comments/logic/cubit/comment_cubit.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final Shop shopdetail;

  const DetailsScreen({super.key, required this.shopdetail});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    context.read<CommentCubit>().fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 340,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Image.network(
                  widget.shopdetail.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 290,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 241, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.shopdetail.name,
                              style: const TextStyle(
                                fontFamily: 'DM_Serif_Text',
                                fontSize: 22,
                                color: AppColor.blush,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.7,
                              ),
                            ),
                            Row(
                              children: [
                                Text('${widget.shopdetail.likesCount}'),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.star_outline_sharp,
                                    color: isLiked ? Colors.yellow : Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: AppColor.sakura,
                            ),
                            const SizedBox(width: 10.0),
                            GestureDetector(
                              onTap: () async {
                                String url =
                                    'https://www.google.com/maps/search/?api=1&query=${widget.shopdetail.address}';
                                Uri uri = Uri.parse(url);
                                await launchUrl(uri);
                              },
                              child: Text(
                                widget.shopdetail.address,
                                style: const TextStyle(
                                  color: AppColor.moss,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.shopdetail.description,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7,
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocListener<CommentCubit, CommentState>(
                          listener: (context, state) {
                            if (state is Success) {
                              _showCommentsBottomSheet(context, state.comment);
                            }
                          },
                          child: const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context, List<Comment> comments) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comments (${comments.length})',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 300, 
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      title: Text(comment.content),
                      subtitle: Text(comment.timestamp),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: context.read<CommentCubit>().commentController,
                decoration: InputDecoration(
                  labelText: 'Add a comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onSubmitted: (value) {
                  context.read<CommentCubit>().addComment();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
