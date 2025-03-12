import 'package:flutter/material.dart';
import 'package:shm/static/navigation_route.dart';

class InventoryMenu extends StatelessWidget {
  const InventoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, NavigationRoute.inventoryRoute.name);
      },
      icon: const Padding(
        padding: EdgeInsets.only(
          right: 10.0,
          left: 10.0,
        ),
        child: Icon(
          Icons.inbox,
          size: 25,
        ),
      ),
    );
  }
}
