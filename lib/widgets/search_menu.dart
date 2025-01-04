import 'package:flutter/material.dart';

class SearchMenu extends StatelessWidget {
  const SearchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Padding(
        padding: EdgeInsets.only(
          right: 10.0,
          left: 10.0,
        ),
        child: Icon(
          Icons.search,
          size: 25,
        ),
      ),
    );
  }
}
