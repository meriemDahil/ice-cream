import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/core/app_constants.dart';
import 'package:ice_cream/features/comments/comments_builder.dart';
import 'package:ice_cream/features/likes/logic/cubit/likes_cubit.dart' as likes;
import 'package:ice_cream/features/likes/logic/cubit/likes_cubit.dart';
import 'package:ice_cream/features/likes/ui/likes_widget.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenDetails extends StatefulWidget {
  final Shop shopdetail;

  const ScreenDetails({super.key, required this.shopdetail});

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Container(
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
                         LikesWidget(shopId: widget.shopdetail.id,)
                        ],
                      ),
                      const SizedBox(height: 10.0),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_pin, color: AppColor.sakura),
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
            const SizedBox(height: 10),
            Text(
              widget.shopdetail.description,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.7,
              ),
            ),
            const SizedBox(height: 10),
            CommentsBuilder(shopName: widget.shopdetail.name)
                        ],
                      ),
                    ),
                  ),
                        ),
            ]),
            );
  }
}
