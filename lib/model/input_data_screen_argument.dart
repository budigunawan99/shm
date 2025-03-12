import 'package:shm/model/product.dart';
import 'package:shm/static/action_page.dart';

class InputDataScreenArgument {
  final ActionPage actionPage;
  final Product? product;

  InputDataScreenArgument({
    required this.actionPage,
    this.product,
  });
}
