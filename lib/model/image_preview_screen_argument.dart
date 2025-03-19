import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreenArgument {
  final LoadingBuilder? loadingBuilder;
  final List<String> galleryItems;
  final BoxDecoration backgroundDecoration;
  final int initialIndex;
  final Axis scrollDirection;
  final String description;

  ImagePreviewScreenArgument({
    required this.galleryItems,
    required this.backgroundDecoration,
    this.loadingBuilder,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
    this.description = "",
  });
}
