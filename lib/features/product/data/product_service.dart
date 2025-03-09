import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient supabase;

  ProductService(this.supabase);

  // Fungsi untuk fetch semua produk dari tabel products
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await supabase
        .from('products')
        .select(
          '*, brands(id, brand_name),categories(id, category_name),product_variants(*)',
        )
        .order('created_at', ascending: false);
    return response;
  }

  // Fungsi untuk fetch single produk dengan variannya
  Future<Map<String, dynamic>> fetchProductById(int productId) async {
    final response = await supabase
        .from('products')
        .select(
          '*, brands(id, brand_name),categories(id, category_name),product_variants(*)',
        )
        .eq('id', productId)
        .single();
    return response;
  }

  // Fungsi untuk menambah produk dan varian ke tabel products
  Future<Map<String, dynamic>> addProduct({
    required String name,
    required String description,
    required int brandId,
    required int categoryId,
    required String imageUrl,
    required List<Map<String, dynamic>> variants,
  }) async {
    try {
      final productResponse = await supabase
          .from('products')
          .insert({
            'name': name,
            'description': description,
            'brand_id': brandId,
            'category_id': categoryId,
            'image_url': imageUrl
          })
          .select()
          .single();

      final productId = productResponse['id'];

      if (variants.isNotEmpty) {
        for (var variant in variants) {
          await supabase.from('product_variants').insert({
            'product_id': productId,
            'name': variant['name'],
            'price': variant['price'],
            'discount_price': variant['discount_price'],
            'reseller_price': variant['reseller_price'],
            'sku': variant['sku'],
            'stock': variant['stock'],
            'weight': variant['weight'],
          });
        }
      }
      return fetchProductById(productId);
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi untuk mengubah produk di tabel products
  Future<Map<String, dynamic>> updateProduct({
    required int id,
    required String name,
    String? description,
    required int brandId,
    required int categoryId,
    Uint8List? imageBytes,
    required List<Map<String, dynamic>> variants,
  }) async {
    try {
      final Map<String, dynamic> updateData = {
        'name': name,
        'description': description,
        'brand_id': brandId,
        'category_id': categoryId,
        'updated_at': DateTime.now().toIso8601String(),
      };
      if (imageBytes != null) {
        final imageUrl = await uploadImage('/products$id', imageBytes);
        updateData['image_url'] = imageUrl;
      }
      await supabase.from('products').update(updateData).eq('id', id);

      final existingVariants = await supabase
          .from('product_variants')
          .select('id')
          .eq('product_id', id);

      final existingVariantIds = existingVariants.map((v) => v['id']).toList();
      final updatedVariantIds = variants
          .where((v) => v.containsKey('id'))
          .map((v) => v['id'])
          .toList();

      // Menghapus varian yang tidak ada lagi
      for (var variantId in existingVariantIds) {
        if (!updatedVariantIds.contains(variantId)) {
          await supabase.from('product_variants').delete().eq('id', variantId);
        }
      }

      // Memperbarui atau menambah varian
      for (var variant in variants) {
        if (variant.containsKey('id')) {
          // Update varian yang sudah ada
          await supabase.from('product_variants').update({
            'name': variant['name'],
            'price': variant['price'],
            'discount_price': variant['discount_price'],
            'reseller_price': variant['reseller_price'],
            'sku': variant['sku'],
            'stock': variant['stock'],
            'weight': variant['weight'],
            'updated_at': DateTime.now().toIso8601String(),
          }).eq('id', variant['id']);
        } else {
          // Membuat varian baru
          await supabase.from('product_variants').insert({
            'product_id': id,
            'name': variant['name'],
            'price': variant['price'],
            'discount_price': variant['discount_price'],
            'reseller_price': variant['reseller_price'],
            'sku': variant['sku'],
            'stock': variant['stock'],
            'weight': variant['weight'],
          });
        }
      }

      return await fetchProductById(id);
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi untuk menghapus produk dari tabel products
  Future<void> deleteProduct(int productId) async {
    await supabase
        .from('product_variants')
        .delete()
        .eq('product_id', productId);
    await supabase.from('products').delete().eq('id', productId);
  }

  // Fungsi untuk mengupload gambar ke storage product-images
  Future<String> uploadImage(String path, Uint8List fileBytes) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    await supabase.storage
        .from('product-images')
        .uploadBinary(fileName, fileBytes);
    return supabase.storage.from('product-images').getPublicUrl(fileName);
  }

  // Fungsi untuk fetch data merek dari tabel brands
  Future<List<Map<String, dynamic>>> fetchBrands() async {
    final response =
        await supabase.from('brands').select('*').order('brand_name');
    return response;
  }

  // Fungsi untuk fetch data merek dari tabel brands
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response =
        await supabase.from('categories').select('*').order('category_name');
    return response;
  }
}
