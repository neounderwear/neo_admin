import 'dart:typed_data';

abstract class ProductEvent {}

// Produk
class LoadProducts extends ProductEvent {}

class AddProducts extends ProductEvent {
  final Map<String, dynamic> productData;

  AddProducts(this.productData);
}

class UpdateProducts extends ProductEvent {
  final String productId;
  final Map<String, dynamic> productData;

  UpdateProducts(this.productId, this.productData);
}

class DeleteProducts extends ProductEvent {
  final String productId;

  DeleteProducts(this.productId);
}

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
  final String? brand;
  final String? category;
  final List<Map<String, dynamic>> variants;

  SubmitProductForm({
    this.productId,
    required this.name,
    required this.description,
    this.imageUrl,
    this.brand,
    this.category,
    this.variants = const [],
  });
}

class LoadBrands extends ProductEvent {}

class LoadCategories extends ProductEvent {}
