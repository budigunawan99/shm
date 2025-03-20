import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shm/model/product.dart';
import 'package:shm/provider/inventory_provider.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 85,
              minHeight: 85,
              maxWidth: 120,
              minWidth: 120,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: product.imagePath.isNotEmpty
                  ? Hero(
                      tag: product.imagePath.first,
                      child: Image.file(
                        File(product.imagePath.first),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'images/img_default.png',
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                    )
                  : Image.asset("images/img_default.png"),
            ),
          ),
          const SizedBox.square(dimension: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.code,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox.square(dimension: 4),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox.square(dimension: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox.square(dimension: 4),
                    Expanded(
                      child: Text(
                        DateFormat('dd-MM-yyyy').format(product.updated),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                ),
                const SizedBox.square(dimension: 6),
                Row(
                  children: [
                    Icon(
                      Icons.photo,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox.square(dimension: 4),
                    Expanded(
                      child: Text(
                        "${product.imagePath.length.toString()} ${product.imagePath.length > 1 ? 'photos' : 'photo'}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              final inventoryProvider = context.read<InventoryProvider>();
              if (context.mounted) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  barrierDismissible: false,
                  title: "Yakin ingin menghapus?",
                  text: "Data yang sudah dihapus tidak dapat dikembalikan",
                  titleColor: Theme.of(context).colorScheme.onSurface,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  confirmBtnText: "OK",
                  confirmBtnColor: Theme.of(context).colorScheme.primary,
                  cancelBtnText: 'Batal',
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer,
                  onConfirmBtnTap: () async {
                    for (var x in product.imagePath) {
                      await File(x).delete();
                    }
                    await inventoryProvider.removeProductByCode(
                      product.code,
                    );
                    await inventoryProvider.getAllProducts("");
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                );
              }
            },
            icon: Icon(
              Icons.delete_forever,
              size: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
