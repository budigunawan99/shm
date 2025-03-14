import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shm/provider/input_image_provider.dart';

class InputImageGrid extends StatefulWidget {
  const InputImageGrid({super.key});

  @override
  State<InputImageGrid> createState() => _InputImageGridState();
}

class _InputImageGridState extends State<InputImageGrid> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    List<String> selectedImages =
        context.watch<InputImageProvider>().selectedImages;
    if (selectedImages.isEmpty) {
      return SliverToBoxAdapter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: const Icon(Icons.add_a_photo),
              ),
              onTap: () {
                getImages();
              },
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      );
    }
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: selectedImages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return InkWell(
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: const Icon(Icons.add_a_photo),
            ),
            onTap: () {
              getImages();
            },
          );
        }
        final displaySelectedImages = File(selectedImages[index - 1]);
        return Image.file(
          displaySelectedImages,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        );
      },
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    final String localPath = (await getApplicationDocumentsDirectory()).path;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        final fileName = path.basename(xfilePick[i].path);
        final File savedImage =
            await File(xfilePick[i].path).copy("$localPath/$fileName");

        print(savedImage.path);
        context.read<InputImageProvider>().setSelectedImages(savedImage.path);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }
}
