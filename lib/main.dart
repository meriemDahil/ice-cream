import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/features/comments/logic/cubit/comment_cubit.dart';
import 'package:ice_cream/features/comments/repo/comment_repo.dart';
import 'package:ice_cream/features/likes/logic/cubit/likes_cubit.dart';
import 'package:ice_cream/features/likes/repo/like_repo.dart';
import 'package:ice_cream/firebase_options.dart';
import 'package:ice_cream/features/shops/logic/cubit/shop_list_cubit.dart';
import 'package:ice_cream/features/shops/repo/shop_list_repo.dart';
import 'package:ice_cream/features/shops/shop_list.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ShopRepository(),
        ),
        RepositoryProvider(
          create: (context) => CommentsRepo(),
        ),
         RepositoryProvider(
          create: (context) => LikesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopListCubit(context.read<ShopRepository>()),
          ),
          BlocProvider<CommentCubit>(
            create: (context) => CommentCubit(context.read<CommentsRepo>()),
          ),
          BlocProvider<LikesCubit>(
            create: (context) => LikesCubit(likesRepository: context.read<LikesRepository>(), ),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  ShopList(),
        ),
      ),
    );
  }
}
