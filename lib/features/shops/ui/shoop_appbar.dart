import 'package:flutter/material.dart';

class IceCreamAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IceCreamAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Ice cream',
        style: TextStyle(fontFamily: 'DM_Serif_Text'),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://as1.ftcdn.net/v2/jpg/05/16/27/58/1000_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg',
            ),
            radius: 23,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}