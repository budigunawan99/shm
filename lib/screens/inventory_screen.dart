import 'package:flutter/material.dart';
import 'package:shm/model/input_data_screen_argument.dart';
import 'package:shm/model/product.dart';
import 'package:shm/static/action_page.dart';
import 'package:shm/static/navigation_route.dart';
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
          Navigator.pushNamed(
            context,
            NavigationRoute.inputDataRoute.name,
            arguments: InputDataScreenArgument(
              actionPage: ActionPage.add,
            ),
          );
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

final List<Product> productList = [
  Product(
    code: "xytwrsd",
    title: "Bingkai kenangan",
    description: "Produk bingkai kenangan",
    created: DateTime.now(),
    updated: DateTime.now(),
    imagePath: [
      "/data/user/0/com.example.shm/app_flutter/scaled_IMG-20250112-WA0037(1).jpg",
    ],
  ),
];
