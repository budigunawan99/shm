import 'package:flutter/widgets.dart';
import 'package:shm/data/local/local_database_service.dart';
import 'package:shm/model/product.dart';
import 'package:shm/static/home_search_result_state.dart';

class HomeSearchProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  HomeSearchProvider(this._service);

  HomeSearchResultState _resultState = HomeSearchNoneState();
  HomeSearchResultState get resultState => _resultState;

  Product? _currentProduct;
  Product? get currentProduct => _currentProduct;

  void setProduct(Product product) {
    _currentProduct = product;
    notifyListeners();
  }

  void removeProduct() {
    _currentProduct = null;
    notifyListeners();
  }

  Future<void> searchProducts(String? title) async {
    try {
      _resultState = HomeSearchLoadingState();
      notifyListeners();

      if (title == null || title == "") {
        _resultState = HomeSearchNoneState();
        notifyListeners();
        return;
      }

      final result = await _service.searchItemsByTitle(title);
      _currentProduct = null;

      if (result.isEmpty) {
        _resultState = HomeSearchNoneState();
        notifyListeners();
      } else {
        _resultState = HomeSearchLoadedState(result);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = HomeSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}
