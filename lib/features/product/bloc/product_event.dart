// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

abstract class ProductEvent {}

// Produk
class LoadProducts extends ProductEvent {}

class AddProducts extends ProductEvent {
  final String name;
  final String? description;
  final int brandId;
  final int categoryId;
  final String imageUrl;
  final List<Map<String, dynamic>> variants;

  AddProducts({
    required this.name,
    this.description,
    required this.brandId,
    required this.categoryId,
    required this.imageUrl,
    required this.variants,
  });
}

class UpdateProducts extends ProductEvent {
  final int productId;
  final String name;
  final String? description;
  final int brandId;
  final int categoryId;
  final String imageUrl;
  final List<Map<String, dynamic>> variants;
  final List<int>? variantsToDelete;

  UpdateProducts({
    required this.productId,
    required this.name,
    this.description,
    required this.brandId,
    required this.categoryId,
    required this.imageUrl,
    required this.variants,
    this.variantsToDelete,
  });
}

class DeleteProducts extends ProductEvent {
  final int productId;

  DeleteProducts(this.productId);
}

class LoadBrands extends ProductEvent {}

class LoadCategories extends ProductEvent {}

class UploadProductImageEvent extends ProductEvent {
  final Uint8List imageBytes;

  UploadProductImageEvent(this.imageBytes);
}
