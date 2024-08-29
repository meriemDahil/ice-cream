
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/features/likes/logic/cubit/likes_cubit.dart';


class LikesWidget extends StatefulWidget {
  final String shopId;
  const LikesWidget({super.key, required this.shopId});

  @override
  State<LikesWidget> createState() => _LikesWidgetState();
}

class _LikesWidgetState extends State<LikesWidget> {
  bool isLiked= false ;
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LikesCubit, LikesState>(
      builder: (context, state) {
        if (state is Changed) {
          return Row(
            children: [
              Text('${state.likesCount}'),
              IconButton(
                onPressed: () {
                  isLiked? 
                  context.read<LikesCubit>().likeShop()
                  : context.read<LikesCubit>().unlikeShop();
                },
                icon: Icon(
                  Icons.star_outline_sharp,
                  color: 
                          isLiked
                      ? Colors.yellow
                      : Colors.grey,
                  size: 30,
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
}
}