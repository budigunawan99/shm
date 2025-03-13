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
      "/9j/4QBqRXhpZgAATU0AKgAAAAgABAEAAAQAAAABAAAD6AEBAAQAAAABAAACM4dpAAQAAAABAAAAPgESAAMAAAABAAAAAAAAAAAAAZIIAAMAAAABAAAAAAAAAAAAAQESAAMAAAABAAAAAAAAAAD/4AAQSkZJRgABAQAAAQABAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAIzA+gDASIAAhEBAxEB/8QAHwAAAAYDAQEBAAAAAAAAAAAABAUGBwgJAgMKAAEL/8QAQhAAAwEAAQQBBAICAgEDAAAXAQIDBAUGERITBwgUISIAIwkVMTIWJDNBChdCJVEYNENhcRkmUic2Yig1RVNUofH/xAAeAQAABwEBAQEAAAAAAAAAAAABAgMEBQYHAAgJCv/EAE8RAAIBAgQEBAMGBAMGBQIBDQECEQMhAAQSMQUiQVEGE2FxMoGRBxRCobHwI1LB0RUz4QgWJGJy8TRDc4KykrPCoiUmNWN0g8NEU1SjxP/aAAwDAQACEQMRAD8AuFxoayzSoWBS9bLME/10W8VKhgQyBFefft7Vel6+TFQB/E3egfRoKDtNqM6n89uyfkeH/TyVQfEBu5YEDuGPf+KziwJmOefczQMU8qebBA6MlVcEdwfap8wp/san7OUchO6ommrSigFTZ3Q9wP8ApIhgAzrMeTTdh2YlfKirUq69vMZEWJ+IksY3gKFMd4ABiASJgTGPSHf2t6mRb6EmfSOuNeSb0wXcPWcuy+x1P5agpIksC/i0l8aDw7p39oJIJ8f4VQLlqoy9mAfx/QhW/ayeQ8fIHyDToyAeaFfEjufAqnAgfjNcif8AqXXwZvyzqsmKt+HRmPYgKCinzDM",
    ],
  ),
];
