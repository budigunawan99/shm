import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImageGrid extends StatefulWidget {
  const InputImageGrid({super.key});

  @override
  State<InputImageGrid> createState() => _InputImageGridState();
}

class _InputImageGridState extends State<InputImageGrid> {
  List<File> selectedImages = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (selectedImages.isEmpty) {
      return InkWell(
        child: Container(
          width: double.infinity,
          height: 140,
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
      );
    }
    return GridView.builder(
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
              height: 200,
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
          );
        }
        final displaySelectedImages = selectedImages[index - 1];
        return kIsWeb
            ? Image.network(
                displaySelectedImages.path,
                height: 100,
                width: 100,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              )
            : Image.file(
                displaySelectedImages,
                height: 100,
                width: 100,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              );
      },
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
