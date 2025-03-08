import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/data/product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _brands = [];
  List<Map<String, dynamic>> _categories = [];

  Future<String> uploadImage(Uint8List imageBytes) async {
    try {
      return await productService.uploadImage('products', imageBytes);
    } catch (e) {
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }

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
          description: event.description!,
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

    on<UploadProductImageEvent>((event, emit) async {
      emit(ImageUploadLoadingState());
      try {
        final imageUrl =
            await productService.uploadImage('products', event.imageBytes);
        emit(ImageUploadSuccessState(imageUrl));
      } catch (e) {
        emit(ImageUploadErrorState('Failed to upload image: ${e.toString()}'));
      }
    });
  }

  List<Map<String, dynamic>> get products => _products;
  List<Map<String, dynamic>> get brands => _brands;
  List<Map<String, dynamic>> get categories => _categories;
}
