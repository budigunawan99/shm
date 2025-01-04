import 'package:flutter/material.dart';
import 'package:shm/screens/inventory_screen.dart';

class InventoryMenu extends StatelessWidget {
  const InventoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const InventoryScreen();
        }));
      },
      icon: const Padding(
        padding: EdgeInsets.only(
          right: 10.0,
          left: 10.0,
        ),
        child: Icon(
          Icons.input,
          size: 25,
        ),
      ),
    );
  }
}
