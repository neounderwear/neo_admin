import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final supabase = Supabase.instance.client;

  // fetch produk
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await supabase
        .from('products')
        .select('*')
        .order('created_at', ascending: false);
    return response;
  }

  // fetch varian produk by id
  Future<List<Map<String, dynamic>>> fetchVariants(String productId) async {
    final response = await supabase
        .from('product_variants')
        .select('*')
        .eq('product_id', productId);
    return response;
  }

  // tambah produk
  Future<void> addProducts(Map<String, dynamic> productData) async {
    await supabase.from('products').insert(productData);
  }

  // update produk
  Future<void> updateProducts(
      String productId, Map<String, dynamic> productData) async {
    await supabase.from('products').update(productData).eq('id', productId);
  }

  // delete produk
  Future<void> deleteProducts(String productId) async {
    await supabase.from('products').delete().eq('id', productId);
  }

  // upload image
  Future<String> uploadImage(String path, Uint8List fileBytes) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    await supabase.storage
        .from('product-images')
        .uploadBinary(fileName, fileBytes);
    return supabase.storage.from('product-images').getPublicUrl(fileName);
  }

  Future<String> addProductWithVariants(Map<String, dynamic> productData,
      List<Map<String, dynamic>> variants) async {
    try {
      // Start a transaction
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

  // Contoh pengambilan data di service
  Future<List<Map<String, dynamic>>> fetchBrands() async {
    try {
      final response = await supabase.from('brands').select('brand_name');

      print('Brands from Supabase: $response');
      return response;
    } catch (e) {
      print('Error fetching brands: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final response =
          await supabase.from('categories').select('category_name');

      print('Brands from Supabase: $response');
      return response;
    } catch (e) {
      print('Error fetching brands: $e');
      return [];
    }
  }
}
