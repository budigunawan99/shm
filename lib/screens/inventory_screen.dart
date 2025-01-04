import 'package:flutter/material.dart';
import 'package:shm/screens/input_data_screen.dart';
import 'package:shm/widgets/appbar.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        isFirstPage: false,
        title: "Manajemen Data",
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const InputDataScreen();
          }));
        },
        tooltip: 'Add Product',
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
