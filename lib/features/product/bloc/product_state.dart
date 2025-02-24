import 'package:neo_admin/features/product/data/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> product;

  ProductLoaded(this.product);
}

class SingleProductLoaded extends ProductState {
  final Product product;

  SingleProductLoaded(this.product);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
