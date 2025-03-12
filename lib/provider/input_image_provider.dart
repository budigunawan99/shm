import 'package:flutter/widgets.dart';

class InputImageProvider extends ChangeNotifier {
  final List<String> _selectedImages = [];

  List<String> get selectedImages => _selectedImages;

  void setSelectedImages(String images) {
    _selectedImages.add(images);
    notifyListeners();
  }

  void setAllImages(List<String> images) {
    _selectedImages.addAll(images);
    notifyListeners();
  }
}
