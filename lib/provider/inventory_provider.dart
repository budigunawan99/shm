import 'package:flutter/widgets.dart';
import 'package:shm/data/local/local_database_service.dart';
import 'package:shm/model/product.dart';
import 'package:shm/static/inventory_action_state.dart';
import 'package:shm/static/inventory_list_result_state.dart';

class InventoryProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  InventoryProvider(this._service);

  InventoryListResultState _resultState = InventoryListNoneState();
  InventoryListResultState get resultState => _resultState;

  InventoryActionState _actionResultState = InventoryActionNoneState();
  InventoryActionState get actionResultState => _actionResultState;

  void setActionResultState(InventoryActionState value) {
    _actionResultState = value;
    notifyListeners();
  }

  Future<void> getAllProducts(String? title) async {
    try {
      _resultState = InventoryListLoadingState();
      notifyListeners();

      List<Product> result = <Product>[];
      if (title == null || title == "") {
        result = await _service.getAllItems();
      } else {
        result = await _service.searchItemsByTitle(title);
      }

      if (result.isEmpty) {
        _resultState = InventoryListNoneState();
        notifyListeners();
      } else {
        _resultState = InventoryListLoadedState(result);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = InventoryListErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> saveProduct(Product product) async {
    try {
      _actionResultState = InventoryActionLoadingState();
      notifyListeners();

      final result = await _service.insertItem(product);
      final isError = result == 0;

      if (isError) {
        _actionResultState = InventoryActionErrorState(
          "Yahh, data anda gagal tersimpan!",
        );
        notifyListeners();
      } else {
        _actionResultState = InventoryActionLoadedState(
          "Yeayy, data anda berhasil disimpan!",
        );
        notifyListeners();
      }
    } on Exception catch (e) {
      _actionResultState = InventoryActionErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> editProductByCode(String code, Product product) async {
    try {
      _actionResultState = InventoryActionLoadingState();
      notifyListeners();

      final result = await _service.updateItem(code, product);
      final isError = result == 0;

      if (isError) {
        _actionResultState = InventoryActionErrorState(
          "Yahh, data anda gagal diedit!",
        );
        notifyListeners();
      } else {
        _actionResultState = InventoryActionLoadedState(
          "Yeayy, data anda berhasil diperbarui!",
        );
        notifyListeners();
      }
    } on Exception catch (e) {
      _actionResultState = InventoryActionErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> removeProductByCode(String code) async {
    try {
      _actionResultState = InventoryActionLoadingState();
      notifyListeners();

      final result = await _service.removeItem(code);
      if (result != 1) {
        _actionResultState = InventoryActionErrorState(
          "Yahh, data anda gagal dihapus!",
        );
        notifyListeners();
      } else {
        _actionResultState = InventoryActionLoadedState(
          "Yeay, data anda berhasil dihapus!",
        );
        notifyListeners();
      }
    } on Exception catch (e) {
      _actionResultState = InventoryActionErrorState(e.toString());
      notifyListeners();
    }
  }
}
