import 'package:neo_admin/features/product/data/product_model.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class LoadProductById extends ProductEvent {
  final int id;

  LoadProductById(this.id);
}

class AddProducts extends ProductEvent {
  final Product product;

  AddProducts(this.product);
}

class UpdateProducts extends ProductEvent {
  final Product product;

  UpdateProducts(this.product);
}

class DeleteProducts extends ProductEvent {
  final int id;

  DeleteProducts(this.id);
}
