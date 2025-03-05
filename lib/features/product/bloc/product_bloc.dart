import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/data/product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  List<Map<String, dynamic>> variantsList = [];
  List<Map<String, dynamic>> brands = [];
  List<Map<String, dynamic>> categories = [];
  String? imageUrl;
  String? currentImageUrl;

  ProductBloc(this.productService) : super(ProductInitial()) {
    // Memuat produk
    on<LoadProducts>((event, emit) async {
      try {
        final products = await productService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menambah produk
    on<AddProducts>((event, emit) async {
      try {
        add(LoadProducts());
        await productService.addProducts(event.productData);
        add(LoadProducts());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Mengubah produk
    on<UpdateProducts>((event, emit) async {
      try {
        add(LoadProducts());
        await productService.updateProducts(event.productId, event.productData);
        add(LoadProducts());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menghapus produk
    on<DeleteProducts>((event, emit) async {
      try {
        add(LoadProducts());
        await productService.deleteProducts(event.productId);
        add(LoadProducts());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Tambah baris varian produk
    on<AddVariantRow>((event, emit) async {
      variantsList.add({
        'name': '',
        'price': 0,
        'reseller_price': 0,
        'sku': '',
        'stock': 0,
        'weight': 0.0,
      });
      emit(VariantRowUpdated(List.from(variantsList)));
    });

    // Hapus baris varian produk
    on<RemoveVariantRow>((event, emit) async {
      if (variantsList.isNotEmpty && event.index < variantsList.length) {
        variantsList.removeAt(event.index);
      }
      emit(VariantRowUpdated(List.from(variantsList)));
    });

    on<UploadProductImage>((event, emit) async {
      try {
        currentImageUrl = await productService.uploadImage(
            'product-images', event.imageBytes);
        emit(ImageUploadSuccess(currentImageUrl!));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Submit Product Form Event
    on<SubmitProductForm>((event, emit) async {
      try {
        // Prepare product data
        final productData = {
          'name': event.name,
          'description': event.description,
          'images': event.imageUrl ?? imageUrl, // Use class-level imageUrl
          'brand': event.brand,
          'category': event.category,
        };

        // Check if it's an update or new product
        if (event.productId != null) {
          // Update existing product
          await productService.updateProductWithVariants(
              event.productId!, productData, event.variants);
        } else {
          // Add new product
          await productService.addProductWithVariants(
              productData, event.variants);

          imageUrl = null;
        }

        // Reload products
        add(LoadProducts());

        // Emit success state
        emit(ProductSubmissionSuccess());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<LoadBrands>((event, emit) async {
      try {
        brands = await productService.fetchBrands();
        emit(BrandsLoaded(brands));
      } catch (e) {
        emit(BrandsError(e.toString()));
      }
    });

    // Load Categories
    on<LoadCategories>((event, emit) async {
      try {
        categories = await productService.fetchCategories();
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });
  }

  // Optional method to get brand/category names easily
  List<String> getBrandNames() {
    return brands.map((brand) => brand['name'] as String).toList();
  }

  List<String> getCategoryNames() {
    return categories.map((category) => category['name'] as String).toList();
  }
}
