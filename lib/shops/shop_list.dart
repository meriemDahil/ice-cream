

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/shops/logic/cubit/shop_list_cubit.dart';
class ShopList extends StatefulWidget {

  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ShopListCubit>().fetchShops();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocBuilder<ShopListCubit, ShopListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('initializing...')),
      
            loading: () => const Center(child: CircularProgressIndicator()),
            
            success: (shops) => ListView.builder(
              itemCount: shops.length,
              itemBuilder: (context, index) {
                final shop = shops[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                      tileColor: Color.fromARGB(255, 230, 230, 230),
                      subtitle: Row( 
                       //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(image: NetworkImage(shop.imageUrl,),height: 100,),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(shop.name),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text(shop.address),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Open/Close: '),
                                  Text(shop.openTime ),
                                  Text(shop.closeTime),
                                ],
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                );
              },
            ),    
            error: (error) => Center(child: Text('Error: fetching  data $error')),
          );
        },
      ),
    );
  }
}
