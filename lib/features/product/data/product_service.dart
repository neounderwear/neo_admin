import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:neo_admin/app/supabase_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final supabase = Supabase.instance.client;
  final Dio dio = Dio();

  // Fungsi untuk fetch data produk dari tabel products
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await supabase
        .from('products')
        .select('id, name, image_url, product_variants(price, stock)')
        .order('id', ascending: true);
    return response;
  }

  // Fungsi untuk fetch varian produk berdasarkan id
  Future<List<Map<String, dynamic>>> fetchVariants(String productId) async {
    final response = await supabase
        .from('product_variants')
        .select('*')
        .eq('product_id', productId);
    return response;
  }

  // Fungsi untuk menambah produk ke tabel products
  Future<void> addProducts(Map<String, dynamic> productData) async {
    await supabase.from('products').insert(productData);
  }

  // Fungsi untuk mengubah produk di tabel products
  Future<void> updateProducts(
    String productId,
    Map<String, dynamic> productData,
  ) async {
    await supabase.from('products').update(productData).eq('id', productId);
  }

  // Fungsi untuk menghapus produk dari tabel products
  Future<void> deleteProducts(String productId) async {
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

  // Fungsi untuk mengupload produk dengan varian
  Future<String> addProductWithVariants(Map<String, dynamic> productData,
      List<Map<String, dynamic>> variants) async {
    try {
      final response = await supabase
          .from('products')
          .insert(productData)
          .select('id')
          .single();

      final productId = response['id'];

      // Add variants with product ID
      final variantsWithProductId = variants.map((variant) {
        return {
          ...variant,
          'product_id': productId,
        };
      }).toList();

      // Insert variants
      await supabase.from('product_variants').insert(variantsWithProductId);

      return productId;
    } catch (e) {
      rethrow;
    }
  }

  // Update product with variants
  Future<void> updateProductWithVariants(
      String productId,
      Map<String, dynamic> productData,
      List<Map<String, dynamic>> variants) async {
    try {
      // Update product
      await supabase.from('products').update(productData).eq('id', productId);

      // Delete existing variants
      await supabase
          .from('product_variants')
          .delete()
          .eq('product_id', productId);

      // Add new variants
      final variantsWithProductId = variants.map((variant) {
        return {
          ...variant,
          'product_id': productId,
        };
      }).toList();

      // Insert new variants
      await supabase.from('product_variants').insert(variantsWithProductId);
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Brands
  Future<List<Map<String, dynamic>>> fetchBrands() async {
    try {
      final response = await dio.get(
        '${SupabaseHelper().url}/rest/v1/brands',
        options: Options(headers: {
          'apiKey': SupabaseHelper().anonKey,
          'Authorization': 'Bearer ${SupabaseHelper().anonKey}',
        }),
      );
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      return [];
    }
  }

  // Fetch Categories
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final response = await dio.get(
        '${SupabaseHelper().url}/rest/v1/categories',
        options: Options(headers: {
          'apiKey': SupabaseHelper().anonKey,
          'Authorization': 'Bearer ${SupabaseHelper().anonKey}',
        }),
      );
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      return [];
    }
  }
}
