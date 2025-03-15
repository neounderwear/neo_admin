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
      try {
        _brands = await productService.fetchBrands();
        emit(BrandsLoaded(_brands));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Memuat kategori
    on<LoadCategories>((event, emit) async {
      try {
        _categories = await productService.fetchCategories();
        emit(CategoriesLoaded(_categories));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menambah produk
    // Di ProductBloc, perbaiki handler untuk AddProducts

// Menambah produk
    on<AddProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        // Upload gambar hanya jika tersedia
        String imageUrl = "";
        if (event.imageBytes != null) {
          imageUrl = await productService.uploadImage(
            'product',
            event
                .imageBytes!, // Gunakan operator ! untuk mengkonversi ke non-nullable
          );
        }

        // Kirim data ke service
        await productService.addProduct(
          name: event.name,
          description: event.description ?? '',
          brandId: event.brandId,
          categoryId: event.categoryId,
          imageUrl: imageUrl,
          variants: event.variants,
        );

        // Perbarui data produk
        _products = await productService.fetchProducts();
        emit(ProductSuccess('Berhasil mengupload produk'));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

// Mengubah produk
    on<UpdateProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        // Untuk update product, kita perlu menangani imageBytes dengan benar
        String? imageUrl;
        if (event.imageBytes != null) {
          imageUrl = await productService.uploadImage(
            'product',
            event
                .imageBytes!, // Gunakan operator ! untuk mengkonversi ke non-nullable
          );
        }

        await productService.updateProduct(
          id: event.productId,
          name: event.name,
          description: event.description,
          brandId: event.brandId,
          categoryId: event.categoryId,
          imageUrl: imageUrl, // Menggunakan imageUrl alih-alih imageBytes
          variants: event.variants,
        );

        // Perbarui data produk
        _products = await productService.fetchProducts();
        emit(ProductSuccess('Berhasil memperbarui produk'));
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
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }

  List<Map<String, dynamic>> get products => _products;
  List<Map<String, dynamic>> get brands => _brands;
  List<Map<String, dynamic>> get categories => _categories;
}
