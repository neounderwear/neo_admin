import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/data/product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _brands = [];
  List<Map<String, dynamic>> _categories = [];

  List<Map<String, dynamic>> variantsList = [];
  String? imageUrl;
  String? currentImageUrl;

  ProductBloc(this.productService) : super(ProductInitial()) {
    // Memuat produk
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        _products = await productService.fetchProducts();
        emit(ProductLoaded(_products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Memuat brand
    on<LoadBrands>((event, emit) async {
      emit(ProductLoading());
      try {
        _brands = await productService.fetchBrands();
        emit(BrandsLoaded(_brands));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Memuat kategori
    on<LoadCategories>((event, emit) async {
      emit(ProductLoading());
      try {
        _categories = await productService.fetchCategories();
        emit(CategoriesLoaded(_categories));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menambah produk
    on<AddProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        await productService.addProduct(
          name: event.name,
          brandId: event.brandId,
          categoryId: event.categoryId,
          imageUrl: event.imageUrl,
          variants: event.variants,
        );
        _products = await productService.fetchProducts();
        emit(ProductSuccess('Berhasil mengupload produk'));
        emit(ProductLoaded(_products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Mengubah produk
    on<UpdateProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        await productService.updateProduct(
          productId: event.productId,
          name: event.name,
          brandId: event.brandId,
          categoryId: event.categoryId,
          imageUrl: event.imageUrl,
          variants: event.variants,
        );
        _products = await productService.fetchProducts();
        emit(ProductSuccess('Berhasil memperbarui produk'));
        emit(ProductLoaded(_products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menghapus produk
    on<DeleteProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        await productService.deleteProduct(event.productId);
        _products = await productService.fetchProducts();
        emit(ProductSuccess('Berhasil menghapus produk'));
        emit(ProductLoaded(_products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    //   // Tambah baris varian produk
    //   on<AddVariantRow>((event, emit) async {
    //     variantsList.add({
    //       'name': '',
    //       'price': 0,
    //       'reseller_price': 0,
    //       'sku': '',
    //       'stock': 0,
    //       'weight': 0.0,
    //     });
    //     emit(VariantRowUpdated(List.from(variantsList)));
    //   });

    //   // Hapus baris varian produk
    //   on<RemoveVariantRow>((event, emit) async {
    //     if (variantsList.isNotEmpty && event.index < variantsList.length) {
    //       variantsList.removeAt(event.index);
    //     }
    //     emit(VariantRowUpdated(List.from(variantsList)));
    //   });

    //   on<UploadProductImage>((event, emit) async {
    //     try {
    //       currentImageUrl = await productService.uploadImage(
    //           'product-images', event.imageBytes);
    //       emit(ImageUploadSuccess(currentImageUrl!));
    //     } catch (e) {
    //       emit(ProductError(e.toString()));
    //     }
    //   });

    //   // Submit Product Form Event
    //   on<SubmitProductForm>((event, emit) async {
    //     try {
    //       // Prepare product data
    //       final productData = {
    //         'name': event.name,
    //         'description': event.description,
    //         'image_url': event.imageUrl ?? imageUrl,
    //       };

    //       // Check if it's an update or new product
    //       if (event.productId != null) {
    //         // Update existing product
    //         await productService.updateProductWithVariants(
    //             event.productId!, productData, event.variants);
    //       } else {
    //         // Add new product
    //         await productService.addProductWithVariants(
    //             productData, event.variants);

    //         imageUrl = null;
    //       }

    //       // Reload products
    //       add(LoadProducts());

    //       // Emit success state
    //       emit(ProductSubmissionSuccess());
    //     } catch (e) {
    //       emit(ProductError(e.toString()));
    //     }
    //   });
  }

  List<Map<String, dynamic>> get products => _products;
  List<Map<String, dynamic>> get brands => _brands;
  List<Map<String, dynamic>> get categories => _categories;
}
