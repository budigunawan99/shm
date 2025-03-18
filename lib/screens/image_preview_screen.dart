import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shm/model/image_preview_screen_argument.dart';
import 'package:shm/widgets/appbar.dart';

class ImagePreviewScreen extends StatefulWidget {
  final ImagePreviewScreenArgument args;

  const ImagePreviewScreen({
    super.key,
    required this.args,
  });

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late PageController pageController;
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.args.initialIndex);
    currentIndex = widget.args.initialIndex;
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        isFirstPage: false,
        title: "Preview",
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: widget.args.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(
                    File(widget.args.galleryItems[index]),
                  ),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale:
                      PhotoViewComputedScale.contained * (0.5 + index / 10),
                  maxScale: PhotoViewComputedScale.covered * 4.1,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.args.galleryItems[index],
                  ),
                );
              },
              itemCount: widget.args.galleryItems.length,
              loadingBuilder: widget.args.loadingBuilder,
              backgroundDecoration: widget.args.backgroundDecoration,
              pageController: pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.args.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
