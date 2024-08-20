import 'package:flutter/material.dart';
import 'package:ice_cream/core/app_constants.dart';
import 'package:ice_cream/features/details_screen/details_screen.dart';
import 'package:ice_cream/features/shops/data/shops_model.dart';
import 'package:ice_cream/features/shops/ui/shoop_appbar.dart';

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
                            tileColor: AppColor.champagne,
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image (
                                  image: NetworkImage(shop.imageUrl),
                                  height: 100,
                                  width: 150,
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                    children: [
                                      Text(
                                       shop.name,
                                       style:TextStyle(fontFamily: 'DM_Serif_Text',fontSize: 22),
                                       maxLines: 1, 
                                       overflow: TextOverflow.ellipsis,
                                    //   softWrap: false, // Prevents wrapping to the next line
                                      ),
                                      Row(
                                        children: [
                                          Text(shop.address ),
                                          // Icon(Icons.location_on,size:15),
                                        ],
                                      ),
                                      Text('Open/Close: ${shop.openTime} ${shop.closeTime}', 
                                       maxLines: 1, 
                                       overflow: TextOverflow.ellipsis,
                                      // softWrap: false,
                                       ),
                                    ],
                                  ),
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