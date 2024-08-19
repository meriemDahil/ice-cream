import 'package:flutter/material.dart';
import 'package:ice_cream/details_screen/details_screen.dart';
import 'package:ice_cream/shops/data/shops_model.dart';

class ShopItem extends StatefulWidget {
   final List<Shop> shops;
    ShopItem( {super.key, required this.shops});

  @override
  State<ShopItem> createState() => _ShopItemState();
}
class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final shop = widget.shops[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, 
                          horizontal: 15,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreen(shopdetail:shop)));

                          },
                          child: ListTile(
                            tileColor: const Color.fromARGB(255, 230, 230, 230),
                            subtitle: Row(
                              children: [
                                Image(
                                  image: NetworkImage(shop.imageUrl),
                                  height: 100,
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(shop.name),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on),
                                        Text(shop.address),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Open/Close: '),
                                        Text(shop.openTime),
                                        Text(shop.closeTime),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: widget.shops.length,
                  ),
                ),
              ],
            );      
  }
}