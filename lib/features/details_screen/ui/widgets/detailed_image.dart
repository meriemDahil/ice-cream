import 'package:flutter/material.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';

class DetailedImage extends StatelessWidget {
  final Shop shopdetail;
   DetailedImage({super.key, required this.shopdetail});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
              child: Container(
                height: 340,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Image.network(
                 shopdetail.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
  }
}