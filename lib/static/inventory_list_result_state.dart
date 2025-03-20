import 'package:shm/model/product.dart';

sealed class InventoryListResultState {}

class InventoryListNoneState extends InventoryListResultState {}

class InventoryListLoadingState extends InventoryListResultState {}

class InventoryListErrorState extends InventoryListResultState {
  final String error;

  InventoryListErrorState(this.error);
}

class InventoryListLoadedState extends InventoryListResultState {
  final List<Product> data;

  InventoryListLoadedState(this.data);
}
