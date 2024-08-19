import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ice_cream/shops/data/shops_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final Shop shopdetail;
   DetailsScreen({super.key, required this.shopdetail});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
 bool isLiked = false;
  late Shop updatedShopDetail;
 

  @override
  void initState() {
    super.initState();
    updatedShopDetail = widget.shopdetail;
  }
   Future<void> _updateLikesCountInBackend(int newLikesCount) async {
    try {
      await FirebaseFirestore.instance
          .collection('ShopList')
          .doc(updatedShopDetail.id)
          .update({'likesCount': newLikesCount});
    } catch (e) {
      print('Error updating likes count: $e');
      print(updatedShopDetail.id);
    }
  }

  void _toggleLike()async {
    setState(() {
      isLiked = !isLiked;
      final newLikesCount = isLiked
          ? updatedShopDetail.likesCount + 1
          : updatedShopDetail.likesCount - 1;
      updatedShopDetail = updatedShopDetail.copyWith(likesCount: newLikesCount);
    });
    await _updateLikesCountInBackend(updatedShopDetail.likesCount);
  }
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 320,
                width: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Image.network(
                  widget.shopdetail.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 300,
              child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
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
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.7,
                              ),
                            ),                        
                          Row(
                            children: [
                              Text('${updatedShopDetail.likesCount}'),
                              IconButton(
                               onPressed: (){
                                    _toggleLike();
                                      print(widget.shopdetail.likesCount);
                                    
                                
                               }, 
                               icon: Icon(Icons.star_outline_sharp,
                               color:isLiked ? Colors.yellow : Colors.grey,
                               size:30)),
                            ],
                          )
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                         Row(
                          children: [
                            const Icon(Icons.location_pin),
                                  GestureDetector(
                                    onTap: () async {
                                        String url = 'https://www.google.com/maps/search/?api=1&query=${widget.shopdetail.address}';
                                        Uri uri = Uri.parse(url);
                                        await launchUrl(uri);
                              },
                                                        child:  Text(
                                                          widget.shopdetail.address,
                                                          style: const TextStyle(
                                                            color: Color.fromARGB(255, 4, 129, 56),
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.w500,
                                                            letterSpacing: 0.7,
                                                          ),
                                                        ),
                                                              ),
                                                              
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                        Text(
                          widget.shopdetail.description,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7,
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}