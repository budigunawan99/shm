sealed class InventoryActionState {}

class InventoryActionNoneState extends InventoryActionState {}

class InventoryActionLoadingState extends InventoryActionState {}

class InventoryActionErrorState extends InventoryActionState {
  final String error;

  InventoryActionErrorState(this.error);
}

class InventoryActionLoadedState extends InventoryActionState {
  final String message;

  InventoryActionLoadedState(this.message);
}
