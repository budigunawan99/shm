import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shm/model/product.dart';
import 'package:shm/provider/inventory_provider.dart';
import 'package:shm/static/inventory_action_state.dart';

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
          Consumer<InventoryProvider>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
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
                      await value.removeProductByCode(
                        product.code,
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                      }

                      switch (value.actionResultState) {
                        case InventoryActionLoadingState():
                          if (context.mounted) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.loading,
                              disableBackBtn: true,
                              barrierDismissible: false,
                              title: "Loading...",
                              text: "Sedang menghapus data",
                              titleColor:
                                  Theme.of(context).colorScheme.onSurface,
                              textColor:
                                  Theme.of(context).colorScheme.onSurface,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                            );
                          }

                        case InventoryActionErrorState(error: var message):
                          if (context.mounted) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              barrierDismissible: false,
                              title: "Error",
                              text: message,
                              titleColor:
                                  Theme.of(context).colorScheme.onSurface,
                              textColor:
                                  Theme.of(context).colorScheme.onSurface,
                              confirmBtnText: "OK",
                              confirmBtnColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                            );
                            value.setActionResultState(
                                InventoryActionNoneState());
                          }

                        case InventoryActionLoadedState(message: var message):
                          for (var x in product.imagePath) {
                            await File(x).delete();
                          }
                          if (context.mounted) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              barrierDismissible: false,
                              title: "Berhasil",
                              text: message,
                              titleColor:
                                  Theme.of(context).colorScheme.onSurface,
                              textColor:
                                  Theme.of(context).colorScheme.onSurface,
                              confirmBtnText: "OK",
                              confirmBtnColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                            );
                            value.setActionResultState(
                                InventoryActionNoneState());
                          }
                          await value.getAllProducts("");

                        default:
                          break;
                      }
                    },
                  );
                },
                icon: Icon(
                  Icons.delete_forever,
                  size: 25,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
