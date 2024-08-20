import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/firebase_options.dart';
import 'package:ice_cream/features/map/map_integration.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ShopListCubit(ShopRepository()),
        child: const ShopList(),
      ),
    );
  }
}
