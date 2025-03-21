import 'package:shm/model/product.dart';

sealed class HomeSearchResultState {}

class HomeSearchNoneState extends HomeSearchResultState {}

class HomeSearchLoadingState extends HomeSearchResultState {}

class HomeSearchErrorState extends HomeSearchResultState {
  final String error;

  HomeSearchErrorState(this.error);
}

class HomeSearchLoadedState extends HomeSearchResultState {
  final List<Product> data;

  HomeSearchLoadedState(this.data);
}
