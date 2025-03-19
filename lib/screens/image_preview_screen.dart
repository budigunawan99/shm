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
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(
                    File(widget.args.galleryItems[index]),
                  ),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
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
            Positioned(
              top: 15,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Gambar ${currentIndex + 1} dari ${widget.args.galleryItems.length.toString()}",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(
                  alpha: 0.6,
                ),
              ),
              child: Text(
                widget.args.description,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
