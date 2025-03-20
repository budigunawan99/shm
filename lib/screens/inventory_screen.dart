import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shm/model/input_data_screen_argument.dart';
import 'package:shm/provider/inventory_provider.dart';
import 'package:shm/static/action_page.dart';
import 'package:shm/static/inventory_list_result_state.dart';
import 'package:shm/static/navigation_route.dart';
import 'package:shm/widgets/appbar.dart';
import 'package:shm/widgets/product_list_item.dart';
import 'package:shm/widgets/skeleton_loading.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      onSearchTextChanged("");
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: TextField(
                  controller: _searchController,
                  onTapOutside: (e) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                    border: InputBorder.none,
                    hintText: 'Ketik nama produk',
                    hintStyle: Theme.of(context).textTheme.labelLarge,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      iconSize: 22,
                      onPressed: () {
                        _searchController.clear();
                        onSearchTextChanged("");
                      },
                    ),
                  ),
                  onChanged: onSearchTextChanged,
                ),
              ),
            ),
          ),
          Consumer<InventoryProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                InventoryListLoadingState() => Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height -
                          3.5 * kToolbarHeight,
                      child: const SkeletonLoading(count: 10),
                    ),
                  ),
                InventoryListLoadedState(data: var productList) => SizedBox(
                    height: MediaQuery.of(context).size.height -
                        3.5 * kToolbarHeight,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 1.0,
                        thickness: 0.5,
                      ),
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = productList[index];
                        return InkWell(
                          child: ProductListItem(product: product),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.inputDataRoute.name,
                              arguments: InputDataScreenArgument(
                                actionPage: ActionPage.edit,
                                product: product,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                InventoryListErrorState(error: var message) => Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/nodata.png',
                            height: 300,
                          ),
                          const SizedBox.square(dimension: 8),
                          Text(
                            message,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                _ => Center(
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
                            "Data produk masih kosong.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
              };
            },
          ),
        ],
      ),
    );
  }

  Future onSearchTextChanged(String text) async {
    context.read<InventoryProvider>().getAllProducts(text);
  }
}
