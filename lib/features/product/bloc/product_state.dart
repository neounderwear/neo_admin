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

class ImageUploadLoadingState extends ProductState {}

class ImageUploadSuccessState extends ProductState {
  final String imageUrl;

  ImageUploadSuccessState(this.imageUrl);
}

class ImageUploadErrorState extends ProductState {
  final String message;

  ImageUploadErrorState(this.message);
}
