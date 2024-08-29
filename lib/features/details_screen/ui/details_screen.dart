import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/features/comments/logic/cubit/comment_cubit.dart';
import 'package:ice_cream/features/details_screen/ui/widgets/detailed_image.dart';
import 'package:ice_cream/features/details_screen/ui/widgets/screen_details.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';


class DetailsScreen extends StatefulWidget {
  final Shop shopdetail;

  const DetailsScreen({super.key, required this.shopdetail});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommentCubit>().fetchComments();  // Fetch comments when the screen is initialized
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
            DetailedImage(shopdetail: widget.shopdetail),
            Positioned(
              top: 290,
              left: 0,
              right: 0,
              bottom: 0,
              child: ScreenDetails(shopdetail: widget.shopdetail),
            ),
          ],
        ),
      ),
    );
  }
}
