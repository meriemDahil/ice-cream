import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/core/app_constants.dart';
import 'package:ice_cream/core/custom_button_sheet.dart';
import 'package:ice_cream/features/comments/logic/cubit/comment_cubit.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenDetails extends StatelessWidget {
  final Shop shopdetail;

  const ScreenDetails({Key? key, required this.shopdetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 241, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shopdetail.name,
                style: const TextStyle(
                  fontFamily: 'DM_Serif_Text',
                  fontSize: 22,
                  color: AppColor.blush,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_pin, color: AppColor.sakura),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () async {
                      String url =
                          'https://www.google.com/maps/search/?api=1&query=${shopdetail.address}';
                      Uri uri = Uri.parse(url);
                      await launchUrl(uri);
                    },
                    child: Expanded(
                      child: Text(
                        shopdetail.address,
                        style: const TextStyle(
                          color: AppColor.moss,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                shopdetail.description,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<CommentCubit, CommentState>(
                builder: (context, state) {
                  if (state is Success) {
                    return GestureDetector(
                      onTap: () => CommentsBottomSheet.show(context),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
