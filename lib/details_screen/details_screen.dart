import 'package:flutter/material.dart';
import 'package:ice_cream/shops/data/shops_model.dart';

class DetailsScreen extends StatelessWidget {
  final Shop shopdetail;
   DetailsScreen({super.key, required this.shopdetail});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(shopdetail.name),
      ),
    );
  }
}