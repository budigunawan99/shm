import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shm/model/image_preview_screen_argument.dart';
import 'package:shm/provider/home_search_provider.dart';
import 'package:shm/static/home_search_result_state.dart';
import 'package:shm/static/navigation_route.dart';
import 'package:shm/widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      onSearchTextChanged("");
      context.read<HomeSearchProvider>().removeProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        isFirstPage: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Consumer<HomeSearchProvider>(
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      15,
                      5,
                      15,
                      22,
                    ),
                    child: SearchAnchor(
                      viewOnChanged: onSearchTextChanged,
                      builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                          hintText: 'Ketik nama produk',
                          onTapOutside: (e) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          controller: controller,
                          padding: const WidgetStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                          trailing: <Widget>[
                            Tooltip(
                              message: 'Clear text',
                              child: IconButton(
                                icon: const Icon(Icons.cancel_outlined),
                                iconSize: 22,
                                onPressed: () {
                                  controller.clear();
                                  onSearchTextChanged("");
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        return switch (value.resultState) {
                          HomeSearchLoadingState() => List<ListTile>.generate(
                              2,
                              (int index) {
                                return ListTile(
                                  title: Text(
                                    "Loading...",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                );
                              },
                            ),
                          HomeSearchErrorState(error: var message) =>
                            List<ListTile>.generate(
                              1,
                              (int index) {
                                return ListTile(
                                  title: Text(
                                    message,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                );
                              },
                            ),
                          HomeSearchLoadedState(data: var productList) =>
                            List<ListTile>.generate(
                              productList.length,
                              (int index) {
                                final product = productList[index];
                                return ListTile(
                                  leading: Text(
                                    product.code,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  title: Text(
                                    product.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      value.setProduct(product);
                                      controller.closeView(product.title);
                                    });
                                  },
                                );
                              },
                            ),
                          _ => List<ListTile>.generate(
                              1,
                              (int index) {
                                return ListTile(
                                  title: Text(
                                    "Tidak ada data yang ditemukan",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                );
                              },
                            ),
                        };
                      },
                    ),
                  ),
                ),
              ),
              if (value.currentProduct == null) ...[
                SliverToBoxAdapter(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/empty.png',
                            height: 250,
                          ),
                          const SizedBox.square(dimension: 8),
                          Text(
                            "Gambar tidak tersedia. Silahkan masukkan data terlebih dahulu.",
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ] else ...[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    12,
                    15,
                    12,
                    10,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      value.currentProduct!.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 0,
                  ),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: value.currentProduct?.imagePath.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NavigationRoute.imagePreviewRoute.name,
                            arguments: ImagePreviewScreenArgument(
                              description: value.currentProduct!.description,
                              galleryItems: value.currentProduct!.imagePath,
                              backgroundDecoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              initialIndex: index,
                              loadingBuilder: (context, event) => Center(
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    value: event == null ||
                                            event.expectedTotalBytes == null
                                        ? 0
                                        : event.cumulativeBytesLoaded /
                                            event.expectedTotalBytes!,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: value.currentProduct!.imagePath[index],
                          child: Image.file(
                            File(value.currentProduct!.imagePath[index]),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'images/img_default.png',
                                fit: BoxFit.fitWidth,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              ]
            ],
          );
        },
      ),
    );
  }

  Future onSearchTextChanged(String text) async {
    context.read<HomeSearchProvider>().searchProducts(text);
  }
}
