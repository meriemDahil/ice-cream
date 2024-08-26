import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/core/app_constants.dart';
import 'package:ice_cream/core/custom_button_sheet.dart';
import 'package:ice_cream/features/comments/logic/cubit/comment_cubit.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsScreen extends StatefulWidget {
  final Shop shopdetail;
  DetailsScreen({super.key, required this.shopdetail});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isLiked = false;
  late Shop updatedShopDetail;

  @override
  void initState() {
    super.initState();
    updatedShopDetail = widget.shopdetail;
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
                                Text('${updatedShopDetail.likesCount}'),
                                IconButton(
                                  onPressed: () {
                                //    _toggleLike();
                                    print(widget.shopdetail.likesCount);
                                  },
                                  icon: Icon(
                                    Icons.star_outline_sharp,
                                    color:
                                        isLiked ? Colors.yellow : Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            )
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
                        BlocBuilder<CommentCubit, CommentState>(
                          builder: (context, state) {
                            return state.when(
                              initial: () => const Center(child: Text('Initializing...')),
                              loading: () => const Center(child: CircularProgressIndicator()),
                              success: (shops) => GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                  ),
                                  builder: (context) {
                                    return CommentsBottomSheet(
                                      commentsCount: widget.shopdetail.commentsCount,
                                      onCommentSubmitted: (comment) {
                                        context.read<CommentCubit>().addComment();
                                        print('New comment: $comment');
                                    
                                      },
                                    );
                                  },
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Comments (${widget.shopdetail.commentsCount})',
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                              error: (error) => Center(
                                child: Text('Error: fetching data $error'),
                              ),
                            );
                          },
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
}
