import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shm/model/image_preview_screen_argument.dart';
import 'package:shm/screens/inventory_screen.dart';
import 'package:shm/static/navigation_route.dart';
import 'package:shm/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        isFirstPage: true,
      ),
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
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
                  builder: (BuildContext context, SearchController controller) {
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
                            onPressed: () {},
                          ),
                        ),
                      ],
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(
                      5,
                      (int index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(item),
                          // onTap: () {
                          //   setState(() {
                          //     controller.closeView(item);
                          //   });
                          // },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          // productList.isEmpty
          //     ? SliverToBoxAdapter(
          //         child: Center(
          //           child: SingleChildScrollView(
          //             padding: const EdgeInsets.all(20),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Image.asset(
          //                   'images/empty.png',
          //                   height: 250,
          //                 ),
          //                 const SizedBox.square(dimension: 8),
          //                 Text(
          //                   "Gambar tidak tersedia. Silahkan masukkan data terlebih dahulu.",
          //                   style: Theme.of(context).textTheme.bodyLarge,
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
          //     : SliverPadding(
          //         padding: const EdgeInsets.fromLTRB(
          //           12,
          //           15,
          //           12,
          //           10,
          //         ),
          //         sliver: SliverToBoxAdapter(
          //           child: Text(
          //             productList[0].description,
          //             style: Theme.of(context).textTheme.bodyMedium,
          //           ),
          //         ),
          //       ),
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 10,
          //     horizontal: 0,
          //   ),
          //   sliver: SliverGrid.builder(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 5,
          //       mainAxisSpacing: 5,
          //     ),
          //     itemCount: productList[0].imagePath.length,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //         onTap: () {
          //           Navigator.pushNamed(
          //             context,
          //             NavigationRoute.imagePreviewRoute.name,
          //             arguments: ImagePreviewScreenArgument(
          //               description: productList[0].description,
          //               galleryItems: productList[0].imagePath,
          //               backgroundDecoration: const BoxDecoration(
          //                 color: Colors.black,
          //               ),
          //               initialIndex: index,
          //               loadingBuilder: (context, event) => Center(
          //                 child: SizedBox(
          //                   width: 20.0,
          //                   height: 20.0,
          //                   child: CircularProgressIndicator(
          //                     value: event == null ||
          //                             event.expectedTotalBytes == null
          //                         ? 0
          //                         : event.cumulativeBytesLoaded /
          //                             event.expectedTotalBytes!,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //         child: Hero(
          //           tag: productList[0].imagePath[index],
          //           child: Image.file(
          //             File(productList[0].imagePath[index]),
          //             height: 100,
          //             width: 100,
          //             fit: BoxFit.cover,
          //             alignment: Alignment.center,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
