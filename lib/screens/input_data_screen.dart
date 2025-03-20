import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shm/model/input_data_screen_argument.dart';
import 'package:shm/model/product.dart';
import 'package:shm/provider/input_image_provider.dart';
import 'package:shm/provider/inventory_provider.dart';
import 'package:shm/static/inventory_action_state.dart';
import 'package:shm/widgets/appbar.dart';
import 'package:shm/widgets/input_image_grid.dart';

class InputDataScreen extends StatefulWidget {
  final InputDataScreenArgument args;

  const InputDataScreen({
    super.key,
    required this.args,
  });

  @override
  State<InputDataScreen> createState() => _InputDataScreenState();
}

class _InputDataScreenState extends State<InputDataScreen> {
  String _code = "";
  String _title = "";
  String _description = "";

  late final TextEditingController _codeController = TextEditingController();
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _descriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    print("Test ${widget.args.actionPage.isEdit}");

    if (widget.args.actionPage.isEdit) {
      _code = widget.args.product?.code ?? "";
      _title = widget.args.product?.title ?? "";
      _description = widget.args.product?.description ?? "";

      _codeController.text = _code;
      _titleController.text = _title;
      _descriptionController.text = _description;

      Future.microtask(() {
        List<String>? path = widget.args.product?.imagePath ?? <String>[];
        context.read<InputImageProvider>().setAllImages(path);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        isFirstPage: false,
        title: "Input Data",
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kode Produk",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      counterStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: null,
                    maxLength: 20,
                    onChanged: (value) {
                      _code = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Nama Produk",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        counterStyle: Theme.of(context).textTheme.labelLarge),
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: null,
                    maxLength: 20,
                    onChanged: (value) {
                      _title = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Deskripsi Produk",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        counterStyle: Theme.of(context).textTheme.labelLarge),
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: null,
                    maxLength: 50,
                    onChanged: (value) {
                      _description = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tambah Gambar",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const InputImageGrid(),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Consumer<InventoryProvider>(
                    builder: (context, value, child) {
                      return TextButton(
                        onPressed: () async {
                          final inputImageProvider =
                              context.read<InputImageProvider>();
                          if (_code == "" ||
                              _title == "" ||
                              _description == "" ||
                              inputImageProvider.selectedImages.isEmpty) {
                            if (context.mounted) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                barrierDismissible: false,
                                text: "Isi formnya terlebih dahulu",
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
                            }
                            return;
                          }

                          if (widget.args.actionPage.isEdit) {
                            final product = Product(
                              code: _code,
                              title: _title,
                              description: _description,
                              created: widget.args.product?.created ??
                                  DateTime.now(),
                              updated: DateTime.now(),
                              imagePath: inputImageProvider.selectedImages,
                            );

                            await value.editProductByCode(_code, product);
                          } else {
                            final product = Product(
                              code: _code,
                              title: _title,
                              description: _description,
                              created: DateTime.now(),
                              updated: DateTime.now(),
                              imagePath: inputImageProvider.selectedImages,
                            );
                            await value.saveProduct(product);
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
                                  text: "Sedang menyimpan data",
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
                              }
                              value.setActionResultState(
                                  InventoryActionNoneState());

                            case InventoryActionLoadedState(
                                message: var message
                              ):
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
                                  onConfirmBtnTap: () async {
                                    await value.getAllProducts("");
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              }
                              value.setActionResultState(
                                  InventoryActionNoneState());

                            default:
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          switch (value.resultState) {
                            InventoryActionLoadingState() => 'Loading ...',
                            _ => 'Simpan',
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
