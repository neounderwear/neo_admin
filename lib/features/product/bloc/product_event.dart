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
  final List<int> variantsToDelete;

  UpdateProducts({
    required this.productId,
    required this.name,
    this.description,
    required this.brandId,
    required this.categoryId,
    required this.imageUrl,
    required this.variants,
    required this.variantsToDelete,
  });
}

class DeleteProducts extends ProductEvent {
  final int productId;

  DeleteProducts(this.productId);
}

class LoadBrands extends ProductEvent {}

class LoadCategories extends ProductEvent {}

// Varian produk
class AddVariantRow extends ProductEvent {}

class RemoveVariantRow extends ProductEvent {
  final int index;

  RemoveVariantRow(this.index);
}

class UploadProductImage extends ProductEvent {
  final Uint8List imageBytes;
  UploadProductImage(this.imageBytes);
}

class SubmitProductForm extends ProductEvent {
  final String? productId;
  final String name;
  final String description;
  final String? imageUrl;
  final int? brandId;
  final int? categoryId;
  final List<Map<String, dynamic>> variants;

  SubmitProductForm({
    this.productId,
    required this.name,
    required this.description,
    this.imageUrl,
    this.brandId,
    this.categoryId,
    this.variants = const [],
  });
}
