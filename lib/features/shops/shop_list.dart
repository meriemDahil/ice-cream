

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ice_cream/features/shops/logic/cubit/shop_list_cubit.dart';
import 'package:ice_cream/features/shops/ui/shoop_appbar.dart';
import 'package:ice_cream/features/shops/ui/shop_item.dart';
class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  void initState() {
    super.initState();
    context.read<ShopListCubit>().fetchShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IceCreamAppBar(),
      body: BlocBuilder<ShopListCubit, ShopListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initializing...')),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (shops) => ShopItem(shops:shops),
             error: (error) => Center(
              child: Text('Error: fetching data $error'),
            ),
    );
}
 ),
   );
  }
}