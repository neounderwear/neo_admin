abstract class ProductState {}

// Produk States
class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Map<String, dynamic>> products;

  ProductLoaded(this.products);
}

class BrandsLoaded extends ProductState {
  final List<Map<String, dynamic>> brands;

  BrandsLoaded(this.brands);
}

class CategoriesLoaded extends ProductState {
  final List<Map<String, dynamic>> categories;

  CategoriesLoaded(this.categories);
}

class ProductSuccess extends ProductState {
  final String message;

  ProductSuccess(this.message);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

// Image Upload States
class ImageUploadSuccess extends ProductState {
  final String imageUrl;

  ImageUploadSuccess(this.imageUrl);
}

// Variant States
class VariantRowUpdated extends ProductState {
  final List<Map<String, dynamic>> variants;

  VariantRowUpdated(this.variants);
}

// Product Submission States
class ProductSubmissionSuccess extends ProductState {}

// Detail Product State
class ProductDetailLoaded extends ProductState {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> variants;

  ProductDetailLoaded({required this.product, required this.variants});
}
